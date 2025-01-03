import 'package:flutter/material.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/components/visit_card.dart';
import 'package:orot/models/visit.dart';
import 'package:orot/pages/volunteer/visits_history/visits_history_app_bar.dart';
import 'package:orot/providers/visits_provider.dart';
import 'package:provider/provider.dart';

class VisitsHistoryPage extends StatefulWidget {
  const VisitsHistoryPage({super.key});

  @override
  State<VisitsHistoryPage> createState() => _VisitsHistoryPageState();
}

class _VisitsHistoryPageState extends State<VisitsHistoryPage> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<VisitsProvider>(context, listen: false)
            .getVisitsHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            return Center(
              child: Text('Error: ${snapshot.error}\n${snapshot.stackTrace}'),
            );
          } else {
            return Scaffold(
              backgroundColor: Color.fromRGBO(237, 237, 237, 1),
              appBar: VisitsHistoryAppBar(),
              body: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.topCenter,
                  height: double.infinity,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15, left: 30, right: 30),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(233, 229, 243, 1),
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: FixedColumn(
                      children: _getVisitsHistory(snapshot.data as List<Visit>),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }

  List<VisitCard> _getVisitsHistory(List<Visit> visits) {
    return [
      for (int i = 0; i < visits.length; i++)
        VisitCard(
          // hasVisited: Random().nextDouble() <= 0.3,
          visit: visits[i],
        )
    ];
  }
}
