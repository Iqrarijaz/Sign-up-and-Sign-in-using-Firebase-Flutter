import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      primarySwatch: Colors.red,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.white,
      canvasColor: creemColor,
      accentColor: darkBluishColor,
      buttonColor: darkBluishColor,
      appBarTheme: AppBarTheme(
        color: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        textTheme: Theme.of(context).textTheme,
      ));

  static ThemeData darkTheme(BuildContext context) => ThemeData(
      fontFamily: GoogleFonts.poppins().fontFamily,
      brightness: Brightness.dark,
      cardColor: Colors.black,
      accentColor: Colors.white,
      canvasColor: darkCreemColor,
      buttonColor: lightBluishColor,
      appBarTheme: AppBarTheme(
        color: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: Theme.of(context).textTheme,
      ));

  //Colors
  static Color creemColor = Color(0xfff5f5f5);
  static Color darkBluishColor =Color(0xFFB71C1C);

  static Color darkCreemColor = Vx.gray900;
  static Color lightBluishColor = Vx.indigo500;
}
