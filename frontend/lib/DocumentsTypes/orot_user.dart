import 'package:cloud_firestore/cloud_firestore.dart';

class OrotUser {
  final String displayName;

  OrotUser({
    required this.displayName,
  });

  factory OrotUser.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return OrotUser(
      displayName: data['displayName'] ?? '',
    );
  }
}
