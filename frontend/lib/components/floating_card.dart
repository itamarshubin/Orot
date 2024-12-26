import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class FloatingCard extends StatelessWidget {
  final Widget child;

  const FloatingCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        child,
        SvgPicture.asset('assets/img/shadow_floating_object.svg'),
      ],
    );
  }
}
