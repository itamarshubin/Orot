import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class HomePageTitle extends StatefulWidget {
  const HomePageTitle({super.key, this.displayName});

  final String? displayName;

  @override
  State<HomePageTitle> createState() => _HomePageTitleState();
}

class _HomePageTitleState extends State<HomePageTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20.sh,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(249, 204, 220, 1),
            Color.fromRGBO(246, 201, 186, 1)
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(300, 40),
          bottomRight: Radius.elliptical(300, 40),
        ),
      ),
      child: _title(),
    );
  }

  Widget _title() {
    return Container(
        padding: const EdgeInsets.only(right: 30, bottom: 70),
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            Text(
              'שלום ${widget.displayName}',
              style: GoogleFonts.assistant(
                fontWeight: FontWeight.w700,
                fontSize: 5.sw,
                color: Color.fromRGBO(178, 39, 89, 1),
              ),
            ),
            SvgPicture.asset(
              height: 5.sh,
              'assets/img/hand.svg',
            ),
          ],
        ));
  }
}
