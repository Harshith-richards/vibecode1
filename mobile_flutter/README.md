# .NET Roadmap Tracker (Flutter) — Local-Only Setup for Windows + Antigravity IDE

This project now runs in **100% local mode**:
- ✅ No Firebase
- ✅ No cloud database
- ✅ No login required
- ✅ Progress saved locally on your device using `shared_preferences`

If you were blocked at Firebase setup, you can now skip it completely.

---

## 1) What you need on Windows

Install these tools first:

1. **Git**
   - Download: https://git-scm.com/download/win
   - Verify:
     ```powershell
     git --version
     ```

2. **Flutter SDK (Stable)**
   - Install guide: https://docs.flutter.dev/get-started/install/windows/mobile
   - Extract to: `C:\src\flutter`
   - Add to PATH: `C:\src\flutter\bin`
   - Verify:
     ```powershell
     flutter --version
     ```

3. **Android Studio** (for Android SDK + emulator)
   - Download: https://developer.android.com/studio
   - Install with Android SDK + AVD

4. **Antigravity IDE**
   - Open this repo folder from Antigravity IDE.
   - Use the integrated terminal for commands below.

---

## 2) Verify your setup

Run:
```powershell
flutter doctor
```

If Android licenses are pending:
```powershell
flutter doctor --android-licenses
```
Accept all.

---

## 3) Open project in Antigravity IDE

In terminal:
```powershell
cd <path-to-repo>\vibecode1\mobile_flutter
```

You should see:
- `pubspec.yaml`
- `lib/`

---

## 4) Install packages

```powershell
flutter pub get
```

This installs all dependencies for local mode.

---

## 5) Start emulator (or connect phone)

### Option A: Android Emulator
- Open Android Studio → Device Manager
- Start a virtual device

Then confirm:
```powershell
flutter devices
```

### Option B: Physical Android phone
- Enable Developer options + USB debugging
- Connect via USB
- Run:
  ```powershell
  flutter devices
  ```

---

## 6) Run the app (local-only)

```powershell
flutter run
```

If multiple devices appear:
```powershell
flutter run -d <device_id>
```

That’s it — app will run fully offline/local.

---

## 7) How local storage works

- Task completion state is saved on-device using `shared_preferences`.
- Reminder time is also saved locally.
- When you close and reopen the app, progress remains.
- If you uninstall app/clear app data, local progress resets.

---

## 8) Features available in local-only mode

- Home dashboard with progress
- Roadmap with expandable week/day/task lists
- Checkbox task tracking
- Analytics charts
- Calendar screen
- Reminder time setting (local notifications)

No internet/database is needed for these core features.

---

## 9) Useful commands (inside `mobile_flutter`)

```powershell
flutter pub get
flutter analyze
flutter test
flutter devices
flutter run
flutter clean
```

If build has issues:
```powershell
flutter clean
flutter pub get
flutter run
```

---

## 10) Common issues and fixes

### `flutter` command not found
- Re-check PATH includes: `C:\src\flutter\bin`
- Restart terminal/IDE

### No device found
- Start emulator from Android Studio Device Manager
- Or reconnect phone with USB debugging
- Check again: `flutter devices`

### Gradle/JDK error
Run:
```powershell
flutter doctor -v
```
Android Studio usually auto-installs required JDK.

### Notifications not showing
- Allow notifications in Android app settings
- On Android 13+, runtime notification permission may be required

---

## 11) Quick first-run checklist

1. `flutter doctor`
2. `cd <repo>\vibecode1\mobile_flutter`
3. `flutter pub get`
4. Start emulator
5. `flutter run`
6. Open Roadmap tab and mark tasks
7. Restart app and verify saved progress

---

## 12) Project structure

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

If you want, I can also give you a **super short 2-minute run guide** (copy-paste commands only) for Antigravity IDE.
