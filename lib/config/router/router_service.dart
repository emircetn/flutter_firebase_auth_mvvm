import 'package:auth_firebase/config/constants/router_constants.dart';
import 'package:auth_firebase/views/auth/complete_profile_information_page.dart';
import 'package:auth_firebase/views/auth/first_page.dart';
import 'package:auth_firebase/views/auth/login_page.dart';
import 'package:auth_firebase/views/auth/register_page.dart';
import 'package:auth_firebase/views/home_page.dart';
import 'package:auth_firebase/views/landing_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouterService {
  static Route<CupertinoPageRoute> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments; //argumanlar
    switch (settings.name) {
      case RouteConstant.LANDING_PAGE_ROUTE:
        return CupertinoPageRoute(builder: (_) => LandingPage());
      case RouteConstant.FIRST_PAGE_ROUTE:
        return CupertinoPageRoute(builder: (_) => FirstPage());
      case RouteConstant.LOGIN_PAGE_ROUTE:
        return CupertinoPageRoute(builder: (_) => LoginPage());
      case RouteConstant.REGISTER_PAGE_ROUTE:
        return CupertinoPageRoute(builder: (_) => RegisterPage());
      case RouteConstant.HOME_PAGE_ROUTE:
        return CupertinoPageRoute(builder: (_) => HomePage());
      case RouteConstant.COMPLETE_PROFILE_INFORMATION_PAGE:
        return CupertinoPageRoute(builder: (_) => CompleteProfileInformationPage());
      default:
        return CupertinoPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: Text('Hata'),
              centerTitle: true,
            ),
            body: Center(
              child: Text('Ters giden bir şeyler oldu'),
            ),
          ),
        );
    }
  }
}
