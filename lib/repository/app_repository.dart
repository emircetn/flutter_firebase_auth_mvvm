import 'dart:io';

import '../common/models/app_user.dart';
import '../common/services/firebase_auth_service.dart';
import '../common/services/firebase_firestore_service.dart';
import '../common/services/firebase_stroge_service.dart';

import '../get_it.dart';

class AppRepository {
  //////////////////singleton olarak servisler tanımlandı////////////////////

  final FirebaseAuthService? _firebaseAuthService = getIt<FirebaseAuthService>();
  final FirebaseFirestoreService? _firebaseFirestoreService = getIt<FirebaseFirestoreService>();
  final FirebaseStrogeService? _firebaseStrogeService = getIt<FirebaseStrogeService>();
  AppUser? appUser;

  //////////////////////////////////////////////////////////////////////
  //////////////////////////////auth////////////////////////////////////

  Future<AppUser?> currentUser() async {
    var appUserFB = _firebaseAuthService!.getCurrentUser();
    if (appUserFB != null) {
      var appUserDB = await _firebaseFirestoreService!.readUserFromDatabase(appUserFB.userID);
      if (appUserDB != null) {
        appUser = appUserDB;
        return appUserDB;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<bool> registerWithMail(String email, String password) async {
    AppUser? result = await _firebaseAuthService!.registerWithMail(email, password);
    if (result != null) {
      appUser = result;
      return true;
    }
    return false;
  }

  Future<bool> loginWithMail(String email, String password) async {
    AppUser? result = await _firebaseAuthService!.loginWithMail(email, password);
    if (result != null) {
      result = await _firebaseFirestoreService!.readUserFromDatabase(result.userID);
    }
    if (result != null) {
      appUser = result;
      return true;
    }
    return false;
  }

  Future<bool> loginOrRegisterWithGoogle() async {
    var result = await _firebaseAuthService!.loginOrRegisterWithGoogle();
    if (result != null) {
      result = await _firebaseFirestoreService!.saveOrReadGoogleUserToDatabase(result);
    }
    if (result != null) {
      appUser = result;
      return true;
    }
    return false;
  }

  Future signOut() async {
    appUser = null;
    await _firebaseAuthService!.signOut();
  }

  //////////////////////////////////////////////////////////////////////
  //////////////////////////////firestore///////////////////////////////

  Future<bool> saveUserToDatabase(AppUser appUser) async {
    return await (_firebaseFirestoreService!.saveUserToDatabase(appUser));
  }

  Future<String?> uploadProfilePhotoToDatabase(String userID, File profilePicture) async {
    return await (_firebaseStrogeService!.uploadProfilePhotoToDatabase(userID, profilePicture));
  }
}
