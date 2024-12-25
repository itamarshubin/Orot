import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VisitCard extends StatefulWidget {
  final String address;
  final String dateAndTime;
  final bool showEditButton;
  final bool? hasVisited;

  //TODO: get an actual datetime and parse it to this
  //TODO: pass object that has all visit info
  const VisitCard({
    super.key,
    this.address = 'איפושהו בעולם',
    this.showEditButton = false,
    this.dateAndTime = '16:00 | 19.1',
    this.hasVisited,
  });

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
        width: 330,
        height: 110,
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
                  widget.dateAndTime,
                  'assets/icons/pick_date_icon.svg',
                ),
                Transform.translate(
                  offset: const Offset(-5, -10),
                  // Moves 5 to the left and 10 higher
                  child: _editButton(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                TextWithIcon(
                  widget.address,
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
    debugPrint(widget.hasVisited.toString());
    if (widget.hasVisited == true) {
      return Color.fromRGBO(252, 164, 164, 1);
    } else if (widget.hasVisited == false) {
      return Color.fromRGBO(141, 235, 166, 1);
    }
    return Colors.white;
  }

  Widget _editButton() {
    if (widget.showEditButton == true) {
      return CustomGradientButton(
          text: 'שינוי פרטים',
          onPressed: () {
            //TODO: implement the button functunality
          });
    }
    return SizedBox.shrink();
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
              textStyle: const TextStyle(
            color: Color(0xff205273),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ))),
      SvgPicture.asset(iconPath, width: 22, height: 22),
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
