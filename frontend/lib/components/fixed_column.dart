import 'package:flutter/cupertino.dart';

class FixedColumn extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final MainAxisSize mainAxisSize;

  const FixedColumn({
    super.key,
    required this.children,
    this.mainAxisSize = MainAxisSize.max,
    this.spacing = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: mainAxisSize,
      spacing: spacing,
      children: children,
    );
  }
}
