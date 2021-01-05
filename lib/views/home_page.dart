import 'package:auth_firebase/config/constants/router_constants.dart';
import 'package:auth_firebase/modelviews/user_model_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "HOŞGELDİNİZ",
                style: Theme.of(context).textTheme.headline4,
              ),
              Consumer<UserModelView>(
                builder: (context, userModelView, widget) {
                  return userModelView.stateGet == UserViewState.IDLE
                      ? RaisedButton(
                          onPressed: () async {
                            await userModelView.signOut();
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                RouteConstant.LANDING_PAGE_ROUTE,
                                (route) => false);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            "Çıkış Yap",
                            style: Theme.of(context).textTheme.overline,
                          ),
                        )
                      : CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
