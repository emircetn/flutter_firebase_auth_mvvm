import 'dart:io';

import 'package:auth_firebase/services/abstract/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStrogeService extends StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  @override
  Future uploadProfilePhotoToDatabase(String userID, File photoFile) {
    // TODO: implement uploadProfilePhotoToDatabase
    throw UnimplementedError();
  }
}
