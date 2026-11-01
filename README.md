# Demos

A blank Flutter starting point for quick experiments. It boots Firebase and shows a single placeholder `DemoPage`, so a new idea can be tried against Firestore without setting up a project from scratch.

## What's in it

- `lib/main.dart`: initializes Firebase (`Firebase.initializeApp()`) and opens `DemoPage`.
- `lib/demo_page.dart`: an empty `Scaffold` titled "Demo"; replace its body with whatever you're trying out.
- `cloud_firestore` is already a dependency.

## Running it

1. iOS already has a `GoogleService-Info.plist`; for Android add `android/app/google-services.json` from your Firebase project (or run `flutterfire configure`).
2. Then:

```sh
flutter pub get
flutter run
```

## Tech stack

- Flutter, Dart `>=2.17.6 <3.0.0` (pre-Dart 3, so use Flutter 3.7.x or older)
- `firebase_core`, `cloud_firestore`
