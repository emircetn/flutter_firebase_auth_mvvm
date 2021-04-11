class AppUser {
  String? userID, userName, nameAndSurName, profileUrl, email;

  AppUser.toFirebaseUser({
    required this.userID,
    required this.email,
  });
  AppUser.toFirebaseGoogleUser({
    required this.userID,
    required this.email,
    required this.nameAndSurName,
    required this.profileUrl,
  });

  AppUser.fromMap(Map<String, dynamic> userMap) {
    userID = userMap['userID'];
    userName = userMap['userName'];
    email = userMap['email'];
    nameAndSurName = userMap['nameAndSurName'];
    profileUrl = userMap['profileUrl'];
  }
  Map<String, dynamic> toMap() {
    var userMap = <String, dynamic>{};

    userMap['userID'] = userID;
    userMap['userName'] = userName;
    userMap['email'] = email;
    userMap['nameAndSurName'] = nameAndSurName;
    userMap['profileUrl'] = profileUrl;
    return userMap;
  }
}
