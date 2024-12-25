import 'package:flutter/material.dart';
import 'package:orot/pages/home/home_page.dart';
import 'package:orot/pages/visits_history/visits_history_app_bar.dart';

class VisitsHistoryPage extends StatefulWidget {
  const VisitsHistoryPage({super.key});

  @override
  State<VisitsHistoryPage> createState() => _VisitsHistoryPageState();
}

class _VisitsHistoryPageState extends State<VisitsHistoryPage> {
  ScrollController controller = ScrollController();
  final visits = getHistory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}
