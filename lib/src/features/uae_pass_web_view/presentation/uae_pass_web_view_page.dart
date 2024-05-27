import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/uae_pass_web_view_bloc.dart';
import 'screen/uae_pass_web_view_screen.dart';

class UAEPassWebViewPage extends StatefulWidget {
  final bool isDarkMode;
  const UAEPassWebViewPage({
    super.key,
    this.isDarkMode = false,
  });

  @override
  State<StatefulWidget> createState() => _UAEPassWebViewPageState();
}

class _UAEPassWebViewPageState extends State<UAEPassWebViewPage> {
  @override
  Widget build(BuildContext context) => BlocProvider<UAEPassWebViewBloc>(
        create: (context) => UAEPassWebViewBloc(),
        child: UAEPassWebViewScreen(
          isDarkMode: widget.isDarkMode,
        ),
      );
}
