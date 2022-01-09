import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Map<int, Color> color = {
  50: const Color.fromRGBO(2, 50, 160, .1),
  100: const Color.fromRGBO(2, 50, 160, .2),
  200: const Color.fromRGBO(2, 50, 160, .3),
  300: const Color.fromRGBO(2, 50, 160, .4),
  400: const Color.fromRGBO(2, 50, 160, .5),
  500: const Color.fromRGBO(2, 50, 160, .6),
  600: const Color.fromRGBO(2, 50, 160, .7),
  700: const Color.fromRGBO(2, 50, 160, .8),
  800: const Color.fromRGBO(2, 50, 160, .9),
  900: const Color.fromRGBO(2, 50, 160, 1),
};

final MaterialColor accentColor = MaterialColor(0xFF0232a0, color);

class ProjectTheme {
  // 1
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.montserrat(
      fontSize: 14.0,
      //fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500,
      color: accentColor,
    ),
    bodyText2: GoogleFonts.openSans(
      fontSize: 15.0,
      //fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline6: GoogleFonts.openSans(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  // 2
  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyText2: GoogleFonts.openSans(
      fontSize: 15.0,
      //fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline1: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    headline3: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline6: GoogleFonts.openSans(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  // 3
  static ThemeData light() {
    return ThemeData(
      // highlightColor: accentColor,
      primaryColor: accentColor,
      canvasColor: Colors.grey.shade200,
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
          (states) {
            return Colors.black;
          },
        ),
      ),
      appBarTheme: AppBarTheme(color: accentColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          primary: Colors.green,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: lightTextTheme,
    );
  }

  // 4
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: accentColor,
      drawerTheme: const DrawerThemeData(backgroundColor: Colors.black87),
      canvasColor: Colors.grey.shade200,
      appBarTheme: AppBarTheme(color: accentColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          primary: Colors.green,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: darkTextTheme,
    );
  }
}
