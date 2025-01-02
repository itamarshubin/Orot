import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:orot/pages/admin/admin_page.dart';
import 'package:orot/pages/admin/navigation.dart';
import 'package:orot/pages/coordinator/navigation.dart';

class BackToAdminPage extends StatelessWidget {
  final bool isAdmin;
  const BackToAdminPage({super.key, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.symmetric(vertical: 50),
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
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      isAdmin ? AdminNavigation() : CoordinatorNavigation()))
        },
      ),
    );
  }
}
