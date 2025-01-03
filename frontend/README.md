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

Flutter Native Splash helps us update all files that related to splash art at the app launch.  
The package will change it for android, ios and web (configurable by you).
That means you can only change one file and it will change it for all platforms!.

Although you can use only one file for this. The best practice is to make one file for development
and one for production.  
These are our files:

- flutter_native_splash.yaml => edit this to test
- flutter_native_splash-production.yaml => edit this for production

After your changes run this command to update the splash files:

```bash
dart run flutter_native_splash:create
```

And for production run this:

```bash
dart run flutter_native_splash:create --flavor production
```

Note That for production it will create in `android/app/production` and will not use the default
which is `main`.

## Router structure

```
[GoRouter] Full paths for routes:
├─ (ShellRoute)
│ └─/login (LoginPage)
├─/management (AdminPage)
├─/admin (Placeholder)
│ └─/admin/home (AdminPage)
├─/volunteer (Placeholder)
│ └─ (ShellRoute)
│   ├─/volunteer/home (HomePage)
│   ├─/volunteer/history (VisitsHistoryPage)
│   └─/volunteer/profile (ProfilePage)
└─/coordinator (Placeholder)
  └─/coordinator/home (VolunteersPage)
```