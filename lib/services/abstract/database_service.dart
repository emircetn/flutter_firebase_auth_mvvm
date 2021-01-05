import 'package:auth_firebase/models/app_user.dart';

abstract class DatabaseService {
  Future saveUserToDatabase(AppUser appUser);
  Future saveOrReadGoogleUserToDatabase(AppUser appUser);
  Future readUserFromDatabase(String userID);
  Future userNameCheckFromDatabase(String userName);
}
