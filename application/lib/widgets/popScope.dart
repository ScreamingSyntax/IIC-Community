import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> showExitPopup(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Exit App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: Text(
            'Do you want to exit the app?',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'No',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red))),
          ],
        ),
      ) ??
      false;
}
