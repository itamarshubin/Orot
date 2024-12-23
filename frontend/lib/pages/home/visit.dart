import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

enum VisitButtonOption { edit, view }

class Visit extends StatefulWidget {
  final String address;
  final VisitButtonOption visitButtonOption;

  const Visit({
    super.key,
    this.address = 'איפושהו בעולם',
    this.visitButtonOption = VisitButtonOption.edit,
  });

  @override
  State<Visit> createState() => _VisitState();
}

class _VisitState extends State<Visit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 85,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: const BoxDecoration(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(30)),
          color: Color(0xFFFFFFFF)),
      child: Column(
        children: [
          _visitDate(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _getButton(widget.visitButtonOption),
              _visitLocation(),
            ],
          )
        ],
      ),
    );
  }

  Widget _visitDate() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '16:00 | 19.1',
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    color: Color(0xff205273),
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
          ),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset(
            'assets/icons/pick_date_icon.svg',
            width: 25,
            height: 25,
          )
        ],
      ),
    );
  }

  Widget _visitLocation() {
    return Container(
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.fromLTRB(0, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.address,
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    color: Color(0xff205273),
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
          ),
          const SizedBox(
            width: 8,
          ),
          SvgPicture.asset(
            'assets/icons/location_icon.svg',
            width: 25,
            height: 25,
          )
        ],
      ),
    );
  }

//TODO: implement the button functunality
  Widget _getButton(VisitButtonOption option) {
    switch (option) {
      case VisitButtonOption.edit:
        return _updateVisitButton('שינוי פרטים', () {});
      case VisitButtonOption.view:
        return _updateVisitButton('צפייה בסיכום', () {});
    }
  }

  Widget _updateVisitButton(String text, void Function() onPressed) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 36,
      width: 88,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
        borderRadius: BorderRadius.circular(17),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFD9D9D9),
            const Color(0xFFF27E7E).withOpacity(0.26),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.heebo(
                textStyle: const TextStyle(
                    color: Color(0xff205273),
                    fontWeight: FontWeight.w500,
                    fontSize: 15)),
          ),
        ),
      ),
    );
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
      height: 36,
      margin: const EdgeInsets.only(top: 166, left: 56),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        gradient: LinearGradient(
          colors: [
            const Color(0xFFD9D9D9),
            const Color(0xFFF27E7E).withOpacity(0.26),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
