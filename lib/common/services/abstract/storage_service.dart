import 'dart:io';

abstract class StorageService {
  Future uploadProfilePhotoToDatabase(String userID, File photoFile);
}
