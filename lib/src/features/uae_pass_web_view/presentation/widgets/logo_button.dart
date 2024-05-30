import 'package:flutter/material.dart';
import 'package:uae_pass/src/core/const/image_constants.dart';
import 'package:uae_pass/src/core/enum/button_shape.dart';
import 'package:uae_pass/src/core/extention/image_extension.dart';

class LogoButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final EdgeInsetsDirectional? padding;
  final double? customBorderRadius;
  final ButtonShape? buttonShape;
  final bool isDarkMode;
  final bool isBorder;
  final bool isDisable;

  LogoButton({
    super.key,
    required this.onPressed,
    this.padding,
    this.customBorderRadius,
    this.buttonShape = ButtonShape.defaultCornerRadius,
    this.isDarkMode = false,
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
                  horizontal: 12.0,
                  vertical: 12.0,
                ),
            foregroundColor: Colors.white,
            backgroundColor: isDisable
                ? Colors.white
                : isDarkMode
                    ? Colors.black
                    : Colors.white,
            splashFactory: InkRipple.splashFactory,
            minimumSize: Size(
              30.0,
              30.0,
            ),
            side: BorderSide(
              color: isBorder ? Colors.black : Colors.transparent,
            ),
          ),
          onPressed: isDisable ? null : onPressed,
          child: (isDisable
                  ? DISABLED_UAE_PASS_ICON
                  : isDarkMode
                      ? DARK_UAE_PASS_ICON
                      : LIGHT_UAE_PASS_ICON)
              .getImage(
            height: 30.0,
            width: 30.0,
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
