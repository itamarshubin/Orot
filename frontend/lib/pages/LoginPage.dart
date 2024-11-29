import 'package:flutter/material.dart';
import 'package:orot/pages/HomePage.dart';

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
                  BorderRadiusDirectional.vertical(top: Radius.circular(80)),
              color: Colors.white),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
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
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 30, 0, 30),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'כניסה למערכת',
                    style: TextStyle(fontSize: 30, color: Colors.blue[900]),
                  ),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: const Text('שם משתמש',
                        style: TextStyle(
                          fontSize: 20,
                        ))),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(top: 30),
                    child: const Text('סיסמה',
                        style: TextStyle(
                          fontSize: 20,
                        ))),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                Container(
                    width: 400,
                    margin: const EdgeInsets.only(top: 80),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      color: Colors.blue[900],
                    ),
                    child: OutlinedButton(
                        onPressed: () {
                          if (nameController.text == "itamar" && passwordController.text == "123") { //TODO: replace with real check
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Homepage()));
                          }
                        },
                        child: const Text('כניסה למערכת',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20))))
              ],
          )));
  }
}
