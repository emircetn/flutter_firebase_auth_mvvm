import 'dart:io';

import 'package:auth_firebase/services/abstract/storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStrogeService extends StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  @override
  Future<String?> uploadProfilePhotoToDatabase(String userID, File photoFile) async {
    Reference _storageReference = _firebaseStorage.ref().child("profilePhotos").child(userID).child("profilePhoto.png");
    UploadTask uploadTask = _storageReference.putFile(photoFile);
    var url;
    await uploadTask.then((task) => url = task.ref.getDownloadURL());
    return url;
  }
}
