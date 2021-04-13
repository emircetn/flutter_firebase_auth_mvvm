import '../../models/app_user.dart';

abstract class AuthService {
  AppUser? getCurrentUser();
  Future loginWithMail(String email, String password);
  Future loginOrRegisterWithGoogle();
  Future registerWithMail(String email, String password);
  Future signOut();
}
