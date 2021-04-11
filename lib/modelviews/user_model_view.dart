import 'dart:io';

import 'package:auth_firebase/models/app_user.dart';
import 'package:auth_firebase/repository/user_repository.dart';
import 'package:auth_firebase/utils/get_it.dart';
import 'package:flutter/cupertino.dart';

enum UserViewState { IDLE, BUSY }

class UserModelView extends ChangeNotifier {
  final UserRepository? _userRepository = getIt<UserRepository>();

  UserViewState _state = UserViewState.IDLE;
  AppUser? appUser;
  String? userNameValidator;

  UserViewState get stateGet => _state;
  set stateSet(UserViewState state) {
    _state = state;
    notifyListeners();
  }

  UserModelView() {
    currentUser();
  }

  Future currentUser() async {
    stateSet = UserViewState.BUSY;
    appUser = await _userRepository!.currentUser();
    stateSet = UserViewState.IDLE;
  }

  ///////////////////////////////register-login-signout/////////////////////////////////

  Future<String> registerWithMail(String email, String password) async {
    stateSet = UserViewState.BUSY;
    var result = await _userRepository!.registerWithMail(email, password);
    stateSet = UserViewState.IDLE;
    return result;
  }

  Future<String> loginWithMail(String email, String password) async {
    stateSet = UserViewState.BUSY;
    var result = await _userRepository!.loginWithMail(email, password);
    stateSet = UserViewState.IDLE;
    if (result is AppUser) {
      appUser = result;
      return 'success';
    }

    return result;
  }

  Future signOut() async {
    await _userRepository!.signOut();
    appUser = null;
  }

  Future loginOrRegisterWithGoogle() async {
    stateSet = UserViewState.BUSY;
    appUser = await _userRepository!.loginOrRegisterWithGoogle();
    stateSet = UserViewState.IDLE;
  }

  ///////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////control-functions////////////////////////////////////

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

  String? nameAndSurnameCheck(String nameAndSurname) {
    if (nameAndSurname.isEmpty) {
      return 'En az 2 karakter olabilir';
    } else if (!RegExp(r'^(?=[a-zA-ZğüşiöçĞÜŞİÖÇ ]{3,10}$)').hasMatch(nameAndSurname)) {
      return 'İsim soyisim  özel karakterler içermemeli';
    } else if (!nameAndSurname.contains(' ')) {
      return 'İsim ve Soyisminizi boşluk ile ayırın';
    } else if (nameAndSurname.split(' ')[0].length < 2) {
      return 'İsminiz en az 2 harf olabilir';
    } else if (nameAndSurname.split(' ')[1].length < 2) {
      return 'Soyisminiz en az 2 harf olabilir';
    } else {
      return null;
    }
  }

  Future userNameCheck(String? userName) async {
    if (!(await _userRepository!.userNameCheckFromDatabase(userName))) {
      userName = 'kullanıcı adı daha önce alınmış';
    }
    if (userName!.length < 3) {
      userNameValidator = 'kullanıcı adı en az 3 karakter olabilir';
    } else if (userName.length > 10) {
      userNameValidator = 'kullanıcı adı en fazla 10 karakter olabilir';
    } else if (!RegExp(r'^(?=[a-zA-Z0-9._]{3,10}$)').hasMatch(userName)) {
      userNameValidator = 'kullanıcı adı özel karakterler, boşluk içermemeli';
    } else {
      userNameValidator = null;
    }
  }

  /////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////other///////////////////////////////////////////////

  Future<bool> saveUserToDatabase(AppUser user) async {
    stateSet = UserViewState.BUSY;
    var result = await _userRepository!.saveUserToDatabase(user);
    if (result == true) appUser = user;
    stateSet = UserViewState.IDLE;
    return result;
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    return await (_userRepository!.sendPasswordResetEmail(email));
  }

  Future<String?> uploadProfilePhotoToDatabase(File profilePicture) async {
    return await _userRepository!.uploadProfilePhotoToDatabase(appUser!.userID!, profilePicture);
  }

  /////////////////////////////////////////////////////////////////////////////////////

}
