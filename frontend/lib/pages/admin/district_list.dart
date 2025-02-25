import 'package:flutter/material.dart';
import 'package:orot/components/future_handler.dart';
import 'package:orot/components/top_banner.dart';
import 'package:orot/models/district.dart';
import 'package:orot/pages/admin/district_cube.dart';
import 'package:orot/services/admin_service.dart';

class DistrictList extends StatefulWidget {
  const DistrictList({super.key});

  @override
  State<DistrictList> createState() => _DistrictListState();
}

class _DistrictListState extends State<DistrictList> {
  final TextEditingController controller = TextEditingController();
  final Future<List<District>> _districtsFuture = AdminService().getDistricts();

  @override
  Widget build(BuildContext context) {
    return FutureHandler<List<District>>(
      future: _districtsFuture,
      onSuccess: (context, districts) {
        return Scaffold(
            body: Column(
          children: [
            TopBanner(title: 'מחוזות'),
            Expanded(
                child: districts.isEmpty
                    ? Text('no data - districts')
                    : ListView.builder(
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: districts.length,
                        itemBuilder: (context, index) {
                          return DistrictCube(
                            district: districts[index],
                          );
                        }))
          ],
        ));
      },
    );
  }
}
