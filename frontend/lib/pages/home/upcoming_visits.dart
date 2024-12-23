import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/pages/home/visit.dart';

class UpcomingVisits extends StatefulWidget {
  const UpcomingVisits({super.key});

  @override
  State<UpcomingVisits> createState() => _UpcomingVisitsState();
}

class _UpcomingVisitsState extends State<UpcomingVisits> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<VisitCard> visits = getUpcomingVisits();
    return Column(
      children: [
        _title(),
        SizedBox(
            height: 115,
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

  List<VisitCard> getUpcomingVisits() {
    return [
      for (int i = 0; i < 5; i++)
        VisitCard(
          visitButtonOption: VisitButtonOption.edit,
          address: "חנה רובינא $i, חיפה",
        )
    ];
  }

  Widget _title() {
    return Container(
      alignment: Alignment.topRight,
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Text(
        'פגישות עתידיות',
        style: GoogleFonts.assistant(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    );
  }
}
