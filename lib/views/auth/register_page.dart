import 'package:auth_firebase/common/auth_button.dart';
import 'package:auth_firebase/config/constants/error_constans.dart';
import 'package:auth_firebase/config/constants/router_constants.dart';
import 'package:auth_firebase/modelviews/user_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String _email, _password;
  GlobalKey<FormState> _formKey;
  GlobalKey<ScaffoldState> _scaffoldKey;

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
        title: Text(
          "Kayıt Ol",
          style: Theme.of(context).textTheme.subtitle1,
        ),
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

  formField() => Consumer<UserModelView>(
        builder: (context, userModelView, widget) {
          return Form(
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
                        labelText: "Email Adresinizi Girin",
                        suffixIcon: Icon(
                          Icons.mail,
                          color: Theme.of(context).accentColor,
                        ),
                        border: OutlineInputBorder()),
                    onSaved: (email) {
                      _email = email;
                    },
                    validator: (email) => userModelView.emailCheck(email),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
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
                    validator: (password) =>
                        userModelView.passwordCheck(password),
                  ),
                ),
                userModelView.stateGet == UserViewState.IDLE
                    ? AuthButton(
                        buttonIcon: Container(),
                        buttonText: "Kayıt Ol",
                        buttonColor: Theme.of(context).accentColor,
                        buttonOnPressed: () async => await registerWithMail(),
                      )
                    : CircularProgressIndicator(),
              ],
            ),
          );
        },
      );

  Future registerWithMail() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      String result = await Provider.of<UserModelView>(context, listen: false)
          .registerWithMail(_email, _password);
      if (result == "no-verified") {
        Fluttertoast.showToast(
            gravity: ToastGravity.CENTER,
            toastLength: Toast.LENGTH_LONG,
            msg:
                "Size hesabınızı doğrulamanız için mail gönderdik, lütfen hesabızı doğruladıktan sonra giriş yapın");
        Navigator.pushReplacementNamed(context, RouteConstant.LOGIN_PAGE_ROUTE);
      } else {
        showSnackBar(ErrorConstants.showError(result));
      }
    }
  }

  void showSnackBar(String result) async {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
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
}
