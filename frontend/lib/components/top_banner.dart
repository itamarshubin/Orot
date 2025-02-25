import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:sizer/sizer.dart';

class TopBanner extends StatefulWidget {
  final String title;
  final Widget? childBefore;
  final Widget? childAfter;

  const TopBanner({
    super.key,
    required this.title,
    this.childBefore,
    this.childAfter,
  });

  @override
  State<TopBanner> createState() => _TopBannerState();
}

class _TopBannerState extends State<TopBanner> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: 17.sh,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFFFC3C3), // Corrected first color
                  Color(0xFFFECED6), // Corrected second color
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(300, 40),
                bottomRight: Radius.elliptical(300, 40),
              ),
            ),
            child: FixedColumn(
              spacing: 0,
              children: [
                if (widget.childBefore != null) widget.childBefore!,
                Center(
                  child: Text(
                    widget.title,
                    style: GoogleFonts.openSans(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF205273),
                    ),
                  ),
                ),
                if (widget.childAfter != null) widget.childAfter!,
              ],
            )),
      ],
    );
  }
}
