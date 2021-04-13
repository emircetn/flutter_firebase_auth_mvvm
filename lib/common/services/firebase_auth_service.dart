import '../models/app_user.dart';
import 'abstract/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService extends AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  AppUser? getCurrentUser() {
    return _firebaseAuth.currentUser == null ? null : _firebaseUserToAppUser(_firebaseAuth.currentUser!);
  }

  @override
  Future<AppUser?> loginOrRegisterWithGoogle() async {
    var _googleSignInAccount = await GoogleSignIn().signIn().catchError((onError) {
      print('Error $onError');
    });
    if (_googleSignInAccount != null) {
      var _googleAuth = await _googleSignInAccount.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        var userFB = await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken,
          accessToken: _googleAuth.accessToken,
        ));
        var _firebaseUser = userFB.user!;
        return _firebaseGoogleUserToAppUser(_firebaseUser);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future loginWithMail(String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return _firebaseUserToAppUser(userCredential.user!);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  @override
  Future registerWithMail(String email, String password) async {
    try {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        return _firebaseUserToAppUser(userCredential.user!);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw e.code;
    }
  }

  @override
  Future signOut() async {
    await _firebaseAuth.signOut();
    final _googleSignIn = GoogleSignIn();
    await _googleSignIn.signOut();
  }

  AppUser _firebaseUserToAppUser(User firebaseUser) {
    return AppUser(userID: firebaseUser.uid, email: firebaseUser.email);
  }

  AppUser _firebaseGoogleUserToAppUser(User firebaseGoogleUser) {
    return AppUser(
      userID: firebaseGoogleUser.uid,
      email: firebaseGoogleUser.email,
    );
  }
}
