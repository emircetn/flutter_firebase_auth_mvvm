import '../../../../core/base/modelview/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterViewModel extends BaseViewModel {
  String? email, password;
  late GlobalKey<FormState> formKey;

  @override
  void init() {
    formKey = GlobalKey<FormState>();
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
  }

  String? emailCheck(String? email) {
    if (email == null || email.isEmpty) {
      return 'Lütfen email adresinizi girin';
    } else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return null;
    } else {
      return 'email geçersiz';
    }
  }

  String? passwordCheck(String? password) {
    if (password == null || password.isEmpty) {
      return 'Lütfen parola girin';
    }
    if (password.length > 5) {
      return null;
    } else {
      return 'Parola en az 6 karakter olabilir';
    }
  }

  Future<bool> registerWithMail() async {
    try {
      isLoading = true;
      return await appRepository.registerWithMail(email!, password!);
    } finally {
      isLoading = false;
    }
  }
}
