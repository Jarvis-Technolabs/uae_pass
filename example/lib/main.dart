import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ft_uaepass/uae_pass.dart';
import 'package:uaepass_example/home_screen/home_screen.dart';

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
          home: const MyHomeScreen(
            title: 'UAE Pass',
          ),
        ),
      );
}
