abstract class AuthService {
  void getCurrentUser();
  Future loginWithMail(String email, String password);
  Future loginOrRegisterWithGoogle();
  Future registerWithMail(String email, String password);
  Future sendPasswordResetEmail(String email);
  Future signOut();
}
