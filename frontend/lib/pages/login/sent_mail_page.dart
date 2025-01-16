import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/app_top_style.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/services/auth_service.dart';
import 'package:sizer/sizer.dart';

class SentMailPage extends StatefulWidget {
  final String email;

  const SentMailPage(
    this.email, {
    super.key,
  });

  @override
  State<SentMailPage> createState() => _SentMailPageState();
}

class _SentMailPageState extends State<SentMailPage> {
  final _auth = AuthService();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _auth.resetPasswordWithEmail(widget.email),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(243, 243, 243, 1),
            toolbarHeight: 15.sh,
            flexibleSpace: AppTopStyle(),
          ),
          body: Container(
            color: Color.fromRGBO(243, 243, 243, 1),
            padding: EdgeInsets.only(top: 5.sh, left: 10.sw, right: 10.sw),
            child: SizedBox.expand(
              child: FixedColumn(
                spacing: 3.sh,
                children: [
                  title(),
                  content(),
                  note(),
                  Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      'assets/img/sent_mail.svg',
                      height: 25.sh,
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.sh),
                      child: Image.asset(
                        'assets/img/logo.png',
                        scale: 2,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container title() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "לינק ליצירת סיסמה חדשה\n בדרך אלייך למייל!",
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: Color.fromRGBO(178, 39, 89, 1),
        ),
      ),
    );
  }

  Text content() {
    String textContent = 'על מנת לשנות את הסיסמה';
    textContent += '\n';
    textContent += 'מייל נשלח לכתובת ${widget.email}';
    textContent += '\n';
    textContent += 'אם לא קיבלת שום דבר, נסי להסתכל בתיבת הספאם :)';
    return Text(
      textContent,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: GoogleFonts.assistant(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(97, 97, 97, 1),
      ),
    );
  }

  Text note() {
    String textContent =
        'אם את חושבת שיש כאן טעות, ניתן לפנות לרכזת המקושרת אלייך.';
    return Text(
      textContent,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: GoogleFonts.assistant(
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: Color.fromRGBO(97, 97, 97, 1),
      ),
    );
  }
}
