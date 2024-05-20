// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_custom_utility/flutter_custom_utility.dart';
// import 'package:uae_pass/src/core/const/app_constants.dart';
// import 'package:uae_pass/src/core/util/common_utilities.dart';
//
// import '../../../../core/localizations/app_localizations.dart';
//
// class UAEPassMessageText extends StatelessWidget {
//   final bool isSOP1Unverified;
//
//   // isSOP1Unverified -> true(default) for SOP 1/Unverified user restriction.
//   // false for SOP 2 Digital Signature restriction.
//
//   const UAEPassMessageText({
//     super.key,
//     this.isSOP1Unverified = true,
//   });
//
//   @override
//   Widget build(BuildContext context) => const Placeholder();
//   @override
//   Widget build(BuildContext context) => RichText(
//         textAlign: TextAlign.center,
//         text: TextSpan(
//           style: getUAEPassMessageTextStyle(screenUtil!, appColors),
//           children: <TextSpan>[
//             TextSpan(
//                 text: AppLocalizations.of(context)!.translate((isSOP1Unverified)
//                     ? LABEL_YOUR_ACCOUNT_UNVERIFIED
//                     : LABEL_YOUR_ACCOUNT_NOT_QUALITY_SIGNATURE)),
//             TextSpan(
//                 text: AppLocalizations.of(context).translate(LABEL_KIOSK),
//                 style: getUAEPassMessageLinkTextStyle(screenUtil!, appColors),
//                 recognizer: TapGestureRecognizer()
//                   ..onTap = () async {
//                     await Utilities.launchURL(UAE_PASS_KIOSK_LOCATIONS);
//                   }),
//             TextSpan(
//                 text: AppLocalizations.of(context)!
//                     .translate(LABEL_FOR_MORE_INFORMATION)),
//             TextSpan(
//                 text: UAE_PASS_SP_NAME,
//                 style: getUAEPassMessageLinkTextStyle(screenUtil!, appColors),
//                 recognizer: TapGestureRecognizer()
//                   ..onTap = () async {
//                     await CommonUtilities().launchURL(UAE_PASS_SP);
//                   }),
//           ],
//         ),
//       );
// }
