import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/services/coordinator_service.dart';

class FamiliesDropdown extends StatefulWidget {
  List<Family> families;
  String selectedFamilyId;
  ValueChanged<String?> onSelectedFamilyChange;
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
            items: widget.families
                .map<DropdownMenuItem<Family>>((Family district) {
              return DropdownMenuItem<Family>(
                value: district,
                child: Text(district.name),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}

class Family {
  final String id;
  final String name;

  Family({required this.id, required this.name});
}
