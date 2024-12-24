import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:orot/firebase_options.dart';
import 'package:orot/pages/login/login_page.dart';

import 'components/notification.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

void saveDeviceToken(String userId) async {
  String? token = await messaging.getToken();
  if (token != null) {
    // Save this token in Firestore under the user's document
    //TODO: we should probably add deviceToken key (not 100% sure we need this but looks like we do).
  }
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //TODO: Remove this lines when deploying to production
  try {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }

  // This part ask for permission for alert.
  await FirebaseMessaging.instance
      .requestPermission(alert: true, badge: true, sound: true);
  // This line is listening on even
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Open Sans'),
      home: user == null ? const LoginPage() : const LoginPage(),
    );
  }
}
