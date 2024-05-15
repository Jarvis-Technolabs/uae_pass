import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/uae_pass_web_view_bloc.dart';
import 'screen/uae_pass_web_view_screen.dart';

class UAEPassWebViewPage extends StatefulWidget {
  const UAEPassWebViewPage({super.key});

  @override
  State<StatefulWidget> createState() => _UAEPassWebViewPageState();
}

class _UAEPassWebViewPageState extends State<UAEPassWebViewPage> {
  @override
  Widget build(BuildContext context) => BlocProvider<UAEPassWebViewBloc>(
        create: (context) => UAEPassWebViewBloc(),
        child: const UAEPassWebViewScreen(),
      );
}
