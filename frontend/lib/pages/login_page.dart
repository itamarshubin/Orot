import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 100,
        title: Image.asset('assets/img/logo.png', fit: BoxFit.cover),
        backgroundColor: const Color.fromARGB(132, 209, 147, 167),
      ),
      body: Container(
        color: const Color.fromARGB(132, 209, 147, 167),
        padding: const EdgeInsets.only(top: 50),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius:
                  BorderRadiusDirectional.vertical(top: Radius.circular(30)),
              color: Color(0xffF3EDED)),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: const LoginForm(),
          ),
        ),
      ),
    );
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
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                _title(),
                const SizedBox(
                  height: 20,
                ),
                _emailAddress(),
                const SizedBox(
                  height: 30,
                ),
                _password(),
                const SizedBox(
                  height: 50,
                ),
                _signIn(context),
                _signoutButton()
              ],
            )));
  }

  Widget _title() {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 30, 0, 30),
      alignment: Alignment.centerRight,
      child: Text(
        'כניסה למערכת',
        style: GoogleFonts.openSans(
            textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 32,
          color: Color.fromRGBO(32, 82, 1145, 1),
        )),
      ),
    );
  }

  Widget _emailAddress() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            alignment: Alignment.centerRight,
            child: Text(
              'שם משתמש',
              style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 20)),
            )),
        const SizedBox(
          height: 10,
        ),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
              filled: true,
              hintText: 'example@gmail.com',
              hintStyle: const TextStyle(
                  color: Color(0xff6A6A6A),
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(24))),
        )
      ],
    );
  }

  Widget _password() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            'סיסמה',
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          obscureText: true,
          controller: _passwordController,
          decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xffF7F7F9),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(24))),
        )
      ],
    );
  }

  Widget _signIn(BuildContext context) {
    return MainButton(
        text: 'כניסה למערכת',
        onPress: () async {
          await AuthService().signin(
              email: _emailController.text,
              password: _passwordController.text,
              context: context);
        });
  }

  //TODO: delete
  Widget _signoutButton() {
    return ElevatedButton(
        onPressed: () {
          AuthService().quickSignout();
        },
        child: Text('signOUt'));
  }
}
