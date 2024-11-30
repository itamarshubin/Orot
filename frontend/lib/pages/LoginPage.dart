import 'package:flutter/material.dart';
import 'package:orot/components/LoginForm.dart';

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
        padding: const EdgeInsets.only(top: 20),
        child: Container(
          decoration: const BoxDecoration(
              borderRadius:
                  BorderRadiusDirectional.vertical(top: Radius.circular(30)),
              color: Colors.white),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Column(children: [LoginForm(),Image.asset('assets/img/cloud1.png'),Image.asset('assets/img/cloud2.png'), Image.asset('assets/img/aww.png')]),
          ),
        ),
      ),
    );
  }
}

