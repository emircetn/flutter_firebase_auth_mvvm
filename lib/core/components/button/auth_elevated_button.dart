import '../../extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonOnPressed;
  final Color? buttonColor;
  final Color buttonTextColor;
  final Widget? buttonIcon;
  final bool isLoading;

  const AuthElevatedButton(
      {required this.buttonText,
      required this.buttonOnPressed,
      this.buttonTextColor = Colors.white,
      this.buttonColor,
      this.buttonIcon,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: Container(
        height: 45.h,
        width: double.maxFinite,
        child: ElevatedButton(
          onPressed: buttonOnPressed,
          style: ButtonStyle(
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: context.borderRadiusLow)),
              backgroundColor: MaterialStateProperty.all(buttonColor ?? context.theme.accentColor)),
          child: isLoading ? loading(context) : buttonBody(context),
        ),
      ),
    );
  }

  Row buttonBody(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buttonIcon ?? Container(),
        Text(buttonText,
            style: context.textTheme.bodyText1!.copyWith(
              color: buttonTextColor,
            )),
        Container()
      ],
    );
  }

  Container loading(BuildContext context) {
    return Container(
      height: 25.h,
      width: 25.h,
      child: Padding(
        padding: context.paddingLow,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
