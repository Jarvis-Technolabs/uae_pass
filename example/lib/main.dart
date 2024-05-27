import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uae_pass/uae_pass.dart';

void main() => runApp(const MyApp());

StreamController<String> languageController = StreamController.broadcast();

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) => StreamBuilder<String>(
        initialData: 'en',
        stream: languageController.stream,
        builder: (context, snapshot) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          locale: Locale(snapshot.data!),
          supportedLocales: [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: [
            UaePassAppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
            ),
            useMaterial3: true,
          ),
          home: const MyHomePage(
            title: 'UAE Pass',
          ),
        ),
      );
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    super.key,
    required this.title,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                      onPressed: () async {
                        UAEPassWebViewResultModel? uaePassWebViewResultModel =
                            await uaeSignIn(context: context);
                        print(
                            "UaePassWebViewResultModel: ${uaePassWebViewResultModel.toString()}");
                      },
                    ),
                  ),
                  buttonBox(
                    context: context,
                    text: "Login button with Default corner radius",
                    button: LoginWithUaePassButton(
                      isDarkMode: isDarkMode,
                      isDisable: isDisable,
                      isBorder: isBorder,
                      onPressed: () async {
                        UAEPassWebViewResultModel? uaePassWebViewResultModel =
                            await uaeSignIn(context: context);
                        print(
                            "UaePassWebViewResultModel: ${uaePassWebViewResultModel.toString()}");
                      },
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
                      onPressed: () async {
                        UAEPassWebViewResultModel? uaePassWebViewResultModel =
                            await uaeSignIn(context: context);
                        print(
                            "UaePassWebViewResultModel: ${uaePassWebViewResultModel.toString()}");
                      },
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
                      onPressed: () async {
                        UAEPassWebViewResultModel? uaePassWebViewResultModel =
                            await uaeSignIn(context: context);
                        print(
                            "UaePassWebViewResultModel: ${uaePassWebViewResultModel.toString()}");
                      },
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
                        onPressed: () async {
                          UAEPassWebViewResultModel? uaePassWebViewResultModel =
                              await uaeSignIn(context: context);
                        },
                      ),
                      LogoButton(
                        isDarkMode: isDarkMode,
                        isDisable: isDisable,
                        isBorder: isBorder,
                        onPressed: () async {
                          UAEPassWebViewResultModel? uaePassWebViewResultModel =
                              await uaeSignIn(context: context);
                        },
                      ),
                      LogoButton(
                        isDarkMode: isDarkMode,
                        isDisable: isDisable,
                        isBorder: isBorder,
                        buttonShape: ButtonShape.maxCornerRadius,
                        onPressed: () async {
                          UAEPassWebViewResultModel? uaePassWebViewResultModel =
                              await uaeSignIn(context: context);
                        },
                      ),
                      LogoButton(
                        isDarkMode: isDarkMode,
                        isDisable: isDisable,
                        isBorder: isBorder,
                        customBorderRadius: 10,
                        buttonShape: ButtonShape.customRadius,
                        onPressed: () async {
                          UAEPassWebViewResultModel? uaePassWebViewResultModel =
                              await uaeSignIn(context: context);
                        },
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
                      onPressed: () async {
                        UAEPassWebViewResultModel? uaePassWebViewResultModel =
                            await uaeSignIn(context: context);
                        print(
                            "UaePassWebViewResultModel: ${uaePassWebViewResultModel.toString()}");
                      },
                    ),
                  ),
                  buttonBox(
                    context: context,
                    text: "Sign in button with Default corner radius",
                    button: SignInWithUaePassButton(
                      isDarkMode: isDarkMode,
                      isDisable: isDisable,
                      isBorder: isBorder,
                      onPressed: () async {
                        UAEPassWebViewResultModel? uaePassWebViewResultModel =
                            await uaeSignIn(context: context);
                        print(
                            "UaePassWebViewResultModel: ${uaePassWebViewResultModel.toString()}");
                      },
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
                      onPressed: () async {
                        UAEPassWebViewResultModel? uaePassWebViewResultModel =
                            await uaeSignIn(context: context);
                        print(
                            "UaePassWebViewResultModel: ${uaePassWebViewResultModel.toString()}");
                      },
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
                        UAEPassWebViewResultModel? uaePassWebViewResultModel =
                            await uaeSignIn(context: context);
                        print(
                            "UaePassWebViewResultModel: ${uaePassWebViewResultModel.toString()}");
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

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

  Future<UAEPassWebViewResultModel?> uaeSignIn({
    required BuildContext context,
  }) async =>
      await UaePass(
        context: context,
        redirectUrl: 'https://com.example',
        state: 'y3m9etA74PQ2yqI73TdVRo6M',
        isProduction: false,
      ).signIn();
}
