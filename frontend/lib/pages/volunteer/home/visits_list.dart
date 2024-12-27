import 'package:flutter/material.dart';
import 'package:orot/components/visit_card.dart';
import 'package:orot/pages/volunteer/home/home_label.dart';

class VisitsList extends StatefulWidget {
  final List<VisitCard> visits;
  final String listTitle;

  const VisitsList(this.listTitle, this.visits, {super.key});

  @override
  State<VisitsList> createState() => _VisitsListState();
}

class _VisitsListState extends State<VisitsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 5,
      children: [
        Container(
          alignment: Alignment.topRight,
          child: HomeLabelText(text: widget.listTitle),
        ),
        SizedBox(
          height: widget.visits.length * 120,
          child: ListView.builder(
            shrinkWrap: true,
            addSemanticIndexes: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemCount: widget.visits.length,
            itemBuilder: (_, index) => widget.visits[index],
          ),
        )
      ],
    );
  }
}
