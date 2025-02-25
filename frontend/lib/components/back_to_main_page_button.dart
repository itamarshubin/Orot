import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/admin/navigation.dart';
import 'package:orot/pages/coordinator/navigation.dart';
import 'package:orot/pages/volunteer/navigation.dart';
import 'package:sizer/sizer.dart';

class BackToMainPage extends StatelessWidget {
  final UserPermission? userPermission;

  const BackToMainPage({super.key, required this.userPermission});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.symmetric(vertical: 2.sh),
      child: InkWell(
        customBorder: const CircleBorder(),
        child: Transform.rotate(
          angle: 180 * math.pi / 180,
          child: Icon(Icons.arrow_back, size: 30),
        ),
        onTap: () =>
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          Widget targetPage = Placeholder();
          switch (userPermission) {
            case UserPermission.admin:
              targetPage = AdminNavigation();
              break;
            case UserPermission.coordinator:
              targetPage = CoordinatorNavigation();
              break;
            case UserPermission.volunteer:
              targetPage = VolunteerNavigation();
              break;
            case null:
              throw Exception("User Permission was not provided");
          }
          return targetPage;
        })),
      ),
    );
  }
}
