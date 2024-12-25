import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VisitsHistoryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const VisitsHistoryAppBar({super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 200,
      centerTitle: true,
      leading: Transform.translate(
        offset: Offset(0, -20),
        child: SvgPicture.asset('assets/img/hand.svg'),
      ),
      title: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Transform.translate(
            offset: Offset(0, -20),
            child: Text(
              "היסטוריית המפגשים שלי",
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
          ),
        ],
      ),
      titleTextStyle: GoogleFonts.assistant(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(178, 39, 89, 1),
      ),
      flexibleSpace: Container(
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
      ),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight + kTextTabBarHeight);
}
