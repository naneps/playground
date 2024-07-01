import 'package:flutter/material.dart';

class ThemeApp {
  Color primaryColor = const Color.fromARGB(255, 0, 42, 158);
  Color secondaryColor = const Color.fromARGB(255, 116, 197, 255);
  Color tertiaryColor = const Color.fromARGB(255, 255, 116, 116);
  Color backgroundColor = const Color.fromARGB(255, 252, 252, 252);
  Color textColor = const Color.fromARGB(255, 29, 29, 29);
  Color black = const Color.fromARGB(255, 33, 33, 33);
  Color accentColor = const Color.fromARGB(255, 68, 255, 243);
  Color hintColor = Colors.grey;
  Color errorColor = Colors.red;
  Color dangerColor = const Color.fromARGB(255, 255, 102, 102);
  Color successColor = const Color.fromARGB(255, 113, 255, 118);
  Color warningColor = const Color.fromARGB(255, 255, 193, 100);
  Color shadowColor = Colors.grey[300]!;
  Color borderColor = Colors.grey[300]!;
  Color scaffoldBackgroundColor = const Color.fromARGB(255, 247, 246, 255);
  Color appBarBackgroundColor = Colors.white;

  BuildContext? context;
  ThemeApp({this.context});

  ThemeData get themeData {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarBackgroundColor,
        elevation: 0,
        titleTextStyle: Theme.of(context!).textTheme.labelLarge,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        iconColor: primaryColor,
        textColor: textColor,
      ),
      fontFamily: 'Inter',
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: textColor,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: textColor,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: textColor,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: textColor,
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          color: textColor,
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          color: textColor,
          fontSize: 12,
        ),
        titleMedium: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelLarge: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: backgroundColor,
        disabledColor: Colors.grey.shade300,
        selectedColor: primaryColor,
        secondarySelectedColor: primaryColor,
        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelStyle: TextStyle(
          color: textColor,
          fontSize: 12,
        ),
        secondaryLabelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
        side: const BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
        brightness: Brightness.light,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: hintColor),
        labelStyle: TextStyle(color: textColor),
        errorStyle: TextStyle(color: errorColor),
        counterStyle: TextStyle(color: hintColor),
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
        constraints: const BoxConstraints(minHeight: 40),
        isDense: true,
        suffixIconColor: primaryColor,
        prefixIconColor: primaryColor,
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          foregroundColor: MaterialStateProperty.all(primaryColor),
          padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          minimumSize: MaterialStateProperty.all(const Size(10, 10)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor: primaryColor,
        indicatorColor: primaryColor,
        dividerColor: Colors.transparent,
        splashFactory: InkRipple.splashFactory,
        unselectedLabelColor: Colors.grey.shade400,
        labelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      dividerColor: Colors.grey.shade100,
      dividerTheme: DividerThemeData(
        thickness: 2,
        space: 5,
        color: Colors.grey.shade200,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey.shade400,
        showSelectedLabels: true,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme: IconThemeData(
          color: Colors.grey.shade400,
          size: 20,
        ),
        selectedIconTheme: IconThemeData(
          color: primaryColor,
          size: 25,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          fixedSize: MaterialStateProperty.all(
              Size(MediaQuery.of(context!).size.width, 40)),
          minimumSize: MaterialStateProperty.all(const Size(10, 10)),
          padding: MaterialStateProperty.all(const EdgeInsets.all(5)),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(color: primaryColor, width: 0),
            ),
          ),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryColor,
        inactiveTrackColor: Colors.grey.shade300,
        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
        trackShape: const RoundedRectSliderTrackShape(),
        activeTickMarkColor: primaryColor,
        thumbColor: primaryColor,
        overlayColor: primaryColor.withOpacity(0.3),
        valueIndicatorColor: primaryColor,
        valueIndicatorTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: const InputDecorationTheme(),
          menuStyle: MenuStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          )),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        error: errorColor,
        onError: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textColor,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: Colors.white,
        background: backgroundColor,
        onBackground: textColor,
      ),
    );
  }
}
