import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orot/components/visit_card.dart';
import 'package:orot/models/family.dart';
import 'package:orot/models/visit.dart';
import 'package:orot/pages/volunteer/visits_history/visits_history_app_bar.dart';

class VisitsHistoryPage extends StatefulWidget {
  const VisitsHistoryPage({super.key});

  @override
  State<VisitsHistoryPage> createState() => _VisitsHistoryPageState();
}

class _VisitsHistoryPageState extends State<VisitsHistoryPage> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(237, 237, 237, 1),
      appBar: VisitsHistoryAppBar(),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          alignment: Alignment.bottomCenter,
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 15, left: 30, right: 30),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 229, 243, 1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: getHistoryVisits(),
        ),
      ),
    );
  }

  Widget getHistoryVisits() {
    final visits = _getHistory();
    return ListView.separated(
      addSemanticIndexes: true,
      controller: controller,
      itemCount: visits.length,
      separatorBuilder: (_, index) => visits[index],
      itemBuilder: (context, index) {
        return SizedBox(height: 5);
      },
    );
  }

  List<VisitCard> _getHistory() {
    return [
      for (int i = 0; i < 10; i++)
        VisitCard(
          hasVisited: Random().nextDouble() <= 0.3,
          visit: Visit(
              id: 'id',
              family: Family(
                  id: 'id', name: 'name', address: 'ddd', contact: "con"),
              visitDate: DateTime.now()),
        )
    ];
  }
}
