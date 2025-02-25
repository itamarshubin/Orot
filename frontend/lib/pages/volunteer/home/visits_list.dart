import 'package:flutter/material.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/components/visit_card.dart';
import 'package:orot/models/visit.dart';
import 'package:orot/pages/volunteer/home/home_label.dart';
import 'package:sizer/sizer.dart';

class VisitsList extends StatefulWidget {
  final List<Visit> visits;
  final String listTitle;

  const VisitsList({
    required this.listTitle,
    required this.visits,
    super.key,
  });

  @override
  State<VisitsList> createState() => _VisitsListState();
}

class _VisitsListState extends State<VisitsList> {
  @override
  Widget build(BuildContext context) {
    if (widget.visits.isEmpty) {
      return Text('no visits');
    }

    return FixedColumn(
      spacing: 5.sh,
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
            itemBuilder: (_, index) => VisitCard(visit: widget.visits[index]),
          ),
        )
      ],
    );
  }
}
