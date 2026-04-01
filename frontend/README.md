# KLConnect - News & Campus App

A Flutter-based news and campus app with clean, modular architecture.

## 📁 Project Structure

```
lib/
├── config/
│   └── theme.dart              # App theme & colors
├── screens/
│   ├── splash_screen.dart      # Initial splash screen
│   └── ...                      # Other screens
├── widgets/
│   └── ...                      # Reusable widgets
├── models/
│   └── ...                      # Data models
├── services/
│   └── ...                      # API & business logic
├── providers/
│   └── ...                      # State management
├── utils/
│   └── ...                      # Utilities & helpers
└── main.dart                    # App entry point
```

## 🎨 Design System

- **Primary Color:** `#003366` (Navy Blue)
- **Background Color:** `#F5F7FA` (Light Gray)
- **Text Color (Dark):** `#1F1F1F`
- **Text Color (Light):** `#757575`

## 🚀 Getting Started

### Prerequisites
- Flutter 2.18+
- Dart 2.18+

### Installation

1. Get dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run -d chrome    # Web
   flutter run              # Mobile
   ```

## 📋 Folder Explanations

- **config/** - Theme, colors, and app configuration
- **screens/** - UI screens for the app
- **widgets/** - Reusable UI components
- **models/** - Data classes and structures
- **services/** - API calls and business logic
- **providers/** - State management (Provider pattern)
- **utils/** - Helper functions and constants

## 🔧 Architecture

- Clean Architecture principles
- MVVM pattern for state management
- Modular folder structure for scalability
- Material Design 3 components
