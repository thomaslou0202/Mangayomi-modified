# 書庫效能與背景同步版 0.9.9+130

繁體中文與小說正文插圖保留，新增書庫效能改善與背景同步。

- 書庫的未讀、下載、書籤數集中於背景計算；分類、排序與封面共用統計，減少逐本讀取章節。
- 開啟既有作品改用非同步章節查詢；大量同步資料收集、套用和 JSON 編解碼移至背景工作，介面仍可操作。
- 同步使用短批次寫入、索引查詢；避免重複同步，保留同步期間新產生的閱讀進度與刪除紀錄，並協調備份還原。
- Android 同步開始後會顯示常駐通知，切換 App 或關閉螢幕後仍可繼續；成功或失敗後結束服務並釋放喚醒鎖。請允許通知。

Android：下載 `Mangayomi-0.9.9-performance-android.apk` 安裝，可直接更新先前的插圖／繁體中文版本（相同套件名稱、簽章）。

Windows：關閉舊版，下載 `Mangayomi-0.9.9-performance-windows.zip`，解壓縮到新資料夾後執行 `mangayomi.exe`。沿用現有書庫；不必重新匯入備份。需要 Windows 10／11 x64。

驗證包含 65,000 章、1,473 本的真實 Isar 背景資料庫測試、同步資料格式與同時編輯保護、既有還原與閱讀器回歸測試，以及 Android 模擬器手機／平板啟動、背景／關閉螢幕／服務清理。

背景執行是「已開始的同步繼續完成」，不會在強制停止或重開機後自動恢復；部分手機的額外省電限制仍可能影響長時間同步。

原始碼修補與可重現建置：本倉庫 `app-performance` 分支的 `app-patches/performance.patch` 及 GitHub Actions。設計參考 [Mihon LibraryUpdateWorker](https://github.com/mihonapp/mihon/blob/e588e04359fe1058206a2cbac1b01018ad787359/app/src/main/java/eu/kanade/tachiyomi/data/library/LibraryUpdateWorker.kt)，以 Flutter isolate／Isar 實作。

[下載發行版本](https://github.com/thomaslou0202/Mangayomi-modified/releases/tag/performance-v0.9.9-130)。
