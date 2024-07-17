import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeApp {
  Color primaryColor = const Color.fromARGB(255, 44, 82, 157);
  Color secondaryColor = const Color.fromARGB(255, 116, 197, 255);
  Color tertiaryColor = const Color.fromARGB(255, 255, 116, 116);

  Color lightBackgroundColor = const Color.fromARGB(255, 252, 252, 252);
  Color darkBackgroundColor = const Color.fromARGB(255, 18, 18, 18);

  Color lightTextColor = const Color.fromARGB(255, 29, 29, 29);
  Color darkTextColor = const Color.fromARGB(255, 230, 230, 230);

  Color lightScaffoldBackgroundColor = const Color.fromARGB(255, 247, 246, 255);
  Color darkScaffoldBackgroundColor = const Color.fromARGB(255, 33, 33, 33);

  Color lightAppBarBackgroundColor = Colors.white;
  Color darkAppBarBackgroundColor = const Color.fromARGB(255, 48, 48, 48);

  Color accentColor = const Color.fromARGB(255, 68, 255, 243);
  Color hintColor = Colors.grey;
  Color errorColor = Colors.red;
  Color dangerColor = const Color.fromARGB(255, 255, 102, 102);
  Color successColor = const Color.fromARGB(255, 113, 255, 118);
  Color warningColor = const Color.fromARGB(255, 255, 193, 100);
  Color shadowColor = Colors.grey[300]!;
  Color borderColor = Colors.grey[300]!;

  BuildContext? context;

  ThemeApp({this.context});

  ThemeData darkThemeData() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: darkScaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: darkAppBarBackgroundColor,
        elevation: 0,
        titleTextStyle: TextStyle(color: darkTextColor),
        iconTheme: IconThemeData(color: primaryColor),
      ),
      textTheme: textThemeDark(),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: hintColor),
        labelStyle: TextStyle(color: darkTextColor),
        errorStyle: TextStyle(color: errorColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
        ),
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: Colors.black,
      ),
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: secondaryColor,
        background: darkBackgroundColor,
        surface: darkBackgroundColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: darkTextColor,
        onBackground: darkTextColor,
        error: errorColor,
        onError: Colors.white,
      ),
    );
  }

  ThemeData lightThemeData() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: lightScaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: lightAppBarBackgroundColor,
        elevation: 0,
        titleTextStyle: TextStyle(color: lightTextColor),
        iconTheme: IconThemeData(color: primaryColor),
      ),
      textTheme: textThemeLight(),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: hintColor),
        labelStyle: TextStyle(color: lightTextColor),
        errorStyle: TextStyle(color: errorColor),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorColor),
        ),
        contentPadding: const EdgeInsets.all(10),
        filled: true,
        fillColor: Colors.white,
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        background: lightBackgroundColor,
        surface: lightBackgroundColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: lightTextColor,
        onBackground: lightTextColor,
        error: errorColor,
        onError: Colors.white,
      ),
    );
  }

  TextTheme textTheme() {
    return Get.isDarkMode ? textThemeDark() : textThemeLight();
  }

  textThemeDark() {
    return TextTheme(
      displayLarge: TextStyle(
        color: darkTextColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 22,
        color: darkTextColor,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        color: darkTextColor,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        color: darkTextColor,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: darkTextColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: darkTextColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: darkTextColor,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: darkTextColor,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: darkTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: darkTextColor,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: darkTextColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        color: darkTextColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        color: darkTextColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        color: darkTextColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextTheme textThemeLight() {
    return TextTheme(
      displayLarge: TextStyle(
        color: lightTextColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontSize: 22,
        color: lightTextColor,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        color: lightTextColor,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 18,
        color: lightTextColor,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: lightTextColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: lightTextColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        color: lightTextColor,
        fontSize: 16,
      ),
      bodyMedium: TextStyle(
        color: lightTextColor,
        fontSize: 14,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        color: lightTextColor,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: lightTextColor,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: lightTextColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: TextStyle(
        color: lightTextColor,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        color: lightTextColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        color: lightTextColor,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  ThemeData themeData() {
    return Get.isDarkMode ? darkThemeData() : lightThemeData();
  }
}
