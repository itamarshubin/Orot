import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:orot/firebase_options.dart';
import 'package:orot/global_variables.dart' as globals;
import 'package:orot/pages/login_page.dart';
import 'package:orot/pages/newVisit/new_visit_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  globals.user = FirebaseAuth.instance.currentUser;

  //TODO: Remove this lines when deploying to production
  try {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
    FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Open Sans'),
      home: globals.user == null ? const LoginPage() : const NewVisitPage(),
    );
  }
}
