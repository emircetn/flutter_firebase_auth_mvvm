import 'package:auth_firebase/config/constants/router_constants.dart';
import 'package:auth_firebase/modelviews/user_model_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "HOŞGELDİNİZ",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              userField(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget userField() {
    final userModelView = Provider.of<UserModelView>(context, listen: false);
    return Column(
      children: [
        CircleAvatar(
          radius: 50.h,
          backgroundImage: NetworkImage(userModelView.appUser!.profileUrl!),
        ),
        Text(userModelView.appUser!.nameAndSurName!),
        Text("@" + userModelView.appUser!.userName!),
        userModelView.stateGet == UserViewState.IDLE
            ? TextButton(
                onPressed: () async {
                  await userModelView.signOut();
                  Navigator.pushNamedAndRemoveUntil(context, RouteConstant.LANDING_PAGE_ROUTE, (route) => false);
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)),
                child: Text(
                  "Çıkış Yap",
                  style: Theme.of(context).textTheme.overline,
                ),
              )
            : CircularProgressIndicator(),
      ],
    );
  }
}
