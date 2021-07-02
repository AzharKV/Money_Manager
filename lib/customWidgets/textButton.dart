import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.press,
    this.textColor,
    this.textStyle,
    this.splash = true,
  }) : super(key: key);

  final String? text;
  final Color? textColor;
  final Function()? press;
  final bool? splash;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          splashFactory:
              splash! ? InkRipple.splashFactory : NoSplash.splashFactory),
      child: Text(text!, style: textStyle ?? TextStyle(color: textColor)),
      onPressed: press,
    );
  }
}
