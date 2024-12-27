import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/field_input.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:orot/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return ScaffoldGradientBackground(
          resizeToAvoidBottomInset: false,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            colors: [
              Color(0xFFFFC3C3),
              Color(0xFFFFFFFF),
            ],
          ),
          appBar: AppBar(
            toolbarHeight: 100,
            centerTitle: true,
            title: Image.asset('assets/img/logo.png'),
            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(30)),
                    color: Color(0xffF3EDED)),
                child: loginForm(context, userProvider),
              ),
              Positioned(
                  bottom: 0,
                  left: 10,
                  child: SvgPicture.asset("assets/img/kids_with_clouds.svg"))
            ],
          ));
    });
  }

  Form loginForm(context, userProvider) {
    return Form(
      child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 40, right: 40),
          child: Column(
            spacing: 10,
            children: [
              _title(),
              FieldInput(
                inputTitle: 'מייל',
                textEditingController: _emailController,
                hintText: 'example@gmail.com',
                onEditingCompleteFunction: () => {
                  //TODO: validate mail before submit
                },
                inputValidation: (text) {
                  if (text == null || text.isEmpty) {
                    return 'יש להזין מייל';
                  }
                  return null;
                },
              ),
              FieldInput(
                inputTitle: 'סיסמה',
                textEditingController: _passwordController,
                obscureText: true,
                hintText: '•••',
                inputValidation: (text) {
                  if (text == null || text.isEmpty) {
                    return 'יש להזין סיסמה';
                  }
                  return null;
                },
              ),
              _forgotPassword(),
              SizedBox(height: 20),
              _signInButton(context, userProvider),
              _signOutButton(),
            ],
          )),
    );
  }

  Widget _title() {
    return Container(
      alignment: Alignment.centerRight,
      child: Text(
        'כניסה למערכת',
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w400,
          fontSize: 32,
          color: Color.fromRGBO(32, 82, 1145, 1),
        ),
      ),
    );
  }

  Widget _forgotPassword() {
    String email;
    return Container(
        alignment: Alignment.topRight,
        child: InkWell(
          onTap: () async => {
            email = _emailController.text.trim(),
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

  Widget _signInButton(BuildContext context, UserProvider userProvider) {
    return MainButton(
        text: 'כניסה למערכת',
        onPress: () async {
          await _auth.signin(
            email: _emailController.text,
            password: _passwordController.text,
          );
          await userProvider.getUserData();
          context.go('/');
        });
  }

  //TODO: delete
  Widget _signOutButton() {
    return ElevatedButton(
        onPressed: () => _auth.quickSignout(), child: const Text('signOUt'));
  }
}
