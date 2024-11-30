
class Profile {
  String fullname;
  String address;
  String phoneNumber;

  Profile.fromJson(Map<String, dynamic> json)
      : fullname = json['fullname'],
        address = json['address'],
        phoneNumber = json['phoneNumber'];

}

class FamilyProfile extends Profile {
  String contact;

  FamilyProfile.fromJson(super.json)
    : contact = json['contact'] ?? 'ccc',
      super.fromJson();
}
