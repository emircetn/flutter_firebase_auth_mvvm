import 'package:auth_firebase/models/app_user.dart';
import 'package:auth_firebase/services/abstract/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService extends DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final String userCollection = 'users';

  @override
  Future<AppUser?> readUserFromDatabase(String? userID) async {
    var _documentSnapshot = await _firebaseFirestore.collection(userCollection).doc(userID).get();
    var _userMap = _documentSnapshot.data();
    if (_userMap == null) {
      return null;
    } else {
      return AppUser.fromMap(_userMap);
    }
  }

  @override
  Future<AppUser?> saveOrReadGoogleUserToDatabase(AppUser appUser) async {
    AppUser? user;
    var dr = _firebaseFirestore.collection('users').doc(appUser.userID);
    var documentSnapshot = await dr.get();
    if (!documentSnapshot.exists) {
      var userMap = appUser.toMap();
      await dr.set(userMap);
      user = AppUser.fromMap(userMap);
    } else {
      user = await (readUserFromDatabase(appUser.userID));
    }
    return user;
  }

  @override
  Future<bool> saveUserToDatabase(AppUser appUser) async {
    try {
      await _firebaseFirestore.collection(userCollection).doc(appUser.userID).set(appUser.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> userNameCheckFromDatabase(String? userName) async {
    var users = await _firebaseFirestore.collection(userCollection).where('userName', isEqualTo: userName).get();
    if (users.docs.isNotEmpty) {
      return false;
    }
    return true;
  }
}
