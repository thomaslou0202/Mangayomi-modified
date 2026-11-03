"""Exercise release publication without contacting GitHub or uploading files."""
import contextlib
import hashlib
import io
import json
import os
from pathlib import Path
import runpy
import tempfile
import unittest
from unittest.mock import patch
import urllib.error
import urllib.parse
import zipfile

SCRIPT = Path(__file__).resolve().parents[1] / 'scripts/publish-app-release.py'


class ReleasePublicationTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.config = {'tag': 'v0.9.10+132', 'version': '0.9.10', 'build': 132,
                       'source': 'a' * 40, 'androidAsset': 'Mangayomi-android.apk',
                       'windowsAsset': 'Mangayomi-windows.zip'}
        (self.root / 'app-release.json').write_text(json.dumps(self.config))
        for name in ['dist/android', 'dist/windows', 'release-support']:
            (self.root / name).mkdir(parents=True)
        (self.root / 'release-support/RELEASE-NOTES.md').write_text('Release 132')
        (self.root / 'dist/android/LICENSE.Mangayomi.txt').write_text('License')
        for platform in ['android', 'windows']:
            with zipfile.ZipFile(self.root / 'dist' / platform / self.config[platform + 'Asset'], 'w') as z:
                for name in ['mangayomi.exe', 'data/app.so', 'LICENSE.Mangayomi.txt']:
                    z.writestr(name, b'fixture')
        self.calls = []
        self.release = {'id': 7, 'tag_name': self.config['tag'], 'draft': True,
                        'prerelease': False, 'assets': [],
                        'html_url': 'https://github.com/thomaslou0202/Mangayomi-modified/releases/tag/v0.9.10+132',
                        'upload_url': 'https://uploads.github.com/repos/test/releases/7/assets{?name,label}'}

    def fake_api(self, req, timeout):
        method = req.get_method()
        uri = urllib.parse.urlparse(req.full_url)
        self.calls.append((method, uri.path))
        if '/releases/tags/' in uri.path:
            raise urllib.error.HTTPError(req.full_url, 404, 'Draft tag is not public', {}, None)
        if method == 'GET' and uri.path.endswith('/releases'):
            data = [self.release]
        elif method == 'POST' and uri.path.endswith('/assets'):
            name = urllib.parse.parse_qs(uri.query)['name'][0]
            data = {'name': name, 'state': 'uploaded', 'size': len(req.data),
                    'digest': 'sha256:' + hashlib.sha256(req.data).hexdigest()}
            self.release['assets'].append(data)
        elif method == 'PATCH' and uri.path.endswith('/releases/7'):
            self.release.update(json.loads(req.data))
            data = self.release
        else:
            self.fail('Unexpected API operation: ' + method + ' ' + req.full_url)
        return io.BytesIO(json.dumps(data).encode())

    def run_publisher(self):
        previous = Path.cwd()
        os.chdir(self.root)
        try:
            with patch.dict(os.environ, {'GITHUB_REPOSITORY': 'thomaslou0202/Mangayomi-modified', 'GH_TOKEN': 'test-only'}), \
                    patch('urllib.request.urlopen', self.fake_api), contextlib.redirect_stdout(io.StringIO()):
                runpy.run_path(str(SCRIPT), run_name='__main__')
        finally:
            os.chdir(previous)

    def test_missing_platform_prevents_all_remote_changes(self):
        (self.root / 'dist/android/Mangayomi-android.apk').unlink()
        with self.assertRaises(AssertionError):
            self.run_publisher()
        self.assertEqual(self.calls, [])

    def test_private_draft_is_resumed_when_tag_lookup_returns_404(self):
        self.run_publisher()
        self.assertFalse(self.release['draft'])
        self.assertFalse(self.release['prerelease'])
        self.assertEqual(self.release['make_latest'], 'true')
        self.assertEqual(len(self.release['assets']), 6)
        self.assertNotIn(('POST', '/repos/thomaslou0202/Mangayomi-modified/releases'), self.calls)
        self.assertEqual(self.calls[-1][0], 'PATCH')

    def test_existing_asset_digest_mismatch_never_publishes(self):
        self.release['assets'] = [{'name': 'Mangayomi-android.apk', 'state': 'uploaded',
                                  'size': (self.root / 'dist/android/Mangayomi-android.apk').stat().st_size,
                                  'digest': 'sha256:' + '0' * 64}]
        with self.assertRaisesRegex(AssertionError, 'digest mismatch'):
            self.run_publisher()
        self.assertTrue(self.release['draft'])
        self.assertFalse(any(method in ['POST', 'PATCH'] for method, _ in self.calls))


if __name__ == '__main__':
    unittest.main()
