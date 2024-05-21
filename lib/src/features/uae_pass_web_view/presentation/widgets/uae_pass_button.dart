import 'package:flutter/material.dart';
import 'package:uae_pass/src/core/const/app_constants.dart';
import 'package:uae_pass/src/core/const/image_constants.dart';
import 'package:uae_pass/src/core/enum/button_shape.dart';
import 'package:uae_pass/src/core/extention/image_extension.dart';

class UaePassButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsetsDirectional? padding;
  final ButtonShape? buttonShape;
  final bool isDarkMode;
  final bool isButtonMaxWidth;
  final bool isBorder;
  final double? customBorderRadius;

  UaePassButton({
    super.key,
    required this.onPressed,
    this.padding,
    this.customBorderRadius,
    this.buttonShape = ButtonShape.maxCornerRadius,
    this.isDarkMode = false,
    this.isButtonMaxWidth = false,
    this.isBorder = false,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          shape: getButtonShape(),
          padding: padding ??
              EdgeInsetsDirectional.symmetric(
                horizontal: 50.0,
                vertical: 10.0,
              ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: isButtonMaxWidth ? MainAxisSize.max : MainAxisSize.min,
          children: [
            UAE_PASS_ICON.getImage(),
            SizedBox(
              width: 8.0,
            ),
            Text(
              'Login with UAE PASS',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: FONT_FAMILY_GE_FLOW,
              ),
            ),
          ],
        ),
      );

  OutlinedBorder getButtonShape() => buttonShape == ButtonShape.minCornerRadius
      ? RoundedRectangleBorder(
          side: getBorder(),
        )
      : buttonShape == ButtonShape.defaultCornerRadius
          ? RoundedRectangleBorder(
              side: getBorder(),
              borderRadius: BorderRadius.circular(4),
            )
          : buttonShape == ButtonShape.customRadius
              ? RoundedRectangleBorder(
                  side: getBorder(),
                  borderRadius: BorderRadius.circular(customBorderRadius ?? 4),
                )
              : StadiumBorder(
                  side: getBorder(),
                );

  BorderSide getBorder() => BorderSide(
        color: isBorder ? Colors.black : Colors.white,
      );
}
