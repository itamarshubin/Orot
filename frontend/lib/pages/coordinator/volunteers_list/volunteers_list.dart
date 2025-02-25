import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/back_to_main_page_button.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/components/future_handler.dart';
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
                  : _buildListTitle(
                      userProvider: userProvider,
                      districtName: volunteers.first.district?.name,
                      districtId: widget.districtId,
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

Widget _buildListTitle({
  required UserProvider userProvider,
  String? districtName,
  String? districtId,
}) {
  return Container(
    width: double.infinity,
    height: 20.sh,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFFC3C3),
          Color(0xFFFECED6),
        ],
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.elliptical(300, 40),
        bottomRight: Radius.elliptical(300, 40),
      ),
    ),
    child: FixedColumn(children: [
      if (userProvider.userPermission == UserPermission.admin)
        BackToMainPage(userPermission: userProvider.userPermission),
      Center(
        child: Text(
          "מתנדבות מחוז ${districtName ?? 'לא ידוע'}",
          style: GoogleFonts.openSans(
            fontSize: 37,
            fontWeight: FontWeight.w700,
            color: Color(0xFF205273),
          ),
        ),
      )
    ]),
  );
}
