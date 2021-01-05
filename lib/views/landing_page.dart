import 'package:auth_firebase/modelviews/user_model_view.dart';
import 'package:auth_firebase/views/auth/complete_profile_information_page.dart';
import 'package:auth_firebase/views/auth/first_page.dart';
import 'package:auth_firebase/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  UserModelView userModelView;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userModelView = Provider.of<UserModelView>(context, listen: true);
    if (userModelView.stateGet == UserViewState.BUSY) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (userModelView.appUser == null)
        return FirstPage();
      else if (userModelView.appUser.userName != null) {
        return HomePage();
      } else
        return CompleteProfileInformationPage();
    }
  }
}
