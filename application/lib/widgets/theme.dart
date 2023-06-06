import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/widgets/color.dart';

class MyTheme {
  static lightTheme(BuildContext context) => ThemeData(
      brightness: Brightness.light,

      /// This is to ensure it's light theme
      fontFamily: GoogleFonts.poppins().fontFamily,
      // .fontFamily, // Poppins font loved by Mr. Ishan Kafle and Aaryan Jha
      cardColor: Color(MyColors.creamishColor),
      canvasColor:
          Colors.white, // So, This is the background color for default Scafold
      colorScheme: ColorScheme(
          brightness: Brightness.light, // This is to ensure it's light theme
          background: Colors.yellow, // I don't why this exists
          primary: Colors
              .green, //These are the primary Color for components such as elevated buttons
          secondary: Colors
              .black54, // For other Component we can use this, Let's use this for Containers
          onPrimary: Colors
              .white, // For Text Inside the buttons, For example: Elevated Button Text
          onSecondary: Colors.green, // For Extra Font color
          onTertiary: Color(MyColors.lightBorderRadius),
          error: Colors.red, // For error in validations and much more :<>
          onError: Colors.red, // For error in validations and much more :<>
          onBackground: Colors.yellow, // Can be used for extra components
          onSurface: Colors.black, // Can be used for extra components
          surface: Colors.black // Can be used for extra components
          ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          foregroundColor: Colors.white,
          elevation: 0,
          backgroundColor: Colors.blue),
      appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          color: Colors.white,
          centerTitle: true,
          elevation: 0.0),
      iconTheme: const IconThemeData(color: Colors.black));
  static darkTheme(BuildContext context) => ThemeData(
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.black,
      colorScheme: ColorScheme.dark(
        primary: Colors.white,
        secondary: Colors.white60,
        onPrimary: Color(MyColors.bluishColor),
        onSecondary: Colors.white,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: MyColors.lighBluishColor,
        foregroundColor: Color(MyColors.creamishColor),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        color: Colors.black,
        centerTitle: true,
        elevation: 0.0,
      ),
      iconTheme: const IconThemeData(color: Colors.black));
}
