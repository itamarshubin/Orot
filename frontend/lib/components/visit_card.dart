import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/models/visit.dart';
import 'package:orot/pages/volunteer/home/home_page.dart';
import 'package:sizer/sizer.dart';

class VisitCard extends StatefulWidget {
  final bool showEditButton;
  final bool showCountdown;
  final bool? hasVisited;
  final Visit visit;

  const VisitCard(
      {super.key,
      this.showEditButton = false,
      this.showCountdown = false,
      this.hasVisited,
      required this.visit});

  @override
  State<VisitCard> createState() => _VisitCardState();
}

class _VisitCardState extends State<VisitCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Color.fromRGBO(255, 195, 195, 0.37),
      child: Container(
        width: 100.sw,
        height: 15.sh,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border(
            left: BorderSide(
              color: haVisitedBorderColor(),
              width: 5,
            ),
          ),
        ),
        child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: [
                TextWithIcon(
                  formatDateTime(widget.visit.visitDate),
                  'assets/icons/pick_date_icon.svg',
                ),
                Transform.translate(
                  offset: const Offset(-5, -10),
                  // Moves 5 to the left and 10 higher
                  child: _extraData(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                TextWithIcon(
                  widget.visit.family.address,
                  'assets/icons/location_icon.svg',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color haVisitedBorderColor() {
    if (widget.hasVisited == true) {
      return Color.fromRGBO(252, 164, 164, 1);
    } else if (widget.hasVisited == false) {
      return Color.fromRGBO(141, 235, 166, 1);
    }
    return Colors.white;
  }

  Widget _extraData() {
    if (widget.showEditButton == true) {
      return CustomGradientButton(
          text: 'שינוי פרטים',
          onPressed: () {
            //TODO: implement the button functunality
          });
    }
    if (widget.showCountdown == true) {
      return _countDown();
    }
    return SizedBox.shrink();
  }

  Widget _countDown() {
    Color color;
    if (widget.visit.visitDate.difference(DateTime.now()).inDays > 8) {
      color = Color.fromARGB(255, 255, 255, 255);
    } else if (widget.visit.visitDate.difference(DateTime.now()).inDays < 15) {
      color = Color.fromRGBO(255, 229, 99, 0.34);
    } else {
      color = Color.fromARGB(255, 255, 79, 79);
    }

    int daysDifference =
        DateTime.now().difference(widget.visit.visitDate).inDays;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      margin: EdgeInsets.only(top: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: daysDifference == 0
          ? Text(
              'לפני פחות מיום',
              style: GoogleFonts.assistant(
                  color: Color(0xffC47F19),
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            )
          : Text("לפני $daysDifference ימים",
              style: GoogleFonts.assistant(
                  color: Color(0xffC47F19),
                  fontSize: 15,
                  fontWeight: FontWeight.w600)),
    );
  }
}

class TextWithIcon extends StatelessWidget {
  final String text;
  final String iconPath;

  const TextWithIcon(this.text, this.iconPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: 10, children: <Widget>[
      Text(text,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.openSans(
              textStyle: TextStyle(
            color: Color(0xff205273),
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ))),
      SvgPicture.asset(
        iconPath,
        height: 2.7.sh,
      ),
    ]);
  }
}

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomGradientButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      height: 36,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 3),
            blurRadius: 3,
            spreadRadius: 2,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFBEBE), Color(0xFFFFE5E5)],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
        ),
        child: Center(
          child: Text(text,
              style: GoogleFonts.heebo(
                color: Color(0xff205273),
                fontWeight: FontWeight.w400,
                fontSize: 15,
              )),
        ),
      ),
    );
  }
}
