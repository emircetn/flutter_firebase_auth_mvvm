import '../../../core/base/view/base_view.dart';
import '../../authenticate/first/view/first_page.dart';
import '../../home/view/home_page.dart';
import '../viewmodel/user_view_model.dart';

import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<UserViewModel>(
        viewModel: UserViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, UserViewModel userModelView) {
          if (userModelView.isLoadingGet == true) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            if (userModelView.getUser == null) {
              return FirstPage();
            } else {
              return HomePage();
            }
          }
        });
  }
}
