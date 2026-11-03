# Mangayomi 客製版發行

[Windows ZIP 與 Android APK](https://github.com/thomaslou0202/Mangayomi-modified/releases)

1. 更新 `pubspec.yaml` 的版號和組建編號，提交原始碼。
2. 在 `app-release.json` 指定該提交、版號和組建編號，更新 `release-support/RELEASE-NOTES.md`。
3. 推送到 `main` 後，手動執行 [Release custom Mangayomi](https://github.com/thomaslou0202/Mangayomi-modified/actions/workflows/app-release.yml)。Windows 和 Android 的檢查通過後，流程會上傳兩個安裝檔與校驗碼。

0.9.10+136 及更早的安裝檔保留當初的更新網址。升級到使用新更新來源的版本時，請從本倉庫手動下載一次。
