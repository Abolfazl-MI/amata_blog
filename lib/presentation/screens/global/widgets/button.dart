import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String hintText;
  final Color buttonColor;
  final VoidCallback onTap;
  final double width;
  final TextStyle? hintTextStyle;
  const AppButton(
      {Key? key,
      required this.hintText,
      required this.buttonColor,
      required this.onTap,
      required this.width,
      this.hintTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: buttonColor),
        child: Center(
          child: Text(
            hintText,
            style:
                hintTextStyle ?? TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
