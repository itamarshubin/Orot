import 'package:flutter/material.dart';
import 'package:orot/pages/visits_history/visits_history_app_bar.dart';

class VisitsHistoryPage extends StatefulWidget {
  const VisitsHistoryPage({super.key});

  @override
  State<VisitsHistoryPage> createState() => _VisitsHistoryPageState();
}

class _VisitsHistoryPageState extends State<VisitsHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VisitsHistoryAppBar(),
      body: Container(
        child: Column(
          textDirection: TextDirection.rtl,
          spacing: 10,
          children: [],
        ),
      ),
    );
  }
}
