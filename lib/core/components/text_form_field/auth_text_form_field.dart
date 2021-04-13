import '../../extensions/app_extensions.dart';
import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  const AuthTextFormField({
    Key? key,
    required this.labelText,
    required this.onSaved,
    required this.validator,
    required this.iconData,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
  }) : super(key: key);

  final Function(String?) onSaved;
  final String? Function(String?) validator;
  final String labelText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final IconData iconData;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingLow,
      child: TextFormField(
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: Icon(iconData, color: context.theme.accentColor),
          border: OutlineInputBorder(),
        ),
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}
