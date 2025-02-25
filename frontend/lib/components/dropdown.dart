import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/fixed_column.dart';

abstract class DropdownItem {
  String get id;

  String get name;
}

class Dropdown<T extends DropdownItem> extends StatefulWidget {
  final String title;
  final Function? onInit;
  final List<T> items;
  final ValueChanged<String?> onSelectedIdChange;
  final String selectedItemId;

  const Dropdown({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItemId,
    required this.onSelectedIdChange,
    this.onInit,
  });

  @override
  State<Dropdown<T>> createState() => _DropdownState<T>();
}

class _DropdownState<T extends DropdownItem> extends State<Dropdown<T>> {
  late T selectedItem;

  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
  }

  @override
  Widget build(BuildContext context) {
    return FixedColumn(
      children: [
        Text(
          widget.title,
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        DropdownButton<T>(
          value: widget.items
              .firstWhere((item) => item.id == widget.selectedItemId),
          onChanged: (T? newValue) {
            if (newValue != null) {
              widget.onSelectedIdChange(newValue.id);
            }
          },
          items: widget.items.map<DropdownMenuItem<T>>((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.name),
            );
          }).toList(),
        )
      ],
    );
  }
}
