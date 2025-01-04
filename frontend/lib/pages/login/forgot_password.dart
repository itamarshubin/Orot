import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/services/auth_service.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    super.key,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Placeholder(),
    );
  }

  Widget _forgotPassword() {
    String email = "test";
    return Container(
        alignment: Alignment.topRight,
        child: InkWell(
          onTap: () async => {
            if (email.isNotEmpty)
              Fluttertoast.showToast(
                  msg: await _auth.resetPasswordWithEmail(email))
            else
              Fluttertoast.showToast(msg: "אנא כתבי את המייל בשדה למעלה")
          },
          child: Text(
            "שכחתי סיסמה",
            style: GoogleFonts.varelaRound(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Color(0xffA1A1A1),
            ),
          ),
        ));
  }
}
