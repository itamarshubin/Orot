import 'package:flutter/material.dart';
import 'package:orot/components/visit_card.dart';
import 'package:orot/pages/home/home_label.dart';

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
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 5,
      children: [
        Container(
          alignment: Alignment.topRight,
          child: HomeLabelText(text: widget.listTitle),
        ),
        SizedBox(
          height: 215,
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
