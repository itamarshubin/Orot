import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/admin/components/back_button.dart';
import 'package:orot/pages/coordinator/volunteer_data.dart';
import 'package:orot/services/coordinator_service.dart';

class VolunteersList extends StatefulWidget {
  final String? id;
  const VolunteersList({super.key, this.id});

  @override
  State<VolunteersList> createState() => _VolunteersListState();
}

class _VolunteersListState extends State<VolunteersList> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: CoordinatorService().getVolunteers(id: widget.id),
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
              body: Container(
            child: Column(children: [
              if (snapshot.data?.isNotEmpty ?? false)
                _title(context, snapshot.data?[0], id: widget.id),
              SizedBox(
                height: 20,
              ),

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
                          itemBuilder: (context, index) {
                            return VolunteerCube(
                              volunteer: snapshot.data![index],
                              id: widget.id,
                            );
                          }))
            ]),
          ));
        }
      },
    );
  }
}

Widget _title(BuildContext context, User? volunteer, {String? id}) {
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
              Color(0xFFFFC3C3), // Corrected first color
              Color(0xFFFECED6), // Corrected second color
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
        //TODO: get the real district
        child: Text("מתנדבות מחוז ${volunteer?.district?.name ?? 'לא ידוע'}",
            style: GoogleFonts.openSans(
                fontSize: 37,
                fontWeight: FontWeight.w700,
                color: Color(0xFF205273))),
      ),
      if (id != null)
        BackToAdminPage(
          isAdmin: true,
        ),
    ],
  );
}

class VolunteerCube extends StatelessWidget {
  final User volunteer;
  final String? id;
  const VolunteerCube({super.key, required this.volunteer, this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => VolunteerData(
                      volunteer,
                      isAdmin: id != null,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        alignment: Alignment.center,
        color: Colors.white,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _CubeText(volunteer.family?.name ?? 'משפחה לא ידועה'),
            _CubeText(volunteer.district?.name ?? "מחוז לא ידוע"),
            _CubeText(volunteer.name),
          ],
        ),
      ),
    );
  }

  Widget _CubeText(String text) {
    return Text(text,
        style:
            GoogleFonts.varelaRound(fontSize: 18, fontWeight: FontWeight.w400));
  }
}
