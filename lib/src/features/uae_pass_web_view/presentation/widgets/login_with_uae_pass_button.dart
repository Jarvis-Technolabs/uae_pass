import 'package:flutter/material.dart';
import 'package:uae_pass/src/core/const/app_constants.dart';
import 'package:uae_pass/src/core/const/image_constants.dart';
import 'package:uae_pass/src/core/const/string_constants.dart';
import 'package:uae_pass/src/core/enum/button_shape.dart';
import 'package:uae_pass/src/core/extention/image_extension.dart';
import 'package:uae_pass/src/core/localizations/uae_pass_app_localizations.dart';

class LoginWithUaePassButton extends StatelessWidget {
  final VoidCallback onPressed;
  final EdgeInsetsDirectional? padding;
  final double? customBorderRadius;
  final ButtonShape? buttonShape;
  final bool isDarkMode;
  final bool isButtonMaxWidth;
  final bool isBorder;
  final bool isDisable;

  LoginWithUaePassButton({
    super.key,
    required this.onPressed,
    this.padding,
    this.customBorderRadius,
    this.buttonShape = ButtonShape.defaultCornerRadius,
    this.isDarkMode = false,
    this.isButtonMaxWidth = false,
    this.isBorder = true,
    this.isDisable = false,
  });

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: isDisable ? 0.3 : 1,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0.0,
            shadowColor: Colors.transparent,
            shape: getButtonShape(),
            padding: padding ??
                EdgeInsetsDirectional.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
            foregroundColor: Colors.white,
            backgroundColor: isDisable
                ? Colors.white
                : isDarkMode
                    ? Colors.black
                    : Colors.white,
            splashFactory: InkRipple.splashFactory,
            side: BorderSide(
              color: isBorder ? Colors.black : Colors.transparent,
            ),
          ),
          onPressed: isDisable ? null : onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize:
                isButtonMaxWidth ? MainAxisSize.max : MainAxisSize.min,
            children: [
              (isDisable
                      ? DISABLED_UAE_PASS_ICON
                      : isDarkMode
                          ? DARK_UAE_PASS_ICON
                          : LIGHT_UAE_PASS_ICON)
                  .getImage(),
              SizedBox(
                width: 8.0,
              ),
              Text(
                UaePassAppLocalizations.of(context)
                    .translate(LABEL_LOGIN_WITH_UAE_PASS),
                style: TextStyle(
                  color: isDarkMode && isDisable
                      ? Colors.black
                      : isDarkMode
                          ? Colors.white
                          : Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: FONT_FAMILY_GE_FLOW,
                ),
              ),
            ],
          ),
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
