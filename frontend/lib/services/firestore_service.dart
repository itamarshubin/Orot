import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:orot/DocumentsTypes/orot_user.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<OrotUser?> _getCurrentUser() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('volunteers').doc(currentUser.uid).get();
      if (userDoc.exists) {
        return OrotUser.fromFirestore(userDoc);
      }
    }
    return null;
  }

  Future<String?> getDisplayName() async {
    return (await _getCurrentUser())?.displayName;
  }
}
