import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/app_top_style.dart';
import 'package:orot/components/field_input.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/components/main_button_v2.dart';
import 'package:orot/pages/login/sent_mail_page.dart';
import 'package:orot/utils/validate_email.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({
    super.key,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(243, 243, 243, 1),
        toolbarHeight: 15.sh,
        flexibleSpace: AppTopStyle(),
      ),
      body: Container(
        color: Color.fromRGBO(243, 243, 243, 1),
        padding: EdgeInsets.symmetric(vertical: 5.sh, horizontal: 10.sw),
        child: SizedBox.expand(
          child: FixedColumn(
            spacing: 5.sh,
            children: [
              title(),
              FieldInput(
                textEditingController: emailController,
                inputTitle: 'מייל',
                autofocus: true,
                inputTitleStyle: GoogleFonts.assistant(
                  color: Color.fromRGBO(52, 105, 139, 1),
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                inputValidation: (text) {
                  if (text == null || text.isEmpty) {
                    return 'יש להזין מייל';
                  } else if (!isEmailValid(text)) {
                    return "מייל לא בפורמט הנכון";
                  }
                  return null;
                },
              ),
              SizedBox(),
              Center(
                child: MainButton2(
                  text: "יצירת סיסמה חדשה",
                  onPress: () async {
                    final String email = emailController.text;
                    if (email.isNotEmpty && isEmailValid(email)) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SentMailPage(email)));
                    } else {
                      Fluttertoast.showToast(
                          msg: "אנא כתבי את המייל בשדה למעלה");
                    }
                  },
                ),
              ),
              Spacer(),
              Center(
                child: Image.asset(
                  'assets/img/logo.png',
                  scale: 2,
                  alignment: Alignment.bottomCenter,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Text title() {
    return Text(
      "יצירת סיסמה חדשה",
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: GoogleFonts.openSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(178, 39, 89, 1),
      ),
    );
  }
}
