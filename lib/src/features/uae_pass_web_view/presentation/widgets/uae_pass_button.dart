import 'package:flutter/material.dart';
import 'package:uae_pass/src/core/const/app_constants.dart';
import 'package:uae_pass/src/core/const/image_constants.dart';
import 'package:uae_pass/src/core/extention/image_extension.dart';

class UaePassButton extends StatelessWidget {
  final VoidCallback? onPressed;

  UaePassButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(
          //     30.0,
          //   ),
          // ),
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 50.0,
            vertical: 10.0,
          ),
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
}
