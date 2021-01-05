import 'package:flutter/material.dart';

class AppUser {
  String userID, userName, nameAndSurName, profileUrl, location, email;

  AppUser.toFirebase({
    @required this.userID,
    @required this.email,
  });

  AppUser.fromMap(Map<String, dynamic> userMap) {
    userID = userMap['userID'];
    userName = userMap['userName'];
    email = userMap['email'];
    nameAndSurName = userMap['nameAndSurName'];
    profileUrl = userMap['profileUrl'];
    location = userMap['location'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> userMap = Map<String, dynamic>();

    userMap['userID'] = userID;
    userMap['userName'] = userName;
    userMap['email'] = email;
    userMap['nameAndSurName'] = nameAndSurName;
    userMap['profileUrl'] = profileUrl ??
        "https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png";
    userMap['location'] = location;
    return userMap;
  }
}
