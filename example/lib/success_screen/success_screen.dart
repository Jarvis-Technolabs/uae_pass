import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  final String message;

  const SuccessScreen({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                Icon(
                  Icons.done,
                  color: Colors.green,
                  size: 80,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Success",
                  style: TextStyle(fontSize: 30.0),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  message
                      .replaceAll("Vipul", "xyz")
                      .replaceAll("vipul", "xyz")
                      .replaceAll("Kerai", "pqr")
                      .replaceAll("jarvis", "pqr")
                      .replaceAll("917990922803", "123456789"),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      );
}
