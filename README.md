<div align="center">

# 📖 Quran Plus

**A beautifully crafted Flutter application for reading the Holy Quran, tracking prayer times, and reciting daily Athkar.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
[![Version](https://img.shields.io/badge/Version-1.0.0-green?style=for-the-badge)](https://github.com/Ali-Ahmad-0/My-Quran)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)](LICENSE)

</div>

---

## 🌟 Overview

**Quran Plus** is a comprehensive Islamic mobile application built with Flutter, designed to serve as an all-in-one companion for Muslims in their daily spiritual journey. The app combines an elegant UI with powerful features — from reading the full Quran with page-flipping navigation to fetching real-time prayer times for any city around the world.

---

## ✨ Features

### 📖 Quran Reader
- Full Quran displayed as high-fidelity **page images** (Uthmani script)
- Smooth **swipe-based page navigation** with `PageView`
- **Dark mode** support with an inverted color filter for comfortable night reading
- **Reading progress saved** automatically — resume exactly where you left off
- Displays current **Surah name** and **page number** at the bottom of every page

### 🕌 Prayer Times (Salah Timetable)
- Fetches **real-time prayer times** from the [Muslim Salat API](https://muslimsalat.com) via `Dio`
- Supports **any city worldwide** — just search and get results instantly
- **Weekly view** with date navigation (browse forward/backward by day)
- **Skeleton loading** animations for a polished loading experience
- City preference is **persisted** locally using `SharedPreferences`

### 🤲 Athkar (Islamic Remembrances)
- Curated collection of **daily Athkar** organized by category
- Each Dhikr card displays the **Arabic text** and the recommended **repetition count**
- Elegant **decorative dividers** using traditional Islamic patterns
- Rendered using the beautiful **Amiri** Arabic font

### 🌓 Dark / Light Mode
- App-wide **dark mode toggle** persisted across sessions
- Carefully tuned color palette for both themes to ensure readability and aesthetics

### 🗓️ Hijri & Gregorian Calendar
- Home screen displays the current time with a **live clock** (updates every second)
- Shows both the **Hijri (Islamic)** and **Gregorian** dates simultaneously

---

## 🏗️ Architecture & Tech Stack

The project follows a clean, layered architecture separating concerns into well-defined directories.

```
lib/
├── constants/          # App-wide constants (colors, Surah list, Athkar data)
│   ├── colors.dart
│   └── lists.dart
├── cubit/              # State management using flutter_bloc (BLoC/Cubit pattern)
│   ├── prayer_cubit.dart
│   └── prayer_state.dart
├── models/             # Data models
│   ├── surah_model.dart
│   ├── prayer_day.dart
│   └── prayer_week.dart
├── services/           # API service layer
│   └── prayer_times_service.dart
├── views/              # Screens / Pages
│   ├── home_screen.dart
│   ├── surah_content.dart
│   ├── salah_timetable.dart
│   ├── athkar_screen.dart
│   └── splash_screen.dart
├── widgets/            # Reusable UI components
│   ├── surahListItem.dart
│   ├── prayer_table.dart
│   ├── preyer_times_container.dart
│   └── item_Leading.dart
└── main.dart
```

### Key Libraries

| Package | Purpose |
|---|---|
| [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | State management (Cubit pattern) |
| [`dio`](https://pub.dev/packages/dio) | HTTP client for Prayer Times API |
| [`shared_preferences`](https://pub.dev/packages/shared_preferences) | Local persistence (dark mode, reading progress, city) |
| [`hijri`](https://pub.dev/packages/hijri) | Hijri (Islamic) calendar conversion |
| [`flutter_screenutil`](https://pub.dev/packages/flutter_screenutil) | Responsive UI scaling across devices |
| [`skeletonizer`](https://pub.dev/packages/skeletonizer) | Skeleton loading animations |
| [`flutter_animate`](https://pub.dev/packages/flutter_animate) | Declarative animations |
| [`lottie`](https://pub.dev/packages/lottie) | Lottie JSON animations (splash & decorative) |
| [`flutter_svg`](https://pub.dev/packages/flutter_svg) | SVG asset rendering |
| [`animated_splash_screen`](https://pub.dev/packages/animated_splash_screen) | Animated app splash screen |
| [`flutter_native_splash`](https://pub.dev/packages/flutter_native_splash) | Native platform splash screen |

### Fonts

| Font | Usage |
|---|---|
| **Poppins** | Latin text, titles, labels |
| **Amiri** | Arabic Athkar and Quran-related text |
| **Tajawal** | Arabic UI text and dates |

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** `^3.x` — [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK** `^3.8.1`
- A connected device or emulator (Android / iOS)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Ali-Ahmad-0/My-Quran.git
   cd My-Quran
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

> **Note:** The app targets Android and iOS. Desktop targets (Windows, macOS, Linux, Web) are scaffolded but not the primary focus.

---

## 🌐 API Reference

Prayer times are powered by the free **Muslim Salat API**:

```
GET https://muslimsalat.com/{city}/weekly/{date}.json
```

| Parameter | Description | Example |
|---|---|---|
| `city` | City name (English or Arabic) | `Makkah`, `Cairo` |
| `date` | Date in `dd-MM-yyyy` format | `16-10-2026` |

No API key is required.

---

## 📱 Supported Platforms

| Platform | Status |
|---|---|
| Android | ✅ Supported |
| iOS | ✅ Supported |
| Web | 🔄 Scaffolded |
| Windows | 🔄 Scaffolded |
| macOS | 🔄 Scaffolded |
| Linux | 🔄 Scaffolded |

---

## 🗂️ App Screens

| Screen | Description |
|---|---|
| **Splash Screen** | Animated launch screen with Lottie animation |
| **Home Screen** | Live clock, Hijri/Gregorian date, quick resume, Surah list, Athkar list |
| **Surah Content** | Full Quran page reader with dark mode and progress saving |
| **Salah Timetable** | Daily & weekly prayer times with city search |
| **Athkar Screen** | Categorized Islamic remembrances with repetition count |

---

## 🤝 Contributing

Contributions are welcome! If you'd like to improve the app, please:

1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature-name`
3. Commit your changes: `git commit -m 'feat: add some feature'`
4. Push to your branch: `git push origin feature/your-feature-name`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

<div align="center">

Made with ❤️ for the Muslim community &nbsp;|&nbsp; Built with Flutter

</div>
