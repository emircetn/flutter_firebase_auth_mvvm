import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/button/auth_elevated_button.dart';
import '../../../../core/components/button/auth_text_buton.dart';
import '../../../../core/components/text/special_rich_text.dart';
import '../../../../core/components/widgets/loading/page_loading.dart';
import '../../../../core/constants/error_constans.dart';
import '../modelview/first_model_view.dart';
import '../../../../core/constants/asset_constants.dart';
import '../../../../core/constants/router_constants.dart';
import '../../../../core/extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<FirstViewModel>(
        viewModel: FirstViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, FirstViewModel viewModel) => Scaffold(
            body: !(viewModel.isLoadingGet)
                ? SafeArea(
                    child: Column(
                      children: [
                        Expanded(child: header(context, viewModel)),
                        Expanded(child: buttons(context, viewModel)),
                      ],
                    ),
                  )
                : PageLoading()));
  }
}

Column header(BuildContext context, FirstViewModel viewModel) => Column(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: context.paddingNormal,
            child: Image.asset(viewModel.assetContants.imagePath + 'hello'.toPNG),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text('Merhaba. Devam Etmek İçin Giriş Yapın', style: context.textTheme.overline),
        )
      ],
    );

Column buttons(BuildContext context, FirstViewModel viewModel) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthElevatedButton(
          buttonIcon: Image.asset(viewModel.assetContants.iconPath + 'google_logo'.toPNG, color: Colors.white),
          buttonText: 'Google ile Giriş',
          buttonOnPressed: () => loginOrRegisterWithGoogle(context, viewModel),
          buttonColor: Colors.purple[400],
        ),
        AuthElevatedButton(
          buttonIcon: Icon(Icons.mail, color: Colors.white),
          buttonText: 'Email ile Kayıt',
          buttonColor: Colors.orange[400],
          buttonOnPressed: () => viewModel.navigationService.pushNamed(RouteConstant.REGISTER_PAGE_ROUTE),
        ),
        AuthTextButton(
          buttonBody: SpecialRichText(
            textOne: 'Zaten Hesabınız Var Mı?',
            textTwo: ' Giriş Yapın',
            textStyleOne: context.textTheme.overline,
            textStyleTwo: context.textTheme.overline!.copyWith(color: context.theme.accentColor, fontWeight: FontWeight.bold),
          ),
          buttonOnPressed: () async => await viewModel.navigationService.pushNamed(RouteConstant.LOGIN_PAGE_ROUTE),
        ),
      ],
    );

Future<void> loginOrRegisterWithGoogle(BuildContext context, FirstViewModel viewModel) async {
  var result;
  try {
    result = await viewModel.loginOrRegisterWithGoogle();
  } catch (e) {
    viewModel.showToast(ErrorConstants.instance.getErrorText(e.toString()));
  }

  if (result == true) {
    await viewModel.navigationService.pushNamedAndRemoveUntil(RouteConstant.HOME_PAGE_ROUTE);
  }
}
