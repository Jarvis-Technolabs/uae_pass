import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ft_uaepass/uae_pass.dart';
import 'package:uaepass_example/error_screen/error_screen.dart';
import 'package:uaepass_example/main.dart';
import 'package:uaepass_example/success_screen/success_screen.dart';

class MyHomeScreen extends StatefulWidget {
  final String title;

  const MyHomeScreen({
    super.key,
    required this.title,
  });

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  bool isDarkMode = false;
  bool isEnglish = true;
  bool isDisable = false;
  bool isBorder = true;

  StreamController<bool> screenRefreshController = StreamController.broadcast();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color(0xffE7E7E7),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 20.0,
            ),
            child: StreamBuilder<bool>(
              initialData: isDarkMode,
              stream: screenRefreshController.stream,
              builder: (context, snapshot) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Dark mode"),
                      Switch.adaptive(
                        value: isDarkMode,
                        onChanged: (bool value) {
                          isDarkMode = value;
                          screenRefreshController.add(isDarkMode);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Language"),
                      Switch.adaptive(
                        value: isEnglish,
                        onChanged: (bool value) {
                          isEnglish = value;
                          languageController.add(isEnglish ? 'en' : 'ar');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Disable button"),
                      Switch.adaptive(
                        value: isDisable,
                        onChanged: (bool value) {
                          isDisable = value;
                          screenRefreshController.add(isDisable);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("With Border"),
                      Switch.adaptive(
                        value: isBorder,
                        onChanged: (bool value) {
                          isBorder = value;
                          screenRefreshController.add(isBorder);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  buttonBox(
                    context: context,
                    text: "Login button with Minimum corner radius",
                    button: LoginWithUaePassButton(
                      isDarkMode: isDarkMode,
                      isDisable: isDisable,
                      isBorder: isBorder,
                      buttonShape: ButtonShape.minCornerRadius,
                      onPressed: () async => await callUaePass(context),
                    ),
                  ),
                  buttonBox(
                    context: context,
                    text: "Login button with Default corner radius",
                    button: LoginWithUaePassButton(
                      isDarkMode: isDarkMode,
                      isDisable: isDisable,
                      isBorder: isBorder,
                      onPressed: () async => await callUaePass(context),
                    ),
                  ),
                  buttonBox(
                    context: context,
                    text: "Login button with Maximum corner radius",
                    button: LoginWithUaePassButton(
                      isDarkMode: isDarkMode,
                      isDisable: isDisable,
                      isBorder: isBorder,
                      buttonShape: ButtonShape.maxCornerRadius,
                      onPressed: () async => await callUaePass(context),
                    ),
                  ),
                  buttonBox(
                    context: context,
                    text: "Login button with Custom corner radius",
                    button: LoginWithUaePassButton(
                      isDarkMode: isDarkMode,
                      isDisable: isDisable,
                      isBorder: isBorder,
                      customBorderRadius: 10,
                      buttonShape: ButtonShape.customRadius,
                      onPressed: () async => await callUaePass(context),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Logo buttons with different shape"),
                  SizedBox(
                    height: 12.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LogoButton(
                        isDarkMode: isDarkMode,
                        isDisable: isDisable,
                        isBorder: isBorder,
                        buttonShape: ButtonShape.minCornerRadius,
                        onPressed: () async => await callUaePass(context),
                      ),
                      LogoButton(
                        isDarkMode: isDarkMode,
                        isDisable: isDisable,
                        isBorder: isBorder,
                        onPressed: () async => await callUaePass(context),
                      ),
                      LogoButton(
                        isDarkMode: isDarkMode,
                        isDisable: isDisable,
                        isBorder: isBorder,
                        buttonShape: ButtonShape.maxCornerRadius,
                        onPressed: () async => await callUaePass(context),
                      ),
                      LogoButton(
                        isDarkMode: isDarkMode,
                        isDisable: isDisable,
                        isBorder: isBorder,
                        customBorderRadius: 10,
                        buttonShape: ButtonShape.customRadius,
                        onPressed: () async => await callUaePass(context),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32.0,
                  ),
                  buttonBox(
                    context: context,
                    text: "Sign in button with Minimum corner radius",
                    button: SignInWithUaePassButton(
                      isDarkMode: isDarkMode,
                      isDisable: isDisable,
                      isBorder: isBorder,
                      buttonShape: ButtonShape.minCornerRadius,
                      onPressed: () async => await callUaePass(context),
                    ),
                  ),
                  buttonBox(
                    context: context,
                    text: "Sign in button with Default corner radius",
                    button: SignInWithUaePassButton(
                      isDarkMode: isDarkMode,
                      isDisable: isDisable,
                      isBorder: isBorder,
                      onPressed: () async => await callUaePass(context),
                    ),
                  ),
                  buttonBox(
                    context: context,
                    text: "Sign in button with Maximum corner radius",
                    button: SignInWithUaePassButton(
                      isDarkMode: isDarkMode,
                      isDisable: isDisable,
                      isBorder: isBorder,
                      buttonShape: ButtonShape.maxCornerRadius,
                      onPressed: () async => await callUaePass(context),
                    ),
                  ),
                  buttonBox(
                    context: context,
                    text: "Sign in button with Custom corner radius",
                    button: SignInWithUaePassButton(
                      isDarkMode: isDarkMode,
                      isDisable: isDisable,
                      isBorder: isBorder,
                      customBorderRadius: 10,
                      buttonShape: ButtonShape.customRadius,
                      onPressed: () async {
                        await callUaePass(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Future<void> callUaePass(BuildContext context) async {
    UAEPassWebViewResultModel? uaePassWebViewResultModel =
        await uaeSignIn(context: context);
    if (uaePassWebViewResultModel != null &&
        uaePassWebViewResultModel.status == true) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SuccessScreen(
            message: uaePassWebViewResultModel.toString(),
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ErrorScreen(
            message: uaePassWebViewResultModel.toString(),
          ),
        ),
      );
    }
  }

  Future<UAEPassWebViewResultModel?> uaeSignIn({
    required BuildContext context,
  }) async =>
      await UaePass(
        context: context,
        redirectUrl: 'https://com.example',
        state: '',
        isProduction: false,
        isDarkMode: isDarkMode,
      ).signIn();

  Widget buttonBox({
    required BuildContext context,
    required Widget button,
    required String text,
  }) =>
      Padding(
        padding: const EdgeInsetsDirectional.only(
          bottom: 14.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text),
            SizedBox(
              height: 12.0,
            ),
            Center(child: button),
          ],
        ),
      );
}
