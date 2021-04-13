class AppUser {
  String? userID, email;

  AppUser({
    required this.userID,
    required this.email,
  });

  AppUser.fromMap(Map<String, dynamic> userMap) {
    userID = userMap['userID'];
    email = userMap['email'];
  }
  Map<String, dynamic> toMap() {
    var userMap = <String, dynamic>{};

    userMap['userID'] = userID;
    userMap['email'] = email;
    return userMap;
  }
}
