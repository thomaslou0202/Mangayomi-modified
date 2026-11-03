# Mangayomi 繁體中文插圖版 0.9.9+129

新增完整的「繁體中文（台灣）」介面，保留小說正文插圖功能，提供 Windows 與 Android 版本。

## 下載

- Android 手機／平板：[直接下載 APK](https://github.com/thomaslou0202/Mangayomi-modified/releases/download/traditional-chinese-v0.9.9-129/Mangayomi-0.9.9-zh-TW-android.apk)
- Windows：[下載 ZIP](https://github.com/thomaslou0202/Mangayomi-modified/releases/download/traditional-chinese-v0.9.9-129/Mangayomi-0.9.9-zh-TW-windows.zip)

## 切換繁體中文

沒有既存語言偏好時，新版會預設使用繁體中文。若更新後仍沿用英文或簡體，請到：

「更多 → 設定 → 外觀 → 介面語言 → 繁體中文（台灣）」

英文介面：More → Settings → Appearance → App language → 繁體中文（台灣）。

## 安裝與更新

Android：使用與前一版插圖版相同的套件 ID（com.kodjodevf.mangayomi.illustrations）及發行簽章，可以直接更新，沿用書庫、閱讀進度與設定。手機、平板使用同一個通用 APK，最低 Android 7.0。此版本與官方 App 的套件 ID 不同，仍可並存。

Windows：先匯出目前書庫備份，再關閉原本的 Mangayomi。將 ZIP 解壓縮到獨立資料夾，執行裡面的 mangayomi.exe；會使用原有的 Mangayomi 資料目錄，不需要重新匯入書庫。

## 內容

- 繁體中文涵蓋目前全部 1,085 個介面翻譯項目。
- 補齊原中文缺漏的 47 個項目，新增備份、下載、網站驗證、字幕及電視介面等 38 個可翻譯提示。
- 使用台灣常用詞彙，例如書庫、套件庫、設定、還原、快取及捲動。
- 可隨時在語言設定切回簡體中文或其他既有語言。
- 保留 128 版的小說正文插圖功能及同一組 Android 發行簽章，資料庫結構不變。
- 來源網站提供的作品名稱、正文、套件自訂文字及系統原始錯誤，仍可能顯示其原文。

這是以 Mangayomi 0.9.9 為基礎的非官方測試版。上游固定版本及全部修改位於 app-traditional-chinese 分支，採 Apache-2.0 授權。

## 驗證結果

Windows 與 Android 各通過 24 項 Flutter 測試，涵蓋既有插圖閱讀器、分頁、翻譯完整性及手機／平板的語言切換。Android 另通過發行簽章、模擬器安裝、手機啟動與平板尺寸切換檢查，啟動畫面已確認顯示繁體中文。Android 簽章與前一版插圖版相同。

[Windows 建置與測試](https://github.com/thomaslou0202/Mangayomi-Plugins/actions/runs/40348170485) · [Android 建置與測試](https://github.com/thomaslou0202/Mangayomi-Plugins/actions/runs/40348170425) · [完整修改](https://github.com/thomaslou0202/Mangayomi-Plugins/tree/app-traditional-chinese/app-patches)
