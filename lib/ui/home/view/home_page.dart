import '../../../core/base/view/base_view.dart';
import '../../../core/components/button/auth_elevated_button.dart';
import '../modelview/home_view_model.dart';

import '../../../core/constants/router_constants.dart';
import '../../../core/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        viewModel: HomeViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, HomeViewModel viewModel) => Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textField(viewModel, context),
                  buttonField(viewModel, context),
                ],
              ),
            ));
  }

  Padding textField(HomeViewModel viewModel, BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: Column(
        children: [
          Text(
            'HOŞ GELDİNİZ',
            style: context.textTheme.headline4,
          ),
          Text(viewModel.getUser!.email!),
        ],
      ),
    );
  }

  Widget buttonField(HomeViewModel viewModel, BuildContext context) {
    return Column(
      children: [
        AuthElevatedButton(
          buttonText: 'Çıkış Yap',
          isLoading: viewModel.isLoadingGet,
          buttonOnPressed: () async {
            await viewModel.signOut();
            await viewModel.navigationService.pushNamedAndRemoveUntil(RouteConstant.LANDING_PAGE_ROUTE);
          },
        )
      ],
    );
  }
}
