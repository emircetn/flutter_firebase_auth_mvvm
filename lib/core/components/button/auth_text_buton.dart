import '../../extensions/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextButton extends StatelessWidget {
  final VoidCallback buttonOnPressed;
  final Widget buttonBody;

  const AuthTextButton({required this.buttonBody, required this.buttonOnPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: buttonOnPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: context.borderRadiusLow)),
      ),
      child: buttonBody,
    );
  }

  Container loading(BuildContext context) {
    return Container(
      height: 20.h,
      width: 20.h,
      child: Padding(
        padding: context.paddingLow,
        child: CircularProgressIndicator(
          strokeWidth: 4.0,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
