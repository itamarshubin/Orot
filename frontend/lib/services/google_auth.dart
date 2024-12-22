import 'package:google_sign_in/google_sign_in.dart';

Future<String?> signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: '',
    scopes: <String>[],
  );
  final GoogleSignInAccount? account = await googleSignIn.signIn();
  final GoogleSignInAuthentication auth = await account!.authentication;
  return auth.accessToken;
}
