"""Publish a stable release only after both platform jobs succeed."""
import hashlib
import json
import os
from pathlib import Path
import urllib.error
import urllib.parse
import urllib.request
import zipfile

REPO = 'thomaslou0202/Mangayomi-modified'
assert os.environ['GITHUB_REPOSITORY'] == REPO
CONFIG = json.loads(Path('app-release.json').read_text())
BASE = 'https://api.github.com/repos/' + REPO
HEADERS = {'Authorization': 'Bearer ' + os.environ['GH_TOKEN'],
           'Accept': 'application/vnd.github+json',
           'X-GitHub-Api-Version': '2022-11-28'}


def request(url, method='GET', data=None, content_type='application/json'):
    headers = dict(HEADERS)
    if data is not None:
        headers['Content-Type'] = content_type
    req = urllib.request.Request(url, data=data, headers=headers, method=method)
    with urllib.request.urlopen(req, timeout=300) as response:
        return json.load(response)


files = []
for platform in ['android', 'windows']:
    p = Path('dist') / platform / CONFIG[platform + 'Asset']
    assert p.is_file(), str(p)
    with zipfile.ZipFile(p) as archive:
        assert archive.testzip() is None
        if platform == 'windows':
            assert {'mangayomi.exe', 'data/app.so', 'LICENSE.Mangayomi.txt'} <= set(archive.namelist())
    files.append((p.name, p.read_bytes(),
                  'application/vnd.android.package-archive' if platform == 'android' else 'application/zip'))
checksums = ''.join(hashlib.sha256(b).hexdigest() + '  ' + n + '\n' for n, b, _ in files)
files.append(('SHA256SUMS.txt', checksums.encode(), 'text/plain'))
notes = Path('release-support/RELEASE-NOTES.md').read_bytes()
files.append(('INSTALL-zh-TW.md', notes, 'text/markdown'))
files.append(('release.json', json.dumps(CONFIG, indent=2).encode(), 'application/json'))
license_path = Path('dist/android/LICENSE.Mangayomi.txt')
files.append(('LICENSE.Mangayomi.txt', license_path.read_bytes(), 'text/plain'))

try:
    release = request(BASE + '/releases/tags/' + urllib.parse.quote(CONFIG['tag'], safe=''))
except urllib.error.HTTPError as error:
    if error.code != 404:
        raise
    # GitHub's tag lookup can return 404 for an unpublished draft, even to its
    # owner. List drafts before creating so interrupted uploads are resumable.
    releases = request(BASE + '/releases?per_page=100')
    release = next((r for r in releases if r['tag_name'] == CONFIG['tag']), None)
if release is None:
    release = request(BASE + '/releases', 'POST', json.dumps({
        'tag_name': CONFIG['tag'], 'target_commitish': CONFIG['source'],
        'name': 'Mangayomi 繁體中文插圖版 ' + CONFIG['version'] + '+' + str(CONFIG['build']),
        'body': notes.decode('utf-8'), 'draft': True, 'prerelease': False,
        'make_latest': 'false',
    }).encode())

for name, data, content_type in files:
    expected = 'sha256:' + hashlib.sha256(data).hexdigest()
    asset = next((a for a in release['assets'] if a['name'] == name), None)
    if asset is None:
        assert release['draft'], 'Never modify an already published release'
        upload = release['upload_url'].split('{')[0] + '?name=' + urllib.parse.quote(name)
        asset = request(upload, 'POST', data, content_type)
    assert asset['state'] == 'uploaded' and asset['size'] == len(data)
    assert asset['digest'] == expected, 'Release asset digest mismatch: ' + name
    print('Verified ' + name + ' ' + expected)

if release['draft']:
    release = request(BASE + '/releases/' + str(release['id']), 'PATCH', json.dumps({
        'draft': False, 'prerelease': False, 'make_latest': 'true',
    }).encode())
assert not release['draft'] and not release['prerelease']
print('Published ' + release['html_url'])
