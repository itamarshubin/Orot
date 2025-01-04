import 'package:flutter/cupertino.dart';

class AppTopStyle extends StatelessWidget {
  const AppTopStyle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(300, 40),
          bottomRight: Radius.elliptical(300, 40),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(249, 204, 220, 1),
            Color.fromRGBO(246, 201, 186, 1)
          ],
        ),
      ),
    );
  }
}
