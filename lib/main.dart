import 'core/router/router_service.dart';
import 'ui/landing/view/landing_page.dart';
import 'core/theme/theme_constants.dart';
import 'get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/router/router_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getItSetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Firebase Auth',
          onGenerateRoute: NavigationRoute.instance.generateRoute,
          theme: ThemeConstants.instance.lightTheme,
          home: LandingPage(),
          navigatorKey: NavigationService.instance.navigatorKey,
        );
      },
    );
  }
}
