import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/pages/home/visit.dart';

class VisitsList extends StatefulWidget {
  final List<VisitCard> visits;
  final String listTitle;

  const VisitsList(this.listTitle, this.visits, {super.key});

  @override
  State<VisitsList> createState() => _VisitsListState();
}

class _VisitsListState extends State<VisitsList> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Container(
          alignment: Alignment.topRight,
          child: Text(widget.listTitle,
              style: GoogleFonts.assistant(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            addSemanticIndexes: true,
            controller: controller,
            padding: const EdgeInsets.all(0),
            itemCount: widget.visits.length,
            itemBuilder: (_, index) => widget.visits[index],
          ),
        )
      ],
    );
  }
}
