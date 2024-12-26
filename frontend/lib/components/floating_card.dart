import 'package:flutter/material.dart';
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
        Card(
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            height: 190,
            child: child,
          ),
        ),
        SvgPicture.asset('assets/img/shadow_floating_object.svg'),
      ],
    );
  }
}
