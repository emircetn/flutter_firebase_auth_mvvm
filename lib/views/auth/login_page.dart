import 'package:auth_firebase/common/auth_button.dart';
import 'package:auth_firebase/config/constants/error_constans.dart';
import 'package:auth_firebase/modelviews/user_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _email, _password;
  GlobalKey<FormState>? _formKey;
  GlobalKey<ScaffoldState>? _scaffoldKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: Text("Giriş Yapın"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: ScreenUtil().screenWidth,
        child: formField(),
      ),
    );
  }

  formField() => Consumer<UserModelView>(builder: (context, userModelView, widget) {
        return SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Emailinizi Girin",
                          suffixIcon: Icon(
                            Icons.mail,
                            color: Theme.of(context).accentColor,
                          ),
                          border: OutlineInputBorder()),
                      onSaved: (email) {
                        _email = email;
                      },
                      validator: (email) => userModelView.emailCheck(email!),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Parolanızı Girin",
                          suffixIcon: Icon(
                            Icons.security_rounded,
                            color: Theme.of(context).accentColor,
                          ),
                          border: OutlineInputBorder()),
                      onSaved: (password) {
                        _password = password;
                      },
                      validator: (password) => userModelView.passwordCheck(password!),
                    ),
                  ),
                  userModelView.stateGet == UserViewState.IDLE
                      ? AuthButton(
                          buttonIcon: Container(),
                          buttonText: "Giriş Yap",
                          buttonColor: Theme.of(context).accentColor,
                          buttonOnPressed: () async => await loginWithMail(),
                        )
                      : CircularProgressIndicator(),
                  TextButton(
                    child: Text("Şifremi Unuttum"),
                    onPressed: () async => await showModalSheetForResetPassword(),
                  )
                ],
              )),
        );
      });

  Future loginWithMail() async {
    if (_formKey!.currentState!.validate()) {
      _formKey!.currentState!.save();
      String result = await Provider.of<UserModelView>(context, listen: false).loginWithMail(_email!, _password!);
      if (result == "no-verified") {
        showToast("Size hesabınızı doğrulamanız için mail gönderdik, hesabızı doğruladıktan sonra giriş yapabilirsiniz");
      } else if (result == "success") {
        Navigator.pop(context);
      } else {
        showSnackBar(ErrorConstants.showError(result));
      }
    }
  }

  void showSnackBar(String result) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          result,
        ),
        action: result == "wrong-password"
            ? SnackBarAction(
                label: "Parolanızı Mı Unuttunuz?",
                onPressed: () {
                  //fireabse kodu yaz toast göster
                },
              )
            : null));
  }

  Future showModalSheetForResetPassword() async {
    var forgetPassFormKey = GlobalKey<FormState>();
    var resetMailController = TextEditingController();
    showModalBottomSheet(
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
              child: Container(
                  color: Theme.of(context).canvasColor,
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email adresinizi giriniz",
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(15),
                          ),
                          Form(
                            key: forgetPassFormKey,
                            child: TextFormField(
                              validator: (c) {
                                if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(c!)) {
                                  return null;
                                } else {
                                  return "email geçersiz";
                                }
                              },
                              autofocus: true,
                              style: TextStyle(
                                  /*   fontSize: ScreenUtil().setSp(16), */
                                  ),
                              controller: resetMailController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                filled: true,
                                isDense: true,
                                icon: Icon(
                                  Icons.mail,
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "İptal",
                                  style: TextStyle(
                                    color: Theme.of(context).cardColor,
                                    /*  fontSize: ScreenUtil().setSp(12), */
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (forgetPassFormKey.currentState!.validate()) {
                                    await sendPasswordResetEmail(resetMailController.text);
                                  }
                                },
                                child: Text(
                                  "Gönder",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ))));
        },
        context: context);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final _userModel = Provider.of<UserModelView>(context, listen: false);
    bool result = await _userModel.sendPasswordResetEmail(email);
    Navigator.of(context).pop();
    if (result)
      showToast("Email gönderildi");
    else
      showToast("Email gönderilemedi");
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      msg: msg,
    );
  }
}
