import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/components/visit_card.dart';
import 'package:orot/models/family.dart';
import 'package:orot/models/visit.dart';
import 'package:orot/pages/admin/admin_page.dart';
import 'package:orot/pages/volunteer/home/home_label.dart';
import 'package:orot/pages/volunteer/home/home_title.dart';
import 'package:orot/pages/volunteer/home/visits_list.dart';
import 'package:orot/pages/volunteer/new_visit/new_visit_page.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:orot/services/volunteer_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  List<Visit>? _upcomingVisits = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserData();
      _getUpcomingVisits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Scaffold(
          resizeToAvoidBottomInset: false,
          body: _isLoading
              ? _loading()
              : Column(
                  spacing: 10,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Positioned(
                          child:
                              HomePageTitle(displayName: userProvider.userName),
                        ),
                        Positioned(
                          bottom: -65,
                          child: _nearestVisit(),
                        )
                      ],
                    ),
                    SizedBox(height: 70),
                    _addVisitButton(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: _visits(),
                    ),
                  ],
                ));
    });
  }

  Widget _nearestVisit() {
    return Container(
        alignment: Alignment.topRight,
        child: Column(
          spacing: 10,
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Transform.translate(
              offset: const Offset(10, 0),
              child: HomeLabelText(text: 'הביקור הקרוב'),
            ),
            if (_upcomingVisits?[0] != null)
              VisitCard(
                showEditButton: true,
                visit: _upcomingVisits![0],
              )
          ],
        ));
  }

  //TODO: replace with something good
  Widget _loading() {
    return Text('loading...');
  }

  Widget _addVisitButton() {
    return MainButton(
      text: 'קביעת מפגש',
      onPress: () => {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const NewVisitPage()))
      },
    );
  }

  Future<void> _getUserData() async {
    await context.read<UserProvider>().getUserData();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _getUpcomingVisits() async {
    final List<Visit>? upcomingVisits =
        await VolunteerService().getUpcomingVisits();
    setState(() {
      _upcomingVisits = upcomingVisits;
    });
  }
}

Widget _visits() {
  return Column(
    spacing: 10,
    children: [
      VisitsList("פגישות עתידיות", getFuture()),
      VisitsList("היסטורית פגישות", getHistory()),
    ],
  );
}

List<VisitCard> getHistory() {
  return [
    for (int i = 0; i < 10; i++)
      VisitCard(
        hasVisited: Random().nextDouble() <= 0.3,
        showEditButton: true,
        visit: Visit(
            id: 'id',
            family: Family(id: 'id', name: 'name', address: 'ddd', contact: ''),
            visitDate: DateTime.now()),
      )
  ];
}

List<VisitCard> getFuture() {
  return [
    for (int i = 0; i < 10; i++)
      VisitCard(
        visit: Visit(
            id: 'id',
            family: Family(id: 'id', name: 'name', address: 'ddd', contact: ''),
            visitDate: DateTime.now()),
      )
  ];
}

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('dd.MM | HH:mm');
  return formatter.format(dateTime);
}
