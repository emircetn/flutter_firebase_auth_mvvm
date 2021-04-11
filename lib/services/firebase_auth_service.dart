import 'package:auth_firebase/models/app_user.dart';
import 'package:auth_firebase/services/abstract/auth_service.dart';
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
    GoogleSignInAccount? _googleSignInAccount = await GoogleSignIn().signIn().catchError((onError) {
      print("Error $onError");
    });
    if (_googleSignInAccount != null) {
      GoogleSignInAuthentication _googleAuth = await _googleSignInAccount.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        UserCredential userFB = await _firebaseAuth.signInWithCredential(GoogleAuthProvider.credential(
          idToken: _googleAuth.idToken,
          accessToken: _googleAuth.accessToken,
        ));
        User _firebaseUser = userFB.user!;
        return _firebaseGoogleUserToAppUser(_firebaseUser);
      } else
        return null;
    } else
      return null;
  }

  @override
  Future loginWithMail(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.emailVerified)
        return _firebaseUserToAppUser(userCredential.user!);
      else {
        userCredential.user!.sendEmailVerification();
        return "no-verified";
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  @override
  Future<String> registerWithMail(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.sendEmailVerification();
      return "no-verified";
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  @override
  Future signOut() async {
    await _firebaseAuth.signOut();
    final _googleSignIn = GoogleSignIn();
    _googleSignIn.signOut();
  }

  @override
  Future sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  AppUser _firebaseUserToAppUser(User firebaseUser) {
    return AppUser.toFirebaseUser(userID: firebaseUser.uid, email: firebaseUser.email);
  }

  AppUser _firebaseGoogleUserToAppUser(User firebaseGoogleUser) {
    return AppUser.toFirebaseGoogleUser(
      userID: firebaseGoogleUser.uid,
      email: firebaseGoogleUser.email,
      nameAndSurName: firebaseGoogleUser.displayName,
      profileUrl: firebaseGoogleUser.photoURL,
    );
  }
}
