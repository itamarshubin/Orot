import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/components/fixed_column.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/admin/components/back_button.dart';
import 'package:orot/pages/coordinator/volunteers_list/volunteer_row.dart';
import 'package:orot/providers/user_provider.dart';
import 'package:orot/services/coordinator_service.dart';
import 'package:provider/provider.dart';

class VolunteersList extends StatefulWidget {
  final String? districtId;

  const VolunteersList({super.key, this.districtId});

  @override
  State<VolunteersList> createState() => _VolunteersListState();
}

class _VolunteersListState extends State<VolunteersList> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      var districtId = userProvider.user?.district?.id;
      return FutureBuilder(
        future: CoordinatorService()
            .getVolunteers(id: widget.districtId ?? districtId),
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
                body: FixedColumn(children: [
              if (snapshot.data?.isNotEmpty ?? false)
                _title(context, snapshot.data?[0],
                    districtId: widget.districtId),
              SizedBox(height: 20),

              //TODO: add search bar
              // Container(
              //     margin: const EdgeInsets.only(left: 100),
              //     width: 250,
              //     child: TextField(
              //         controller: controller,
              //         textDirection: TextDirection.rtl,
              //         decoration: InputDecoration(
              //           hintTextDirection: TextDirection.rtl,
              //           hintText: "חיפוש שם",
              //           border: OutlineInputBorder(
              //             borderRadius: BorderRadius.circular(30.0),
              //           ),
              //         ))),
              Expanded(
                child: (snapshot.data?.isEmpty ?? true)
                    ? Text('no data - volunteers')
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (_, index) {
                          return VolunteerCube(
                              volunteer: snapshot.data![index],
                              id: widget.districtId);
                        }),
              )
            ]));
          }
        },
      );
    });
  }
}

Widget _title(BuildContext context, User? volunteer, {String? districtId}) {
  print('volunteer: ${volunteer?.permission}');
  final double pageHeight = MediaQuery.of(context).size.height;
  return Stack(
    children: [
      Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.13,
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
      ),
      Container(
        height: pageHeight * 0.1,
        alignment: Alignment.center,
        child: Text(
          "מתנדבות מחוז ${volunteer?.district?.name ?? 'לא ידוע'}",
          style: GoogleFonts.openSans(
            fontSize: 37,
            fontWeight: FontWeight.w700,
            color: Color(0xFF205273),
          ),
        ),
      ),
      if (districtId != null)
        BackToMainPage(userPermission: UserPermission.admin),
    ],
  );
}
