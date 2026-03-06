# .NET Roadmap Tracker (Flutter) — Windows Setup & Run Guide

This guide explains **every step** to run this Flutter app on your Windows laptop.

---

## 1) What this app is

A Flutter mobile app to track a 10-week .NET learning roadmap with:
- Week/day/task tracking
- Progress dashboard + analytics charts
- Calendar view
- Daily reminder settings
- Optional Google login + Firebase sync

Project path:
- `mobile_flutter/`

---

## 2) Prerequisites on Windows

Install these tools first.

### A. Install Git
1. Download Git for Windows: https://git-scm.com/download/win
2. Install with default options.
3. Verify:
   ```powershell
   git --version
   ```

### B. Install Flutter SDK
1. Download Flutter SDK (stable): https://docs.flutter.dev/get-started/install/windows/mobile
2. Extract to a simple path, for example:
   - `C:\src\flutter`
3. Add Flutter to PATH:
   - Open **Start** → search **Environment Variables**
   - Edit user/system `Path`
   - Add: `C:\src\flutter\bin`
4. Open new PowerShell and verify:
   ```powershell
   flutter --version
   ```

### C. Install Android Studio (for emulator + Android SDK)
1. Download: https://developer.android.com/studio
2. During install, keep these selected:
   - Android SDK
   - Android SDK Platform
   - Android Virtual Device
3. Open Android Studio once and complete first-run setup.

### D. Install VS Code (optional but recommended)
1. Download: https://code.visualstudio.com/
2. Install extensions:
   - Flutter
   - Dart

---

## 3) Verify Flutter setup

Run:
```powershell
flutter doctor
```

Fix anything marked with `✗`.

Expected key checks:
- Flutter (stable)
- Android toolchain
- Android Studio
- Connected device or emulator

If licenses are pending:
```powershell
flutter doctor --android-licenses
```
Accept all.

---

## 4) Clone/Open the project

If not already cloned:
```powershell
git clone <YOUR_REPO_URL>
cd vibecode1\mobile_flutter
```

If already cloned:
```powershell
cd <path-to-your-repo>\vibecode1\mobile_flutter
```

---

## 5) Install project dependencies

Inside `mobile_flutter` run:
```powershell
flutter pub get
```

This downloads all packages from `pubspec.yaml`.

---

## 6) Run app without Firebase (quick start)

This project can start even if Firebase is not configured.

### A. Start Android Emulator
Option 1 (Android Studio):
- Open Android Studio → **Device Manager**
- Create/start an emulator (Pixel + recent Android version)

Option 2 (CLI):
```powershell
flutter emulators
flutter emulators --launch <emulator_id>
```

### B. Check connected device
```powershell
flutter devices
```

### C. Run app
```powershell
flutter run
```

If multiple devices appear:
```powershell
flutter run -d <device_id>
```

---

## 7) Configure Firebase (optional, for Google login + cloud sync)

If you want login + Firestore sync, do this section.

## 7.1 Create Firebase project
1. Go to https://console.firebase.google.com/
2. Create a new project.

## 7.2 Enable Authentication
1. Firebase Console → **Authentication** → **Get started**
2. Enable **Google** provider.

## 7.3 Create Firestore database
1. Firebase Console → **Firestore Database**
2. Create database (start in test mode for development).

## 7.4 Register Android app in Firebase
1. Add Android app with package name from Flutter Android project.
   - Typical package is in `android/app/src/main/AndroidManifest.xml` and `android/app/build.gradle`.
2. Download `google-services.json`.
3. Place it at:
   - `mobile_flutter/android/app/google-services.json`

## 7.5 Register iOS app (only if building on macOS later)
- Not needed for Windows Android testing.

## 7.6 Use FlutterFire CLI to generate config
Install FlutterFire CLI:
```powershell
dart pub global activate flutterfire_cli
```

Make sure Dart global bin is in PATH (if required):
- `%USERPROFILE%\AppData\Local\Pub\Cache\bin`

Then run inside `mobile_flutter`:
```powershell
flutterfire configure
```
This generates:
- `lib/firebase_options.dart`

### 7.7 Wire `firebase_options.dart` in `main.dart`
Current app uses guarded `Firebase.initializeApp()`.
For full configured setup, update `main.dart` to initialize with options:
```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```
and import:
```dart
import 'firebase_options.dart';
```

(Without this, app can still run in fallback mode.)

---

## 8) Notifications on Android

The app uses `flutter_local_notifications`.

Notes:
- Android 13+ may require notification runtime permission.
- If reminders don’t appear, open app notification settings and allow notifications.

To test quickly:
1. Open app → Settings tab
2. Set reminder time 1–2 minutes ahead
3. Keep app/background and wait for notification

---

## 9) Common commands you will use

From `mobile_flutter` folder:

```powershell
flutter pub get
flutter analyze
flutter test
flutter devices
flutter run
flutter run -d <device_id>
flutter clean
```

If build artifacts become inconsistent:
```powershell
flutter clean
flutter pub get
flutter run
```

---

## 10) Troubleshooting (Windows)

### Problem: `flutter` not recognized
- Recheck PATH includes `C:\src\flutter\bin`
- Close/reopen terminal

### Problem: No devices found
- Start emulator from Android Studio Device Manager
- Or connect physical Android with USB debugging enabled
- Then run `flutter devices`

### Problem: Gradle/JDK errors
- Android Studio usually installs required JDK
- Check with:
  ```powershell
  flutter doctor -v
  ```

### Problem: Firebase login not working
- Confirm Google Sign-In enabled in Firebase Auth
- Ensure SHA-1/SHA-256 fingerprints are added for Android app
- Re-download `google-services.json` after config changes

### Problem: Chart/calendar packages fail to fetch
- Run:
  ```powershell
  flutter pub cache repair
  flutter pub get
  ```

### Problem: App stuck on build
Try:
```powershell
flutter clean
flutter pub get
flutter run -v
```

---

## 11) Project structure reference

```text
mobile_flutter/
├─ lib/
│  ├─ main.dart
│  ├─ models/
│  ├─ screens/
│  ├─ widgets/
│  ├─ services/
│  └─ utils/
└─ pubspec.yaml
```

---

## 12) Recommended first run flow

1. `flutter doctor`
2. Start emulator
3. `cd mobile_flutter`
4. `flutter pub get`
5. `flutter run`
6. Open Roadmap tab and toggle tasks
7. Close/reopen app to verify local progress persistence
8. (Optional) configure Firebase and test Google login + sync

---

## 13) Need help quickly?

If any command fails, share these outputs:
- `flutter doctor -v`
- `flutter --version`
- `flutter devices`
- full error log from `flutter run -v`

With these 4 logs, most issues can be fixed fast.
