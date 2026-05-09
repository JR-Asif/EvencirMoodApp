# Evencir Mood App

---

## Links

**Repository**

[JR-Asif/EvencirMoodApp](https://github.com/JR-Asif/EvencirMoodApp)

**APK**

**[Download APK (Google Drive)](https://drive.google.com/file/d/1_l1R1p9OBqk5wQjulaXpBMV280GHwW25/view?usp=sharing)** (`app-arm64-v8a-release.apk`)

If Drive is unavailable:

- **Build locally** — open a terminal inside the cloned project folder (`EvencirMoodApp`, or whatever folder name `git clone` created), run `flutter pub get` then `flutter build apk --release --split-per-abi`. Install **`build/app/outputs/flutter-apk/app-arm64-v8a-release.apk`** relative to that same folder (the `build/` directory stays untracked; see `.gitignore`).
- **Local paths:** from the project root (folder with **`pubspec.yaml`**) use **`EvencirMoodApp`** as an example repo folder name—the release APK path is **`EvencirMoodApp\build\app\outputs\flutter-apk\app-arm64-v8a-release.apk`**

**Video**

[Watch app demo (Google Drive)](https://drive.google.com/file/d/11JpeUSC8elsXFflb3HrjM3_cM1h5HSG1/view?usp=sharing)

**Screenshots**

Jump to **[Screenshots](#screenshots)** below, browse **[screenshots/](./screenshots/)** in your clone, or open them on GitHub under **[JR-Asif/EvencirMoodApp → screenshots](https://github.com/JR-Asif/EvencirMoodApp/tree/main/screenshots)**.

---

## Environment

- **Dart SDK** — **`sdk: ^3.9.0`**   

---

## Dependencies

**Plugins & dependencies**

At **runtime**, **no external Flutter plugins and no pub.dev packages are used.**  
 
---

## Folder layout (high level)

```
lib/
├── core/
├── features/
├── main.dart
assets/
├── fonts/
├── icons/
screenshots/
android/
ios/
linux/
macos/
web/
windows/
test/
```

What's inside, in short commas:

- **lib** — all Dart UI, **`main.dart`** for startup and **`MaterialApp`** (light/dark).
- **`lib/core/theme`** — `app_assets.dart`, `fitness_fonts.dart`, `fitness_palette.dart`, `fitness_theme.dart` (themes, palette extension, typography, radius tokens, asset path constants).
- **`lib/features/shell/presentation`** — `app_shell.dart`, `fitness_bottom_navigation.dart`.
- **`lib/features/home/presentation`** — `fitness_home_screen.dart`, plus **`widgets`** with `glass_stat_card.dart`, `insight_cards.dart`, `featured_workout_card.dart`, `weekly_calendar_row.dart`, `month_calendar_bottom_sheet.dart`.
- **`lib/features/plan/presentation`** — `plan_screen.dart`, `training_calendar_widgets.dart`.
- **`lib/features/mood/presentation`** — `mood_screen.dart`, `mood_gradient_ring.dart`.

- **`assets/fonts/static`** — Mulish TTFs (weights in pubspec).
- **`assets/icons`** — PNGs (nav, moods, bells, calendars, arrows, workouts, daylight icon, etc.).
- **`assets`** — fonts folder, icons folder, anything else bundled in pubspec assets.
- **`screenshots`** — app screen captures (**`ss_*.jpeg`**) embedded in **[Screenshots](#screenshots)** with `./screenshots/` links for GitHub.

- **android** — Gradle wrapper, manifests, Kotlin/Java host for the APK.
- **ios** — Xcode project and iOS plist / assets Flutter needs.
- **linux**, **macos**, **web**, **windows** — each platform's runner scaffold for desktop or web builds.

- **test** — `widget_test.dart` and future tests Flutter runs via `flutter test`.

---

## Screenshots

Images live in **`screenshots/`**. Anywhere you view **`main`** (for example **[on GitHub](https://github.com/JR-Asif/EvencirMoodApp/tree/main/screenshots)**), paths like `./screenshots/ss_01.jpeg` resolve to those files on that revision.

Thumbnails below are scaled for the README—tap any image for the full-resolution file.

[<img src="./screenshots/ss_01.jpeg" alt="Screenshot 01" width="260">](./screenshots/ss_01.jpeg)
[<img src="./screenshots/ss_02.jpeg" alt="Screenshot 02" width="260">](./screenshots/ss_02.jpeg)
[<img src="./screenshots/ss_03.jpeg" alt="Screenshot 03" width="260">](./screenshots/ss_03.jpeg)

[<img src="./screenshots/ss_04.jpeg" alt="Screenshot 04" width="260">](./screenshots/ss_04.jpeg)
[<img src="./screenshots/ss_05.jpeg" alt="Screenshot 05" width="260">](./screenshots/ss_05.jpeg)
[<img src="./screenshots/ss_06.jpeg" alt="Screenshot 06" width="260">](./screenshots/ss_06.jpeg)

[<img src="./screenshots/ss_07.jpeg" alt="Screenshot 07" width="260">](./screenshots/ss_07.jpeg)

[Browse screenshots folder](./screenshots/)

---

## Run on your machine

```
flutter pub get
flutter run
```
