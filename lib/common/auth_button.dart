import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonOnPressed;
  final Color buttonColor;
  final Color buttonTextColor;
  final Widget buttonIcon;

  const AuthButton(
      {@required this.buttonText,
      @required this.buttonOnPressed,
      this.buttonTextColor = Colors.white,
      this.buttonColor = Colors.red,
      @required this.buttonIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Container(
        height: 40.h,
        width: ScreenUtil().screenWidth,
        child: RaisedButton(
          onPressed: buttonOnPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.h),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonIcon,
              Text(buttonText,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: buttonTextColor,
                      )),
              Container()
            ],
          ),
          color: buttonColor,
        ),
      ),
    );
  }
}
