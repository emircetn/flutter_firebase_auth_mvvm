import '../../../core/base/modelview/base_view_model.dart';

class UserViewModel extends BaseViewModel {
  @override
  void init() {}

  UserViewModel() {
    currentUser();
  }

  Future currentUser() async {
    try {
      isLoading = true;
      await appRepository.currentUser();
    } finally {
      isLoading = false;
    }
  }
}
