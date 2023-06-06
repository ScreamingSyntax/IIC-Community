import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:hackathon/widgets/theme.dart';

Future<bool> displayErrorDialog(
    {required BuildContext context,
    required String message,
    required String errorType}) async {
  return await showDialog<bool>(
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        useRootNavigator: true,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            errorType,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.width / 23,
            ),
          ),
          content: Text(
            message,
            // textAlign: TextAlign.center,
            style: GoogleFonts.redHatDisplay(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Try Again',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.width / 30,
                ),
              ),
            ),
          ],
        ),
      ) ??
      false;
}
