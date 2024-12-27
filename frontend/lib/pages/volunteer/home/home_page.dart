import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/components/visit_card.dart';
import 'package:orot/pages/volunteer/home/home_label.dart';
import 'package:orot/pages/volunteer/home/home_title.dart';
import 'package:orot/pages/volunteer/home/visits_list.dart';
import 'package:orot/pages/volunteer/new_visit/new_visit_page.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUserData();
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
                          child: _nearestVisitTitle(),
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

  Widget _nearestVisitTitle() {
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
            VisitCard(showEditButton: true)
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
        address: "חנה רובינא $i, חיפה",
      )
  ];
}

List<VisitCard> getFuture() {
  return [
    for (int i = 0; i < 10; i++)
      VisitCard(
        address: "חנה רובינא $i, חיפה",
      )
  ];
}
