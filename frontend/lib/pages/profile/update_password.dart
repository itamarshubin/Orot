import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:orot/components/field_input.dart';
import 'package:orot/pages/volunteer/navigation.dart';
import 'package:orot/services/auth_service.dart';
import 'package:sizer/sizer.dart';

class UpdatePassword extends StatelessWidget {
  UpdatePassword({super.key});

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _backToProfile(context),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20.sw,
              vertical: 10.sh,
            ),
            child: Column(
              children: [_newPasswordInput(), _updatePasswordButton(context)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _newPasswordInput() {
    return FieldInput(
        inputValidation: (text) {
          if (text != null && text.length < 6) {
            return "הסיסמה לא תקינה";
          }
          return null;
        },
        textEditingController: _passwordController,
        inputTitle: 'סיסמה חדשה');
  }

  Widget _updatePasswordButton(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 2.h),
      child: ElevatedButton(
        onPressed: () async {
          if (_passwordController.text.length < 6) {
            return;
          }
          await AuthService().updatePassword(_passwordController.text);
          if (!context.mounted) return;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => VolunteerNavigation(
                        initialIndex: 0,
                      )));
          Fluttertoast.showToast(
            msg: "סיסמה עודכנה בהצלחה",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 14.0,
          );
        },
        child: Text('עדכון סיסמה'),
      ),
    );
  }
}

Widget _backToProfile(BuildContext context) {
  return Container(
    alignment: Alignment.topRight,
    child: InkWell(
      customBorder: const CircleBorder(),
      child: Transform.rotate(
        angle: 180 * math.pi / 180,
        child: Icon(
          Icons.arrow_back,
          size: 30,
        ),
      ),
      onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => VolunteerNavigation(
                    initialIndex: 0,
                  ))),
    ),
  );
}
