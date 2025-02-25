import 'package:flutter/material.dart';
import 'package:orot/components/back_to_main_page_button.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/components/future_handler.dart';
import 'package:orot/components/top_banner.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/coordinator/volunteers_list/volunteer_row.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:orot/services/coordinator_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class VolunteersList extends StatefulWidget {
  final String? districtId;

  const VolunteersList({super.key, this.districtId});

  @override
  State<VolunteersList> createState() => _VolunteersListState();
}

class _VolunteersListState extends State<VolunteersList> {
  final TextEditingController controller = TextEditingController();
  late Future<List<User>> _volunteersFuture;

  @override
  void initState() {
    super.initState();
    _volunteersFuture =
        CoordinatorService().getVolunteers(id: widget.districtId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      var districtId = userProvider.user?.district?.id;
      _volunteersFuture = CoordinatorService()
          .getVolunteers(id: widget.districtId ?? districtId);
      return FutureHandler<List<User>>(
        future: _volunteersFuture,
        onSuccess: (context, volunteers) {
          return Scaffold(
              body: FixedColumn(
            spacing: 2.sh,
            children: [
              (volunteers.isEmpty)
                  ? Text('אין מתנדבות במחוז זה')
                  : TopBanner(
                      childBefore:
                          userProvider.userPermission == UserPermission.admin
                              ? BackToMainPage(
                                  userPermission: userProvider.userPermission)
                              : null,
                      title:
                          "מתנדבות מחוז ${volunteers.first.district?.name ?? 'לא ידוע'}",
                    ),
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: volunteers.length,
                    itemBuilder: (_, index) {
                      User volunteer = volunteers[index];
                      return VolunteerCube(volunteer: volunteer);
                    }),
              )
            ],
          ));
        },
      );
    });
  }
}
