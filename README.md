# 🚀 Flutter Starter Template

> A professional, production-ready Flutter template featuring clean architecture, multi-environment support, and automated CI/CD workflows.

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)](https://flutter.dev/)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

---

## ✨ Key Features

- **🏗️ Clean Architecture** - Scalable, maintainable code structure with separation of concerns
- **🎨 State Management Ready** - Pre-configured for your preferred state management solution
- **🌍 Localization Support** - Multi-language ready with Flutter's intl package
- **🔒 Secure Storage** - Built-in encrypted local data storage
- **🎯 Custom Splash Screen** - Professional app launch experience
- **🎭 Multi-Flavor Support** - Separate development and production environments
- **🔥 Firebase Integration** - Pre-configured Firebase setup for analytics and distribution
- **🚀 Automated CI/CD** - GitHub Actions workflow with Firebase App Distribution

---

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** 3.0 or higher ([Installation Guide](https://flutter.dev/docs/get-started/install))
- **Dart SDK** (comes with Flutter)
- **Android Studio** or **VS Code** with Flutter extensions
- **Git** for version control
- **Firebase CLI** (for CI/CD setup): `npm install -g firebase-tools`

---

## 🚀 Getting Started

### Step 1: Clone the Repository

```bash
git clone https://github.com/mustafaelbaz5/App-Structure.git my_app
cd my_app
flutter pub get
```

### Step 2: Link to Your Own Repository

You have two options for linking this project to your own GitHub repository:

#### Option A: Keep the Original Commit History

```bash
# Check current remote connections
git remote -v

# Remove the original remote
git remote remove origin

# Add your new repository URL
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git

# Verify the new remote
git remote -v

# Push to your repository (includes all history)
git branch -M main
git push -u origin main
```

#### Option B: Start Fresh (Recommended for Clean History)

If you want to start with a clean commit history and push only your current files as the first commit:

```bash
# Step 1: Remove the existing Git history
rm -rf .git

# Step 2: Initialize a new Git repository
git init

# Step 3: Add all files to staging
git add .

# Step 4: Create your first commit
git commit -m "Initial commit: Flutter starter template"

# Step 5: Rename branch to main (if needed)
git branch -M main

# Step 6: Add your new repository as remote
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO-NAME.git

# Step 7: Push to your new repository
git push -u origin main
```

**Why choose Option B?**
- Clean, professional commit history starting from your project
- No references to the original template repository
- Your repository shows your work from the beginning
- Smaller repository size without unnecessary history

**Note:** Make sure you've created an empty repository on GitHub before pushing. Do not initialize it with a README, .gitignore, or license file.

### Step 3: Rename Your Project

Use the Flutter rename package to update your app's identity:

```bash
# Install the rename tool globally
dart pub global activate rename

# Update your app name (displays under app icon)
dart run rename setAppName --value "Your App Name"

# Update your bundle identifier
dart run rename setBundleId --value com.yourcompany.yourapp
```

This command automatically updates:
- `AndroidManifest.xml`
- `build.gradle`
- `Info.plist` (iOS)
- `pubspec.yaml`

### Step 4: Update Dependencies

```bash
# Update Flutter SDK to the latest stable version
flutter upgrade

# Update all project dependencies to latest compatible versions
flutter pub upgrade --major-versions

# Fetch all dependencies
flutter pub get

# Clean build artifacts and rebuild
flutter clean
flutter pub get
```

### Step 5: Run the Application

**Development Environment:**
```bash
flutter run --flavor development -t lib/main_development.dart
```

**Production Environment:**
```bash
flutter run --flavor production -t lib/main_production.dart
```

---

## 🔧 Android SDK Configuration

### Option 1: Using Android Studio (Recommended)

1. Open Android Studio
2. Navigate to **Tools → SDK Manager → SDK Tools**
3. Install the following components:
   - Android SDK Build-Tools (latest version)
   - NDK (Side by side)
   - CMake

### Option 2: Using Command Line

```bash
# Update SDK Manager
sdkmanager --update

# Install required tools
sdkmanager "build-tools;34.0.0"
sdkmanager "ndk;26.1.10909125"
sdkmanager "cmake;3.22.1"
```

---

## 🔥 Firebase & CI/CD Setup

### Step 1: Install Required Tools

```bash
# Install Ruby (if not already installed)
# On macOS: Ruby comes pre-installed
# On Windows: Download from https://rubyinstaller.org/
# On Linux: sudo apt-get install ruby-full

# Install Fastlane
sudo gem install fastlane

# Install Firebase CLI
npm install -g firebase-tools

# Verify installations
fastlane --version
firebase --version
```

### Step 2: Setup Firebase Project

1. **Create Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Click "Add project" or select an existing one
   - Follow the setup wizard

2. **Add Android App to Firebase**
   - In your Firebase project, click "Add app" → Android icon
   - Enter your package name (e.g., `com.yourcompany.yourapp`)
   - Download `google-services.json`
   - Place it in `android/app/` directory

3. **Find Your Firebase App ID**
   - In Firebase Console, click the gear icon → Project settings
   - Scroll to "Your apps" section
   - Copy the App ID (format: `1:123456789:android:abc123def456`)
   - You'll need this for the Fastfile

### Step 3: Initialize Fastlane

```bash
# Navigate to android directory
cd android

# Initialize Fastlane
fastlane init

# When prompted:
# - Package name: Enter your app's package name (e.g., com.yourcompany.yourapp)
# - Path to json secret file: Press Enter to skip (we'll use CLI token instead)
# - Download metadata: n (No)
```

This creates:
- `android/fastlane/Fastfile` - Your automation configuration
- `android/fastlane/Appfile` - Your app information

### Step 4: Install Fastlane Firebase Plugin

```bash
# Still in android directory
fastlane add_plugin firebase_app_distribution

# This adds the Firebase App Distribution plugin to your Fastfile
```

### Step 5: Configure Fastfile

Replace the contents of `android/fastlane/Fastfile` with:

```ruby
default_platform(:android)

platform :android do
  desc "Distribute production build to Firebase"
  lane :release_to_firebase do
    # Clean previous builds
    sh "flutter clean"
    
    # Build production APK
    sh "flutter build apk --release --flavor production --target lib/main_production.dart --no-tree-shake-icons"

    # List of testers (add your team's emails)
    testers_list = [
      "dev@company.com",
      "qa@company.com",
      "tester@company.com",
    ]

    # Convert array to comma-separated string
    testers_string = testers_list.join(", ")

    # Distribute to Firebase
    firebase_app_distribution(
      app: "1:123456789:android:abc123def456",  # Replace with YOUR Firebase App ID
      firebase_cli_token: ENV["FIREBASE_CLI_TOKEN"],
      android_artifact_type: "APK",
      android_artifact_path: "../build/app/outputs/flutter-apk/app-production-release.apk",
      testers: testers_string,
      release_notes: "Version 1.0.0 - Initial release",
      # groups: "internal-testers"  # Optional: use tester groups instead of individual emails
    )
  end

  desc "Distribute development build to Firebase"
  lane :dev_to_firebase do
    sh "flutter clean"
    sh "flutter build apk --flavor development --target lib/main_development.dart --no-tree-shake-icons"

    testers_list = [
      "dev@company.com",
    ]

    testers_string = testers_list.join(", ")

    firebase_app_distribution(
      app: "1:123456789:android:abc123def456",  # Replace with YOUR Firebase App ID
      firebase_cli_token: ENV["FIREBASE_CLI_TOKEN"],
      android_artifact_type: "APK",
      android_artifact_path: "../build/app/outputs/flutter-apk/app-development-release.apk",
      testers: testers_string,
      release_notes: "Development build for testing",
    )
  end
end
```

**Important:** Replace `1:123456789:android:abc123def456` with your actual Firebase App ID from Step 2.

### Step 6: Generate Firebase CLI Token

```bash
# Login to Firebase (opens browser)
firebase login:ci

# Copy the token that appears in the terminal
# It will look like: 1//0abcdefghijklmnopqrstuvwxyz...
```

### Step 7: Setup GitHub Secrets

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Create a secret:
   - **Name:** `FIREBASE_CLI_TOKEN`
   - **Value:** Paste the token from Step 6
5. Click **Add secret**

### Step 8: Create/Update GitHub Actions Workflow

Create or update `.github/workflows/android_fastlane_firebase_app_distribution_workflow.yml`:

```yaml
name: Android Firebase Distribution

on:
  push:
    branches:
      - main
      - master
  pull_request:
    branches:
      - main
      - master
  workflow_dispatch:  # Allows manual trigger

jobs:
  distribute:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Setup Java
        uses: actions/setup-java@v3
        with:
          distribution: 'zulu'
          java-version: '17'
          cache: 'gradle'

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'  # Update to your Flutter version
          channel: 'stable'
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Run tests
        run: flutter test

      - name: Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.0'
          bundler-cache: true
          working-directory: android

      - name: Install Fastlane
        run: |
          cd android
          gem install bundler
          bundle install

      - name: Distribute to Firebase
        env:
          FIREBASE_CLI_TOKEN: ${{ secrets.FIREBASE_CLI_TOKEN }}
        run: |
          cd android
          bundle exec fastlane release_to_firebase
```

**Key Points:**
- Triggers on push to `main` or `master` branch
- Can be manually triggered from GitHub Actions tab
- Runs tests before building
- Uses cached dependencies for faster builds
- Builds and distributes production APK to Firebase

### Step 9: Test Fastlane Locally (Optional)

Before pushing to GitHub, test Fastlane locally:

```bash
# Navigate to android directory
cd android

# Run the lane
bundle exec fastlane release_to_firebase

# Or test development build
bundle exec fastlane dev_to_firebase
```

**Expected output:**
- Flutter clean completes
- APK builds successfully
- APK uploads to Firebase
- Testers receive email notifications

### Step 10: Push and Trigger Workflow

Every push to the `main` branch will automatically:
1. Build the Android APK
2. Run tests and code analysis
3. Distribute to Firebase testers

```bash
git add .
git commit -m "Your commit message"
git push origin main
```

**Monitor Progress:**
- Go to your GitHub repository
- Click on the **Actions** tab
- View real-time build logs and status

**Build Times:**
- First build: 8-12 minutes
- Subsequent builds (with cache): 3-5 minutes

---

## 📦 Build Commands

### Android Builds

```bash
# Development APK
flutter build apk --flavor development -t lib/main_development.dart

# Production APK
flutter build apk --release --flavor production -t lib/main_production.dart

# Production App Bundle (for Play Store)
flutter build appbundle --release --flavor production -t lib/main_production.dart
```

### iOS Builds

```bash
# Development
flutter build ios --flavor development -t lib/main_development.dart

# Production
flutter build ios --release --flavor production -t lib/main_production.dart
```

---

## 🛠️ Development Commands

### Code Quality

```bash
# Run all tests
flutter test

# Analyze code for issues
flutter analyze

# Format all Dart files
dart format .

# Fix common issues automatically
dart fix --apply
```

### Dependency Management

```bash
# Check for outdated packages
flutter pub outdated

# Update to latest compatible versions
flutter pub upgrade

# Update to latest major versions (breaking changes)
flutter pub upgrade --major-versions

# Clean and reinstall dependencies
flutter clean
flutter pub get
```

### Clean Build

```bash
# Flutter clean
flutter clean

# Android Gradle clean
cd android && ./gradlew clean && cd ..

# Complete clean and rebuild
flutter clean && flutter pub get && flutter run
```

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── di/                    # Dependency Injection setup
│   ├── error/                 # Error handling & exceptions
│   ├── router/                # Navigation configuration
│   ├── storage/               # Secure local storage
│   ├── themes/                # App themes & styling
│   └── utils/                 # Utility functions & constants
│
├── features/
│   └── feature_example/
│       ├── data/
│       │   ├── models/        # Data models & entities
│       │   ├── repositories/  # Repository implementations
│       │   └── services/      # API & external services
│       │
│       ├── logic/
│       │   ├── bloc/          # Business logic (BLoC/Cubit)
│       │   └── use_cases/     # Use case implementations
│       │
│       └── ui/
│           ├── screens/       # Screen widgets
│           └── widgets/       # Reusable UI components
│
├── l10n/                      # Localization files
├── main_development.dart      # Development entry point
└── main_production.dart       # Production entry point
```

---

## 🐛 Troubleshooting

### Common Issues and Solutions

| Issue | Solution |
|-------|----------|
| `dart: command not found` | Add Dart to PATH: `export PATH="$PATH:$HOME/.pub-cache/bin"` (Add to `~/.zshrc` or `~/.bashrc`) |
| `fastlane: command not found` | Run `sudo gem install fastlane` or add Ruby gems to PATH |
| `firebase: command not found` | Run `npm install -g firebase-tools` |
| Android build fails | Run `flutter clean && cd android && ./gradlew clean && cd ..` |
| Gradle sync issues | Update Gradle in `android/gradle/wrapper/gradle-wrapper.properties` |
| Firebase token error | Verify `FIREBASE_CLI_TOKEN` is correctly set in GitHub Secrets |
| Testers not receiving builds | Check email addresses in Fastfile and verify testers in Firebase Console |
| Flavor not found | Ensure flavor configurations exist in `android/app/build.gradle` |
| iOS build fails | Run `cd ios && pod install && cd ..` |
| APK path not found | Check the `android_artifact_path` matches your actual build output |
| GitHub Actions fails | Check Actions tab logs, ensure all secrets are set correctly |
| Ruby version errors | Use Ruby 3.0+ with `ruby/setup-ruby@v1` action |

### Firebase-Specific Issues

**Problem:** "App not found" error
```bash
# Solution: Verify your Firebase App ID
# Get it from: Firebase Console → Project Settings → Your Apps → App ID
```

**Problem:** Invalid authentication token
```bash
# Solution: Generate new token
firebase logout
firebase login:ci
# Update GitHub secret with new token
```

**Problem:** Testers don't receive notification
- Verify emails are correct in Fastfile
- Check spam/junk folders
- Ensure testers are added in Firebase Console
- Verify Firebase App Distribution is enabled for your project

### Fastlane Issues

**Problem:** Gemfile.lock conflicts
```bash
cd android
rm Gemfile.lock
bundle install
```

**Problem:** "Could not find plugin" error
```bash
cd android
fastlane add_plugin firebase_app_distribution
```

**Problem:** Build path mismatch
```ruby
# Check your actual APK output path after building
# Update Fastfile with correct path:
android_artifact_path: "../build/app/outputs/flutter-apk/app-production-release.apk"
```

### Getting Help

If you encounter issues not listed here:
1. Check the [Flutter documentation](https://flutter.dev/docs)
2. Search [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
3. Open an issue in this repository

---

## ✅ Setup Checklist

Use this checklist to ensure you've completed all setup steps:

### Initial Setup
- [ ] Cloned repository and installed dependencies
- [ ] Renamed project (app name and bundle ID)
- [ ] Removed old Git history and created new repository
- [ ] Updated Flutter SDK and all dependencies

### Firebase Setup
- [ ] Created Firebase project
- [ ] Added Android app to Firebase project
- [ ] Downloaded `google-services.json`
- [ ] Placed `google-services.json` in `android/app/` directory
- [ ] Copied Firebase App ID from project settings

### Fastlane Setup
- [ ] Installed Ruby (check with `ruby --version`)
- [ ] Installed Fastlane (check with `fastlane --version`)
- [ ] Ran `fastlane init` in `android/` directory
- [ ] Installed Firebase App Distribution plugin
- [ ] Updated `android/fastlane/Fastfile` with your Firebase App ID
- [ ] Added tester emails or groups to Fastfile
- [ ] Tested Fastlane locally (optional)

### CI/CD Setup
- [ ] Installed Firebase CLI (check with `firebase --version`)
- [ ] Generated Firebase CLI token (`firebase login:ci`)
- [ ] Added `FIREBASE_CLI_TOKEN` to GitHub Secrets
- [ ] Created/updated GitHub Actions workflow file
- [ ] Committed and pushed to main branch
- [ ] Verified successful build in GitHub Actions tab

### Verification
- [ ] Build completed successfully
- [ ] APK uploaded to Firebase App Distribution
- [ ] Testers received email notifications
- [ ] Downloaded and tested APK on device

**🎉 You're ready to start building!**

---

## 📚 Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Console](https://console.firebase.google.com/)
- [Fastlane Documentation](https://docs.fastlane.tools/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Clean Architecture Guide](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Mustafa Elbaz**

- GitHub: [@mustafaelbaz5](https://github.com/mustafaelbaz5)

---

## ⭐ Show Your Support

If this template helped you, please give it a ⭐️ on GitHub!

---

Made with ❤️ by Mustafa Elbaz
