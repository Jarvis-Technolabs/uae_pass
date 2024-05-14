import 'package:flutter/material.dart';

class UAEPassMessageText extends StatelessWidget {
  final bool isSOP1Unverified;

  // isSOP1Unverified -> true(default) for SOP 1/Unverified user restriction.
  // false for SOP 2 Digital Signature restriction.

  const UAEPassMessageText({
    super.key,
    this.isSOP1Unverified = true,
  });

  @override
  Widget build(BuildContext context) => const Placeholder();
  // @override
  // Widget build(BuildContext context) => RichText(
  //   textAlign: TextAlign.center,
  //   text: TextSpan(
  //     style: getUAEPassMessageTextStyle(screenUtil!, appColors),
  //     children: <TextSpan>[
  //       TextSpan(
  //           text: AppLocalizations.of(context)!.translate(
  //               (isSOP1Unverified)
  //                   ? LABEL_YOUR_ACCOUNT_UNVERIFIED
  //                   : LABEL_YOUR_ACCOUNT_NOT_QUALITY_SIGNATURE)),
  //       TextSpan(
  //           text: AppLocalizations.of(context).translate(LABEL_KIOSK),
  //           style: getUAEPassMessageLinkTextStyle(screenUtil!, appColors),
  //           recognizer: TapGestureRecognizer()
  //             ..onTap = () async {
  //               await firebaseAnalyticsEventCall(
  //                 FirebaseAnalyticsEventsEnum.UAE_PASS_SOP1_REDIRECTION,
  //                 param: {KEY_SOP1_REDIRECTION: VALUE_WEBSITE},
  //               );
  //               await Utilities.launchURL(UAE_PASS_KIOSK_LOCATIONS);
  //             }),
  //       TextSpan(
  //           text: AppLocalizations.of(context)!
  //               .translate(LABEL_FOR_MORE_INFORMATION)),
  //       TextSpan(
  //           text: UAE_PASS_SP_NAME,
  //           style: getUAEPassMessageLinkTextStyle(screenUtil!, appColors),
  //           recognizer: TapGestureRecognizer()
  //             ..onTap = () async {
  //               await firebaseAnalyticsEventCall(
  //                 FirebaseAnalyticsEventsEnum.UAE_PASS_SOP1_REDIRECTION,
  //                 param: {KEY_SOP1_REDIRECTION: VALUE_MOBILE},
  //               );
  //               await Utilities.launchURL(UAE_PASS_SP);
  //             }),
  //     ],
  //   ),
  // );
}
