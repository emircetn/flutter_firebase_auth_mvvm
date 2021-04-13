import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/auth_elevated_button.dart';
import '../../../../core/components/text_form_field/auth_text_form_field.dart';
import '../../../../core/constants/error_constans.dart';
import '../../../../core/constants/router_constants.dart';
import '../modelview/login_view_model.dart';
import '../../../../core/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        viewModel: LoginViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, LoginViewModel viewModel) => Scaffold(
              backgroundColor: context.theme.canvasColor,
              appBar: appBar(),
              body: formField(context, viewModel),
            ));
  }
}

AppBar appBar() => AppBar(
      title: Text('Giriş Yapın'),
    );

SingleChildScrollView formField(BuildContext context, LoginViewModel viewModel) => SingleChildScrollView(
      child: Form(
          key: viewModel.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AuthTextFormField(
                labelText: 'Emailinizi Girin',
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                iconData: Icons.mail,
                onSaved: (email) => viewModel.email = email,
                validator: (email) => viewModel.emailCheck(email!),
              ),
              AuthTextFormField(
                labelText: 'Parolanızı Girin',
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.visiblePassword,
                iconData: Icons.security_rounded,
                obscureText: true,
                onSaved: (password) => viewModel.password = password,
                validator: (password) => viewModel.passwordCheck(password!),
              ),
              AuthElevatedButton(
                isLoading: viewModel.isLoadingGet,
                buttonText: 'Giriş Yap',
                buttonOnPressed: () async => await loginWithMail(context, viewModel),
              ),
            ],
          )),
    );

Future loginWithMail(BuildContext context, LoginViewModel viewModel) async {
  if (viewModel.formKey!.currentState!.validate()) {
    viewModel.formKey!.currentState!.save();
    var result;
    try {
      result = await viewModel.loginWithMail();
    } catch (e) {
      viewModel.showToast(ErrorConstants.instance.getErrorText(e.toString()));
    }
    if (result == true) {
      await viewModel.navigationService.pushNamedAndRemoveUntil(RouteConstant.HOME_PAGE_ROUTE);
    }
  }
}
