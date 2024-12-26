import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/modal/district_modal.dart';

class DistrictsDropdown extends StatefulWidget {
  ValueChanged<String?> onSelectedIdChange;
  List<District> districts;
  String selectedDistrictId;

  DistrictsDropdown(
      {super.key,
      required this.districts,
      required this.selectedDistrictId,
      required this.onSelectedIdChange});

  @override
  State<DistrictsDropdown> createState() => _DistrictsDropdownState();
}

class _DistrictsDropdownState extends State<DistrictsDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            'מחוז',
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 20)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerRight,
          child: DropdownButton<District>(
            value: widget.districts.firstWhere(
                (district) => district.id == widget.selectedDistrictId),
            onChanged: (District? newValue) {
              widget.onSelectedIdChange(newValue?.id);
            },
            items: widget.districts
                .map<DropdownMenuItem<District>>((District district) {
              return DropdownMenuItem<District>(
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
