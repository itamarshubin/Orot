import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

enum VisitButtonOption { edit, view }

class VisitCard extends StatefulWidget {
  final String address;
  final String dateAndTime;
  final VisitButtonOption visitButtonOption;

  const VisitCard({
    super.key,
    this.address = 'איפושהו בעולם',
    this.dateAndTime = '16:00 | 19.1',
    this.visitButtonOption = VisitButtonOption.edit,
  });

  @override
  State<VisitCard> createState() => _VisitCardState();
}

class _VisitCardState extends State<VisitCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        height: 100,
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: 5,
              children: [
                TextWithIcon(
                  widget.dateAndTime,
                  'assets/icons/pick_date_icon.svg',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 5,
              children: [
                _getButton(VisitButtonOption.edit),
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

//TODO: implement the button functunality
  Widget _getButton(VisitButtonOption option) {
    switch (option) {
      case VisitButtonOption.edit:
        return CustomGradientButton(text: 'שינוי פרטים', onPressed: () {});
      case VisitButtonOption.view:
        return CustomGradientButton(text: 'צפייה בסיכום', onPressed: () {});
    }
  }
}

class TextWithIcon extends StatelessWidget {
  final String text;
  final String iconPath;

  const TextWithIcon(this.text, this.iconPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(spacing: 5, children: <Widget>[
      Text(text,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.openSans(
              textStyle: const TextStyle(
            color: Color(0xff205273),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ))),
      SvgPicture.asset(iconPath, width: 25, height: 25),
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
      // margin: const EdgeInsets.only(left: 10),
      padding: EdgeInsets.zero,
      height: 35,
      width: 90,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFD9D9D9),
            const Color(0xFFFAA5A5).withAlpha(250),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
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
                  textStyle: const TextStyle(
                color: Color(0xff205273),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ))),
        ),
      ),
    );
  }
}
