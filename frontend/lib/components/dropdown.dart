import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/fixed_column.dart';

class Dropdown<T> extends StatefulWidget {
  final ValueChanged<T?> onSelectedChange;
  final List<T> items;
  final T selectedItem;
  final Function? onInit;
  final String Function(T) getLabel;
  final String Function(T) getId;
  final String title;

  const Dropdown({
    super.key,
    required this.title,
    required this.items,
    required this.selectedItem,
    required this.onSelectedChange,
    required this.getLabel,
    required this.getId,
    this.onInit,
  });

  @override
  State<Dropdown<T>> createState() => _DropdownState<T>();
}

class _DropdownState<T> extends State<Dropdown<T>> {
  late T selectedItem;

  @override
  void initState() {
    super.initState();
    widget.onInit?.call();
    selectedItem = widget.items.firstWhere(
      (item) => widget.getId(item) == widget.getId(widget.selectedItem),
      orElse: () => widget.selectedItem,
    );
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
          value: selectedItem,
          onChanged: (T? newValue) {
            if (newValue != null) {
              setState(() => selectedItem = newValue);
              widget.onSelectedChange(newValue);
            }
          },
          items: widget.items.map<DropdownMenuItem<T>>((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(widget.getLabel(item)),
            );
          }).toList(),
        )
      ],
    );
  }
}
