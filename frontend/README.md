# orot

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Updating Flutter Native Splash

There are two files.

- flutter_native_splash-dev.yaml => edit this to test
- flutter_native_splash-prod.yaml => edit this for production

After your changes run this command to update the splash files:

```bash
dart run flutter_native_splash:create --flavor dev
```

Note that you need to choose your flavor (environment).  
To take changes from `flutter_native_splash-prod.yaml` file simple change `--flavor prod`

