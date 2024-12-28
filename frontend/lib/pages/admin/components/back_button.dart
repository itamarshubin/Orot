import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:orot/pages/admin/admin_page.dart';

class BackToAdminPage extends StatelessWidget {
  const BackToAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(bottom: 20),
      child: InkWell(
        customBorder: const CircleBorder(),
        child: Transform.rotate(
          angle: 180 * math.pi / 180,
          child: Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        onTap: () => {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (BuildContext context) => AdminPage()))
        },
      ),
    );
  }
}
