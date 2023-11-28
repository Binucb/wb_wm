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
    bodyLarge: GoogleFonts.montserrat(
      fontSize: 12.0,
      //fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w500,
      color: accentColor,
    ),
    bodyMedium: GoogleFonts.openSans(
      fontSize: 13.0,
      //fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displayLarge: GoogleFonts.openSans(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displaySmall: GoogleFonts.openSans(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleLarge: GoogleFonts.openSans(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  // 2
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyMedium: GoogleFonts.openSans(
      fontSize: 15.0,
      //fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displayLarge: GoogleFonts.openSans(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: GoogleFonts.openSans(
      fontSize: 21.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displaySmall: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleLarge: GoogleFonts.openSans(
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
          ), backgroundColor: Colors.green,
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
          ), backgroundColor: Colors.green,
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
