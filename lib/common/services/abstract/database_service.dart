import '../../models/app_user.dart';

abstract class DatabaseService {
  Future saveUserToDatabase(AppUser appUser);
  Future saveOrReadGoogleUserToDatabase(AppUser appUser);
  Future readUserFromDatabase(String userID);
}
