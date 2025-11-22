# Easacc Task 🚀

A comprehensive Flutter application demonstrating social authentication (Google & Facebook), WebView management, and real-time WiFi/Bluetooth device scanning with auto-refresh capabilities.

## ✨ Features

### 🔐 Authentication
- **Google Sign-In**: One-tap authentication with Google accounts
- **Facebook Login**: Native Facebook SDK integration  " cant work until you send your name"
- Comprehensive error handling with Arabic language support
- Auto-token management and session handling

### 🌐 WebView Management
- Custom WebView with URL input validation
- Real-time URL formatting and sanitization
- Comprehensive error handling for all web resource types
- Security features:
  - Blocks unsafe `javascript:` and `data:` URLs
  - Detects and handles file downloads (.pdf, .zip, .apk)
  - HTTP status code detection (400, 401, 403, 404, 500, 502, 503)
- User-friendly error messages with retry options
- Full JavaScript support

### 📡 Device Scanner
- **WiFi Network Scanning**: Discovers nearby WiFi networks with SSID and BSSID
- **Bluetooth Device Scanning**: Scans for BLE devices in range
- **Auto-Refresh**: Automatically refreshes device list every 10 seconds
- **Real-time Updates**: Stream-based architecture for live device updates
- Device type identification (WiFi/Bluetooth)
- Duplicate prevention system
- Comprehensive permission handling

### 🎨 UI/UX Features
- Clean and modern Material Design interface "use google stitch to design it" 
- Loading states for all async operations
- Empty states with helpful instructions
- Error states with retry functionality
- Responsive layout design
- Custom reusable widgets

## 📸 Screenshots

_Add your app screenshots here_

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/
│   ├── errors/                    # Centralized error handling
│   │   ├── exceptions.dart        # Custom exception classes
│   │   ├── error_handler.dart     # Firebase error mapper
│   │   └── wep_page_error_handler.dart  # WebView error handling
│   ├── utils/                     # Utilities and helpers
│   │   ├── app_colors.dart        # Color palette
│   │   ├── app_text.dart          # Text constants
│   │   ├── text_style.dart        # Typography styles
│   │   └── permission_helper.dart # Permission management
│   ├── constant/
│   │   └── widgets/               # Reusable widgets
│   │       └── custom_elevated_button.dart
│   └── routing/
│       └── route.dart             # App navigation
│
├── feature/
│   ├── auth/                      # Authentication feature
│   │   ├── data/
│   │   │   ├── data_source/
│   │   │   │   └── auth_remote_data_source.dart
│   │   │   └── models/
│   │   │       └── request_model.dart
│   │   └── presentation/
│   │       ├── cubit/
│   │       │   ├── auth_cubit.dart
│   │       │   └── auth_state.dart
│   │       └── views/
│   │           └── login_screen.dart
│   │
│   └── settings/                  # Settings & WebView feature
│       ├── data/
│       │   ├── data_source/
│       │   │   └── remote_data_cource.dart
│       │   ├── models/
│       │   │   ├── devices_model.dart
│       │   │   └── wep_url.dart
│       │   └── repository/
│       │       └── setting_repo.dart
│       └── presentation/
│           ├── cubit/
│           │   ├── setting_cubit.dart
│           │   └── setting_states.dart
│           ├── views/
│           │   ├── setting_screen.dart
│           │   └── web_view.dart
│           └── widgets/
│               ├── app_bar.dart
│               ├── custom_web_url.dart
│               ├── custome_check_devices.dart
│               ├── drop_down_widget.dart
│               ├── empty_screen.dart
│               ├── error_screen.dart
│               └── loading_devices.dart
```

### Architecture Layers

**Data Layer**: Handles data fetching from remote sources (Firebase Auth, WiFi/Bluetooth scanning)

**Presentation Layer**: Contains UI and state management using BLoC/Cubit pattern

## 🛠️ Technologies Used

### Core Framework
- **Flutter SDK**: ^3.0.0
- **Dart SDK**: ^3.0.0

### State Management
- **flutter_bloc**: ^8.1.3 - State management solution

### Authentication
- **firebase_core**: ^2.24.2 - Firebase core functionality
- **firebase_auth**: ^4.15.3 - Firebase authentication
- **google_sign_in**: ^6.1.6 - Google Sign-In SDK
- **flutter_facebook_auth**: ^6.0.3 - Facebook authentication

### WebView & Network
- **webview_flutter**: ^4.4.2 - WebView implementation

### Device Scanning
- **flutter_blue_plus**: ^1.31.8 - Bluetooth Low Energy scanning
- **wifi_iot**: ^0.3.19 - WiFi network scanning

### Permissions
- **permission_handler**: ^11.0.1 - Runtime permissions
- **geolocator**: ^10.1.0 - Location services

### Utilities
- **dartz**: ^0.10.1 - Functional programming (Either, Option)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Active Firebase project
- Facebook Developer account

### Installation

1. **Clone the repository**
```bash
git clone https://github.com/habibaamr26/Easacc_task.git
cd Easacc_task
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Firebase Setup**

   a. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/)
   
   b. Add your Android app:
   - Package name: `com.example.easacc_task` (or your package name)
   - Download `google-services.json`
   - Place it in `android/app/`
   
   c. Add your iOS app:
   - Bundle ID: Your iOS bundle identifier
   - Download `GoogleService-Info.plist`
   - Place it in `ios/Runner/`
   
   d. Enable Authentication methods:
   - Go to Firebase Console → Authentication → Sign-in method
   - Enable Google Sign-In
   - Enable Facebook Login

4. **Configure Google Sign-In**

   For Android (`android/app/build.gradle`):
   ```gradle
   android {
       defaultConfig {
           minSdkVersion 21
       }
   }
   ```

5. **Configure Facebook Login**

   a. Create an app at [Facebook Developers](https://developers.facebook.com/)
   
   b. Add Facebook App ID to `android/app/src/main/res/values/strings.xml`:
   ```xml
   <string name="facebook_app_id">YOUR_FACEBOOK_APP_ID</string>
   <string name="facebook_client_token">YOUR_CLIENT_TOKEN</string>
   ```
   
   c. Update `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <meta-data
       android:name="com.facebook.sdk.ApplicationId"
       android:value="@string/facebook_app_id"/>
   ```

6. **Configure Permissions**

   Ensure these permissions are in `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
   <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
   <uses-permission android:name="android.permission.BLUETOOTH"/>
   <uses-permission android:name="android.permission.BLUETOOTH_ADMIN"/>
   <uses-permission android:name="android.permission.BLUETOOTH_SCAN"/>
   <uses-permission android:name="android.permission.BLUETOOTH_CONNECT"/>
   <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
   <uses-permission android:name="android.permission.CHANGE_WIFI_STATE"/>
   ```

7. **Run the app**
```bash
flutter run
```


### Features Implementation

#### Authentication Flow
1. User taps Google/Facebook login button
2. `GoogleAuthCubit` handles authentication state
3. `GoogleSignInService` communicates with Firebase
4. Success: Navigate to Settings screen
5. Failure: Show Arabic error message

#### Device Scanning Flow
1. Settings screen initializes device watching
2. `SettingCubit.startWatchingDevices()` creates stream
3. `WebViewRemoteDataSource.fetchDevices()` scans WiFi and Bluetooth
4. Stream emits device list every 10 seconds
5. UI updates automatically via BLoC builder

#### WebView Flow
1. User enters URL in settings
2. URL validation and formatting
3. `SettingCubit.updateUrl()` loads URL
4. Navigate to WebView page
5. WebViewController loads and manages page



## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 👨‍💻 Author

**Habiba Amr**
- GitHub: [@habibaamr26](https://github.com/habibaamr26)


⭐ If you like this project, please give it a star on GitHub!

Made with ❤️ using Flutter
