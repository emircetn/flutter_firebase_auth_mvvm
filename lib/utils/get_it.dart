import 'package:auth_firebase/repository/user_repository.dart';
import 'package:auth_firebase/services/firebase_auth_service.dart';
import 'package:auth_firebase/services/firebase_firestore_service.dart';
import 'package:auth_firebase/services/firebase_stroge_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.asNewInstance();

getItSetup() {
  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton(() => FirebaseFirestoreService());
  getIt.registerLazySingleton(() => FirebaseStrogeService());

  getIt.registerLazySingleton(() => UserRepository());
}
