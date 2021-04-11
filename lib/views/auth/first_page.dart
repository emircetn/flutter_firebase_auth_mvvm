import 'package:auth_firebase/common/auth_button.dart';
import 'package:auth_firebase/config/constants/asset_constants.dart';
import 'package:auth_firebase/config/constants/router_constants.dart';
import 'package:auth_firebase/modelviews/user_model_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: firstPart()),
            Expanded(child: secondPart()),
          ],
        ),
      ),
    );
  }

  firstPart() => Column(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(AssetContants.instance.imagePath + "hello".toPNG),
            ),
          ),
          Expanded(
              flex: 1,
              child: Text(
                "Merhaba. Devam Etmek İçin Giriş Yapın",
                style: Theme.of(context).textTheme.overline,
              ))
        ],
      );

  secondPart() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthButton(
            buttonIcon: Image.asset(
              AssetContants.instance.imagePath + "google_logo".toPNG,
              color: Colors.white,
            ),
            buttonText: "Google ile Giriş",
            buttonOnPressed: () => loginOrRegisterWithGoogle(),
            buttonColor: Colors.purple[400],
          ),
          AuthButton(
            buttonIcon: Icon(
              Icons.mail,
              color: Colors.white,
            ),
            buttonText: "Email ile Kayıt",
            buttonColor: Colors.orange[400],
            buttonOnPressed: () => Navigator.pushNamed(context, RouteConstant.REGISTER_PAGE_ROUTE),
          ),
          TextButton(
              onPressed: () => Navigator.pushNamed(context, RouteConstant.LOGIN_PAGE_ROUTE),
              child: RichText(
                  text: TextSpan(text: "Zaten Hesabınız Var Mı?", style: Theme.of(context).textTheme.overline, children: <TextSpan>[
                TextSpan(
                    text: " Giriş Yapın",
                    style: Theme.of(context).textTheme.overline!.copyWith(
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        )),
              ]))),
        ],
      );

  Future loginOrRegisterWithGoogle() async {
    await Provider.of<UserModelView>(context, listen: false).loginOrRegisterWithGoogle();
  }
}
