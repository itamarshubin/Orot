<div align="center">
  <img src="frontend/assets/img/logo.png" alt="Orot Logo">
</div>

This app project used for managing Orot project.
You can find more about Orot project here.

- [Orot Meuchadim](https://meuchadim.org.il/pages/project.php?id=8)
- [Orot Facebook](https://www.facebook.com/people/%D7%90%D7%95%D7%A8%D7%95%D7%AA-%D7%A0%D7%A2%D7%A8%D7%95%D7%AA-%D7%9C%D7%9E%D7%A2%D7%9F-%D7%90%D7%9C%D7%9E%D7%A0%D7%95%D7%AA/61563429077737/?_rdr)

## Getting Started - Developer

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

#### How can I use CouldFunctions?

Search in the internet how to install the firebase cli then install and login.
after that, go to `cloudFunctions\functions` and start the firebase emulator by using these
commands.

```shell
cd cloudFunctions\functions
firebase emulators:start
```

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

### How to generate new model

You can see [here](frontend/lib/models/README.md) How it can be done.  
Also we have some examples in [here](frontend/lib/models/).   

