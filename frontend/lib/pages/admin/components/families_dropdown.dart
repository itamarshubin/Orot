import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/models/family.dart';

class FamiliesDropdown extends StatefulWidget {
  ValueChanged<String?> onSelectedFamilyChange;
  List<Family> families;
  String selectedFamilyId;

  FamiliesDropdown(
      {super.key,
      required this.families,
      required this.selectedFamilyId,
      required this.onSelectedFamilyChange});

  @override
  State<FamiliesDropdown> createState() => _FamiliesDropdownState();
}

class _FamiliesDropdownState extends State<FamiliesDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            'משפחה',
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20)),
          ),
        ),
        Container(
          alignment: Alignment.centerRight,
          child: DropdownButton<Family>(
            value: widget.families
                .firstWhere((family) => family.id == widget.selectedFamilyId),
            onChanged: (Family? newValue) {
              widget.onSelectedFamilyChange(newValue?.id);
            },
            items:
                widget.families.map<DropdownMenuItem<Family>>((Family family) {
              return DropdownMenuItem<Family>(
                value: family,
                child: Text(family.name),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
