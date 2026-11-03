# 漫畫來源白畫面修正版 0.9.9+131

修正漫畫來源頁在啟用來源後顯示灰白畫面的問題。

原因是部分舊套件或備份中的「最近使用」等欄位為空值，原程式強制取值導致整個列表顯示失敗。本版修正列表分組、釘選、名稱、語言與圖示的空值處理，並在匯入舊 JSON 時補齊相容預設值。保留來源 ID、程式與已有的偏好，不必重新匯入書庫。

Windows：關閉舊版，下載 `Mangayomi-0.9.9-source-fix-windows.zip`，解壓後執行 `mangayomi.exe`，沿用原有資料。

Android：下載 `Mangayomi-0.9.9-source-fix-android.apk`，可直接更新先前的插圖版／效能版，簽章與套件名稱相同。手機、平板共用同一個 APK。

更新後可重新啟用先前停用的漫畫來源。

保留繁體中文、小說正文插圖、書庫效能與背景同步。測試包含舊 JSON、資料庫空欄位、漫畫／動畫／小說來源頁、空來源頁、釘選、既有書庫／同步與閱讀器回歸，以及 Android 手機／平板啟動與背景服務。

原始碼與可重現建置位於本倉庫 `app-performance` 分支的 `app-patches/source-list-null-safety.patch` 與 GitHub Actions。

[下載發行版本](https://github.com/thomaslou0202/Mangayomi-modified/releases/tag/source-list-fix-v0.9.9-131)。
