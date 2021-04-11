import 'dart:io';

import 'package:auth_firebase/models/app_user.dart';
import 'package:auth_firebase/services/firebase_auth_service.dart';
import 'package:auth_firebase/services/firebase_firestore_service.dart';
import 'package:auth_firebase/services/firebase_stroge_service.dart';
import 'package:auth_firebase/utils/get_it.dart';

class UserRepository {
  //////////////////singleton olarak servisler tanımlandı////////////////////

  FirebaseAuthService? _firebaseAuthService = getIt<FirebaseAuthService>();
  FirebaseFirestoreService? _firebaseFirestoreService = getIt<FirebaseFirestoreService>();
  FirebaseStrogeService? _firebaseStrogeService = getIt<FirebaseStrogeService>();

  //////////////////////////////auth////////////////////////////////////

  Future<AppUser?> currentUser() async {
    AppUser? appUserFB = _firebaseAuthService!.getCurrentUser();
    if (appUserFB != null) {
      AppUser? appUserDB = await (_firebaseFirestoreService!.readUserFromDatabase(appUserFB.userID));
      if (appUserDB != null)
        return appUserDB;
      else
        return appUserFB;
    } else
      return null;
  }

  Future<String> registerWithMail(String email, String password) async {
    return await _firebaseAuthService!.registerWithMail(email, password);
  }

  Future loginWithMail(String email, String password) async {
    var result = await _firebaseAuthService!.loginWithMail(email, password);
    if (result is String)
      return result;
    else {
      AppUser? user = await (_firebaseFirestoreService!.readUserFromDatabase(result.userID));
      if (user != null)
        return user;
      else
        return result;
    }
  }

  Future<AppUser?> loginOrRegisterWithGoogle() async {
    AppUser? result = await _firebaseAuthService!.loginOrRegisterWithGoogle();
    if (result != null) {
      result = await (_firebaseFirestoreService!.saveOrReadGoogleUserToDatabase(result));
    }
    return result;
  }

  Future signOut() async {
    await _firebaseAuthService!.signOut();
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    return await _firebaseAuthService!.sendPasswordResetEmail(email);
  }

  //////////////////////////////////////////////////////////////////////
  //////////////////////////////firestore///////////////////////////////

  Future<bool> userNameCheckFromDatabase(String? userName) async {
    return await _firebaseFirestoreService!.userNameCheckFromDatabase(userName);
  }

  Future<bool> saveUserToDatabase(AppUser appUser) async {
    return await (_firebaseFirestoreService!.saveUserToDatabase(appUser));
  }

  Future<String?> uploadProfilePhotoToDatabase(String userID, File profilePicture) async {
    return await (_firebaseStrogeService!.uploadProfilePhotoToDatabase(userID, profilePicture));
  }

  ////////////////////////////////////////////////////////////////////////////

}
