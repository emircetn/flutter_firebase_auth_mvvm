import '../../../core/base/modelview/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeViewModel extends BaseViewModel {
  @override
  void init() {}

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  Future<void> signOut() async {
    await appRepository.signOut();
  }
}
