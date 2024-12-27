import 'package:flutter/cupertino.dart';

class FixedColumn extends StatelessWidget {
  final List<Widget> children;
  final double spacing;

  const FixedColumn({
    super.key,
    required this.children,
    this.spacing = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: spacing,
      children: children,
    );
  }
}
