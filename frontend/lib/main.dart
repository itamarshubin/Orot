import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:orot/firebase_options.dart';
import 'package:orot/pages/login/login_page.dart';
import 'package:orot/pages/volunteer/navigation.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:provider/provider.dart';

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

  FlutterNativeSplash.remove();

  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: OrotApp(),
  ));
}

class OrotApp extends StatelessWidget {
  const OrotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Open Sans'),
        home: userProvider.user == null ? LoginPage() : VolunteerNavigation(),
      );
    });
  }
}
