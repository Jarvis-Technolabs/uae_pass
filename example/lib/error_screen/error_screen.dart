import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final String message;

  const ErrorScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Icon(
                  Icons.error,
                  color: Colors.redAccent,
                  size: 80,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Error",
                  style: TextStyle(fontSize: 30.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(message),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
}
