import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orot/models/user.dart';
import 'package:orot/pages/admin/components/district_cube.dart';
import 'package:orot/pages/coordinator/volunteer_data.dart';
import 'package:orot/services/admin_service.dart';
import 'package:orot/services/coordinator_service.dart';

class DistrictList extends StatefulWidget {
  const DistrictList({super.key});

  @override
  State<DistrictList> createState() => _DistrictListState();
}

class _DistrictListState extends State<DistrictList> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AdminService().getDistricts(),
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
              _title(context),
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
                      ? Text('no data - districts')
                      : ListView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: snapshot.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return DistrictCube(
                              district: snapshot.data![index],
                            );
                          }))
            ]),
          ));
        }
      },
    );
  }
}

Widget _title(BuildContext context) {
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
        child: Text("מחוזות",
            style: GoogleFonts.openSans(
                fontSize: 37,
                fontWeight: FontWeight.w700,
                color: Color(0xFF205273))),
      )
    ],
  );
}
