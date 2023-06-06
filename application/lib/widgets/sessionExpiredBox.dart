import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/controller/localStorage.dart';
import 'package:hackathon/routes/routes.dart';
// import 'package:hackathon/widgets/theme.dart';

LocalStorage ls = LocalStorage();
Future<bool> displaySessionExpiry({
  required BuildContext context,
}) async {
  return await showDialog<bool>(
        barrierDismissible: false,
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        useRootNavigator: true,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Session Expired",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
              fontWeight: FontWeight.w500,
              fontSize: MediaQuery.of(context).size.width / 23,
            ),
          ),
          content: Text(
            "The user session just expired, Please Log in Again",
            // textAlign: TextAlign.center,
            style: GoogleFonts.redHatDisplay(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                ls.deleteAll();
                Navigator.pushReplacementNamed(context, MyRoutes.loginPage);
              },
              child: Text(
                'Log Out',
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
