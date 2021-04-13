import 'package:flutter/material.dart';

class SpecialRichText extends StatelessWidget {
  final String? textOne;
  final String? textTwo;

  final TextStyle? textStyleOne;
  final TextStyle? textStyleTwo;

  const SpecialRichText({
    Key? key,
    required this.textOne,
    required this.textTwo,
    this.textStyleOne,
    this.textStyleTwo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      textAlign: TextAlign.center,
      text: TextSpan(text: textOne, style: textStyleOne, children: <TextSpan>[
        TextSpan(text: textTwo, style: textStyleTwo),
      ]),
    );
  }
}
