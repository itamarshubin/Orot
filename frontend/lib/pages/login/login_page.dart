import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/field_input.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/services/auth_service.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: const LoginForm(),
            ),
            Positioned(
                bottom: 0,
                left: 10,
                child: SvgPicture.asset("assets/img/kids_with_clouds.svg"))
          ],
        ));
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              ),
              FieldInput(
                inputTitle: 'סיסמה',
                textEditingController: _passwordController,
                obscureText: true,
                hintText: '•••',
              ),
              _forgotPassword(),
              SizedBox(height: 20),
              _signInButton(context),
              _signOutButton(),
              SvgPicture.asset(
                '/assets/img/kids_with_clouds.svg',
                width: double.infinity,
                height: 300,
              )
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
            textStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 32,
          color: Color.fromRGBO(32, 82, 1145, 1),
        )),
      ),
    );
  }

  Widget _forgotPassword() {
    return Container(
        alignment: Alignment.topRight,
        child: InkWell(
          onTap: () => {
            //TODO: implement forgot password
            Fluttertoast.showToast(msg: "forgot password")
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

  Widget _signInButton(BuildContext context) {
    return MainButton(
        text: 'כניסה למערכת',
        onPress: () async {
          await AuthService().signin(
            email: _emailController.text,
            password: _passwordController.text,
            context: context,
          );
        });
  }

  //TODO: delete
  Widget _signOutButton() {
    return ElevatedButton(
        onPressed: () {
          AuthService().quickSignout();
        },
        child: const Text('signOUt'));
  }
}
