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
      margin: EdgeInsets.symmetric(vertical: 5.sh),
      child: InkWell(
        customBorder: const CircleBorder(),
        child: Transform.rotate(
          angle: 180 * math.pi / 180,
          child: Icon(
            Icons.arrow_back,
            size: 30,
          ),
        ),
        onTap: () =>
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          Widget targetPage = Placeholder();
          if (userPermission == null) {
            // handle if userPermission was not provided
            throw Exception("User Permission was not provided");
          } else if (userPermission == UserPermission.admin) {
            targetPage = AdminNavigation();
          } else if (userPermission == UserPermission.coordinator) {
            targetPage = CoordinatorNavigation();
          } else if (userPermission == UserPermission.volunteer) {
            targetPage = VolunteerNavigation();
          }
          return targetPage;
        })),
      ),
    );
  }
}
