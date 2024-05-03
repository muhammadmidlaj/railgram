// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);


class UserProfile {
  int? userid;
  String username;
  String firstname;
  String lastname;
  String profileimgurl;
  String coverimgurl;
  String phonenumber;
  String email;
  UserProfile({
    required this.userid,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.profileimgurl,
    required this.coverimgurl,
    required this.phonenumber,
    required this.email,
  });

  Map<String, dynamic> toMap(source) {
    return {
      'userid': userid,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'profileimgurl': profileimgurl,
      'coverimgurl': coverimgurl,
      'phonenumber': phonenumber,
      'email': email
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
        userid: map['userid'] ?? '',
        username: map['username'] ?? '',
        firstname: map['firstname'] ?? '',
        lastname: map['lastname'] ?? '',
        profileimgurl: map['profileimgurl'] ?? '',
        coverimgurl: map['coverimgurl'] ?? '',
        phonenumber: map['phonenumber'] ?? '',
        email: map['email'] ?? '');
  }

  // factory UserProfile.fromJson(String source) =>
  //     UserProfile.fromMap(json.decode(source));

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userid: json["userid"],
        username: json["username"],
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        profileimgurl: json["profileimgurl"] ?? '',
        coverimgurl: json["coverimgurl"] ?? '',
        phonenumber: json["phonenumber"] ?? '',
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid.toString(),
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "profileimgurl": profileimgurl,
        "coverimgurl": coverimgurl,
        "phonenumber": phonenumber,
        "email": email,
      };
}
