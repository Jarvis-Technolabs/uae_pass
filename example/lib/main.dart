import 'package:flutter/material.dart';
import 'package:uae_pass/uae_pass.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          UaePassAppLocalizations.delegate,
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
  @override
  Widget build(BuildContext context) => Scaffold(
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: UaePassButton(
              customBorderRadius: 10,
              isBorder: true,
              buttonShape: ButtonShape.customRadius,
              onPressed: () async {
                UAEPassWebViewResultModel? uaePassWebViewResultModel =
                    await uaeSignIn(context: context);
              },
            ),
          ),
        ),
      );

  Future<UAEPassWebViewResultModel?> uaeSignIn({
    required BuildContext context,
  }) async =>
      await UaePass(
        context: context,
        redirectUrl: 'https://pftmapp.pension.gov.ae/uaepass.aspx',
        state: 'rV7NIs43uxZKGqc537yuVN08',
        isProduction: false,
      ).signIn();
}
