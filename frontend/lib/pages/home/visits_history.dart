import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/pages/home/visit.dart';

class VisitsHistory extends StatefulWidget {
  const VisitsHistory({super.key});

  @override
  State<VisitsHistory> createState() => _VisitsHistoryState();
}

class _VisitsHistoryState extends State<VisitsHistory> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    List<Visit> visits = getVisitHistory();
    return Column(
      children: [
        _title(),
        SizedBox(
            height: 308,
            child: Scrollbar(
                controller: controller,
                thumbVisibility: true,
                child: ListView.builder(
                    controller: controller,
                    padding: const EdgeInsets.all(0),
                    itemCount: visits.length,
                    itemBuilder: (context, index) {
                      return visits[index];
                    })))
      ],
    );
  }

  List<Visit> getVisitHistory() {
    return [
      for (int i = 0; i < 5; i++)
        Visit(
          visitButtonOption: VisitButtonOption.view,
          address: "history visit $i",
        )
    ];
  }

  Widget _title() {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Text(
        'היסטוריית פגישות',
        style: GoogleFonts.assistant(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}
