import '../../ui/authenticate/first/view/first_page.dart';
import '../../ui/authenticate/login/view/login_page.dart';
import '../../ui/authenticate/register/view/register_page.dart';
import '../../ui/landing/view/landing_page.dart';
import '../constants/router_constants.dart';
import '../../ui/home/view/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationRoute {
  static NavigationRoute? _instace;
  static NavigationRoute get instance {
    _instace ??= NavigationRoute._init();
    return _instace!;
  }

  NavigationRoute._init();

  Route<CupertinoPageRoute> generateRoute(RouteSettings settings) {
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
      /*  case RouteConstant.COMPLETE_PROFILE_INFORMATION_PAGE:
        return CupertinoPageRoute(builder: (_) => CompleteProfileInformationPage()); */
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
