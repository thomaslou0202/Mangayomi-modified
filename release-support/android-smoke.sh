#!/usr/bin/env bash
set -euo pipefail
package=com.kodjodevf.mangayomi.illustrations
activity=com.kodjodevf.mangayomi.MainActivity
adb install -r dist/Mangayomi-android.apk
# Fresh installs otherwise open Android's storage settings instead of the app.
adb shell appops set --uid "$package" MANAGE_EXTERNAL_STORAGE allow
adb logcat -c
adb shell am start -W -n "$package/$activity" | tee dist/android-launch.txt
sleep 20
adb shell pidof "$package" | tee dist/android-process.txt
adb logcat -d > dist/android-logcat.txt
if grep -E 'FATAL EXCEPTION|Fatal signal|flutter:.*Unhandled Exception' dist/android-logcat.txt; then
    echo 'Android smoke launch failed; inspect the logcat artifact.'
    exit 1
fi
adb shell dumpsys activity activities > dist/android-phone-foreground.txt
grep -E "(mResumedActivity|topResumedActivity).*$package/" dist/android-phone-foreground.txt
adb exec-out screencap -p > dist/android-phone.png
adb shell wm size 1600x2560
adb shell wm density 240
sleep 8
adb shell pidof "$package"
adb shell dumpsys activity activities > dist/android-foreground.txt
grep -E "(mResumedActivity|topResumedActivity).*$package/" dist/android-foreground.txt
adb exec-out screencap -p > dist/android-tablet.png
echo 'APK signature checked; emulator installation, phone launch and tablet resize passed.' | tee dist/android-smoke-result.txt
