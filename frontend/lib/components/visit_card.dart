import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

enum PlacementOption { showPastDate, editButton }

class VisitCard extends StatefulWidget {
  final String address;
  final String dateAndTime;
  final PlacementOption? placementOption;

  const VisitCard({
    super.key,
    this.address = 'איפושהו בעולם', //TODO: pass object that has all visit info
    this.dateAndTime =
        '16:00 | 19.1', //TODO: get an actual datetime and parse it to this
    this.placementOption,
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
        width: double.infinity,
        height: 110,
        padding: const EdgeInsets.all(10),
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
                  child: _getPlacementOption(),
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

  Widget _getPlacementOption() {
    if (widget.placementOption == PlacementOption.editButton) {
      return CustomGradientButton(
          text: 'שינוי פרטים',
          onPressed: () {
            //TODO: implement the button functunality
          });
    } else if (widget.placementOption == PlacementOption.showPastDate) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 229, 99, 0.34),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Text(
          'לפני 5 ימים',
          //TODO: should parse from datetime (we didn't pass it yet)
          style: GoogleFonts.assistant(
            color: Color.fromRGBO(196, 127, 25, 1),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      );
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
