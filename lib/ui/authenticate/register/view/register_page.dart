import '../../../../core/components/button/auth_elevated_button.dart';
import '../../../../core/components/text_form_field/auth_text_form_field.dart';
import '../../../../core/constants/error_constans.dart';
import '../../../../core/constants/router_constants.dart';
import 'package:flutter/material.dart';
import '../modelview/register_model_view.dart';
import '../../../../core/base/view/base_view.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      viewModel: RegisterViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, RegisterViewModel viewModel) => Scaffold(
        appBar: appBar(),
        body: formField(context, viewModel),
      ),
    );
  }
}

AppBar appBar() => AppBar(
      title: Text('Kayıt Yapın'),
    );

Form formField(BuildContext context, RegisterViewModel viewModel) {
  return Form(
    key: viewModel.formKey,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AuthTextFormField(
          labelText: 'Email Adresinizi Girin',
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          onSaved: (email) => viewModel.email = email,
          validator: (email) => viewModel.emailCheck(email),
          iconData: Icons.mail,
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
          buttonText: 'Kayıt Ol',
          buttonOnPressed: () async => await registerWithMail(context, viewModel),
        )
      ],
    ),
  );
}

Future registerWithMail(BuildContext context, RegisterViewModel viewModel) async {
  if (viewModel.formKey.currentState!.validate()) {
    viewModel.formKey.currentState!.save();
    var result;
    try {
      result = await viewModel.registerWithMail();
    } catch (e) {
      viewModel.showToast(ErrorConstants.instance.getErrorText(e.toString()));
    }
    if (result) {
      await viewModel.navigationService.pushNamedAndRemoveUntil(RouteConstant.HOME_PAGE_ROUTE);
    }
  }
}
