# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Mangayomi 客製版（`thomaslou0202/Mangayomi-modified`）：以上游 `kodjodevf/mangayomi` 為基礎的 Flutter App，可閱讀漫畫、小說與觀看動畫，正式支援 Windows 與 Android。擴充套件庫在另一個倉庫（`thomaslou0202/Mangayomi-Plugins`，本機為 `D:\Mangayomi\plugins`）。

## 語言

- 回覆使用者、commit 訊息（標題與內文）都用繁體中文；程式識別字、路徑照原樣。
- 每次回答開頭用'早安'開始
- 程式碼註解維持英文，風格是說明「為什麼」，常連帶說明舊寫法出過什麼問題。

## 常用指令

本機用 Flutter 3.47.9（與 CI 相同），執行前把它放進 PATH：`D:\Mangayomi\build-tools\flutter-3.47.9\bin`（Windows 建置另需 `D:\Mangayomi\build-tools\nuget` 與 `%USERPROFILE%\.cargo\bin`）。

```powershell
flutter pub get --enforce-lockfile
flutter gen-l10n                                  # 改了 lib/l10n/*.arb 之後
dart run build_runner build --delete-conflicting-outputs   # 改了 @riverpod 或 Isar @collection 之後
flutter_rust_bridge_codegen generate              # 改了 rust/src/api 之後
dart analyze                                      # CI 用的檢查
flutter test test/services/first_batch_fixes_test.dart              # 單一檔案
flutter test test/services/first_batch_fixes_test.dart --plain-name "cookies"   # 單一測試
flutter test test/core/architecture/architecture_test.dart          # 架構邊界檢查
flutter build windows --release --build-name=<版號> --build-number=<組建編號>
```

- `*.g.dart`、`lib/l10n/generated/`、`lib/src/rust/frb_generated*.dart` 都有提交進 Git，改了來源就要重新產生並一起提交。
- 全套 `flutter test` 本來就有一批既有失敗（architecture、design literals、memory overlay、nav rail、Tachiyomi 動畫匯入）。判斷有沒有造成回歸時，要和修改前的結果比對，不要只看有沒有失敗。CI 只跑 `.github/workflows/app-release.yml` 裡列出的回歸測試。
- 用到真實資料庫的測試會呼叫 `Isar.initializeIsarCore(download: true)`，開新的 Isar 實例並指定給 `app.isar`，`tearDown` 先 `await dbWriteQueue.whenIdle()` 再關閉。
- `packages/shiori` 單獨分析與測試（`cd packages/shiori && flutter test`），根目錄的分析會略過它、`widgetbook/` 和 `lib/services/http/rhttp/`（內嵌的 rhttp）。

## 本機安裝與發行

- 本機 Windows 建置完成後，直接取代 `D:\Mangayomi\Windows`（先確認 `mangayomi.exe` 沒在執行，如果在執行中就直接終止程式，舊資料夾移到 `D:\Mangayomi\build-tools` 備份），不要叫使用者從 `build\windows\x64\runner\Release` 執行。書庫不在程式目錄。
- 版號要和 `pubspec.yaml` 一致（例如 `0.9.95+149`），否則 App 內的更新檢查會提供較舊版本。
- 發行流程：更新 `pubspec.yaml` 版號 → 提交 → 在 `app-release.json` 填入該 commit、版號、組建編號，並更新 `release-support/RELEASE-NOTES.md` → 推送到 `main` → 手動執行 GitHub Actions「Release custom Mangayomi」。資產名稱固定為 `Mangayomi-android.apk` 與 `Mangayomi-windows.zip`；App 只接受本倉庫、非草稿、非預覽版的 Release（`parseAppRelease()`）。
- Android 套件 ID 為 `com.kodjodevf.mangayomi.illustrations`，必須維持同一組簽章才能覆蓋更新。

## 架構

完整規則見 `docs/architecture/ARCHITECTURE.md`（由 `test/core/architecture/architecture_test.dart` 自動檢查），UI 規範見 `docs/design/DESIGN.md`。重點：

- **四層、由上往下依賴**：`lib/modules`、`lib/router`（介面）→ `lib/providers`（跨功能 Riverpod 狀態）→ `lib/repositories`、`lib/services`、`lib/eval`（資料與服務）→ `lib/models`、`lib/utils`、`lib/l10n`。下層不能 import `lib/modules` 或 `lib/main.dart`；repository 不能用 Riverpod；`WidgetRef` 只留在 widget 裡。`manga`／`anime`／`novel` 模組彼此不互相 import，共用的閱讀器邏輯放 `lib/modules/reader_common/`。`lib/modules` 單檔上限 1,400 行。
- **資料庫（Isar）**：`isar` 實例在 `lib/repositories/db.dart`，只透過 repository 存取。主執行緒的寫入都要經過 `dbWriteQueue.run(...)` 串成一條，寫入是非同步交易：存檔後立刻同步讀回（`getSync`）可能拿到舊值，這曾造成同步檢查點回退。需要時以記憶體中的狀態為準，或 `await` 存檔。
- **背景執行緒**：
  - `DatabaseWorker`（`lib/services/database_worker.dart`）：一個專用 isolate，負責大量讀取，例如書庫統計（`'summary'`）。
  - `GetIsolateService`（`lib/services/isolate_service.dart`）：擴充程式的 worker pool。JS／Dart／Mihon／LNReader 擴充在 worker 裡執行，每個請求都建一個新的 service，用完即 `dispose()`；Aidoku 只能在主 isolate 執行。worker 需要 WebView 或 Cloudflare 驗證時，經 `m_client.dart` 的本機 loopback bridge 回到主 isolate。
  - 主 isolate 上同步呼叫的擴充功能（標頭、篩選、偏好、baseUrl、supportsLatest）走 `getCachedExtensionService`（`lib/eval/lib.dart`），只放同步呼叫；被淘汰的 service 會被 dispose。
  - 下載有自己的 `download_manager/download_isolate_pool.dart`。
- **擴充執行環境（`lib/eval/`）**：`ExtensionService` 介面，依 `SourceCodeLanguage` 分成 dart（d4rt 直譯）、javascript、lnreader（QuickJS，`flutter_qjs`）、mihon（經 Android proxy server 執行 APK）、aidoku（Rust 的 Wasm）。QuickJS 執行環境是原生記憶體，service 的 `dispose()` 必須釋放（`disposeJsRuntime`）。
- **HTTP**：一律用 `MClient.init(...)`（`lib/services/http/m_client.dart`），內部是 Rust 的 rhttp client（依設定共用，`close()` 無效），`useDartHttpClient: true` 則改用 Dart 的 `IOClient`。Cookie 依網域比對、Cloudflare 重試、DoH／自訂 DNS 都在這裡。
- **同步（`lib/services/sync/`、`lib/services/sync_server.dart`）**：裝置與自架同步伺服器做增量同步。repository 寫入時更新 `updatedAt`，並透過 `changedPartRepository` 記錄變更；跨裝置用 `clientId` 對應同一筆資料，不是本機 id。Settings 是整列同步、較新者勝，因此路徑與以本機 id 為鍵的清單列在 `sync_change_collector.dart` 的 `_deviceLocalSettingsKeys`，並在 `sync_entity_applier.dart` 的 `_preserveDeviceLocalSettings` 保留本機值。新增裝置專屬的設定欄位時兩邊都要加。
- **原生程式**：`rust/`（flutter_rust_bridge，產生到 `lib/src/rust/`：EPUB、RAR、Aidoku Wasm、rhttp）、`go/`（種子／串流伺服器，經 `lib/ffi/torrent_server_ffi.dart`）、`lib/ffi/image_decoder.cpp`。
- **UI**：顏色、字型、間距、圓角、動畫一律讀 Shiori tokens（`context.shiori`），有 Shiori 元件就不用原生 Material 元件；必要的字面值加 `// shiori: <原因>`。圖示用 Material Symbols Rounded，圖示按鈕要有 tooltip。`test/core/design/design_literals_test.dart` 會檢查。
- **多語系**：`lib/l10n/app_*.arb`，範本是 `app_en.arb`，繁體中文是 `app_zh_TW.arb`；新增字串要補齊繁體中文。
