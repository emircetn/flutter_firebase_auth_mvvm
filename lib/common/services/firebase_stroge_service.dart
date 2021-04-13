import 'dart:io';

import 'abstract/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStrogeService extends StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  @override
  Future<String?> uploadProfilePhotoToDatabase(String userID, File photoFile) async {
    try {
      var _storageReference = _firebaseStorage.ref().child('profilePhotos').child(userID).child('profilePhoto.png');
      await _storageReference.putFile(photoFile);
      var url = await _storageReference.getDownloadURL();
      return url;
    } catch (e) {
      return null;
    }
  }
}
