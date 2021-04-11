import 'package:auth_firebase/config/router/router_service.dart';
import 'package:auth_firebase/config/theme/theme_constants.dart';
import 'package:auth_firebase/modelviews/user_model_view.dart';
import 'package:auth_firebase/utils/get_it.dart';
import 'package:auth_firebase/views/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getItSetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserModelView>(
      create: (_) => UserModelView(),
      child: ScreenUtilInit(builder: () {
        return MaterialApp(
          title: "Firebase Auth",
          onGenerateRoute: RouterService.generateRoute,
          theme: ThemeConstants.lightTheme,
          debugShowCheckedModeBanner: false,
          home: LandingPage(),
        );
      }),
    );
  }
}
