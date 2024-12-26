import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orot/components/main_button.dart';
import 'package:orot/pages/admin/admin_page.dart';
import 'package:orot/pages/home/visit.dart';
import 'package:orot/pages/home/visits_list.dart';
import 'package:orot/pages/profile_page.dart';
import 'package:orot/user_provider.dart';
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
              ? _Loading()
              : Column(
                  spacing: 10,
                  children: [
                    Stack(
                      children: [
                        Title(
                          displayName: userProvider.userName,
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(40, 100, 40, 0),
                          child: Column(
                            children: [
                              _nearestVisitTitle(),
                              getNearestVisit(),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          spacing: 10,
                          children: [_addVisitButton(), _visits()],
                        ))
                  ],
                ));
    });
  }

//TODO: replace with something good
  Widget _Loading() {
    return Text('loading...');
  }

  Widget _addVisitButton() {
    return MainButton(
      text: 'קביעת מפגש',
      onPress: () => {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const AdminPage()))
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
