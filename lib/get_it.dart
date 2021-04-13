import 'repository/app_repository.dart';
import 'common/services/firebase_auth_service.dart';
import 'common/services/firebase_firestore_service.dart';
import 'common/services/firebase_stroge_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.asNewInstance();

void getItSetup() async {
  getIt.registerLazySingleton(() => FirebaseAuthService());
  getIt.registerLazySingleton(() => FirebaseFirestoreService());
  getIt.registerLazySingleton(() => FirebaseStrogeService());

  getIt.registerLazySingleton(() => AppRepository());
}
