import 'package:flutter/material.dart';

Widget myCustomLoading(
    {required BuildContext context, required String message}) {
  return Scaffold(
      // color: color,
      body: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
        ),
        Text(""),
        CircularProgressIndicator(
          color: Theme.of(context).colorScheme.onSecondary,
        )
      ],
    ),
  ));
}
