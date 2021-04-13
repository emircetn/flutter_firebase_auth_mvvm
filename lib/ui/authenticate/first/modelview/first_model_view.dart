import '../../../../core/base/modelview/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class FirstViewModel extends BaseViewModel {
  @override
  void init() {}

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  Future<bool> loginOrRegisterWithGoogle() async {
    try {
      isLoading = true;
      return await appRepository.loginOrRegisterWithGoogle();
    } finally {
      isLoading = false;
    }
  }
}
