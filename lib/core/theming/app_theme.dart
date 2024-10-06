import 'package:flutter/material.dart';
import 'package:new_quakka/utill/color_resources.dart';

import 'colors.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: ColorsManager.mainRed,
    hintColor: ColorsManager.hint,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryTextTheme: const TextTheme(
      displayLarge: TextStyle(
          fontSize: 28, color: Colors.black, fontWeight: FontWeight.w900),
      displayMedium: TextStyle(
          fontSize: 24, color: Colors.black, fontWeight: FontWeight.w900),
      displaySmall: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
      headlineMedium: TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.w700),
      headlineSmall: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
      titleLarge: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
    ),

    fontFamily: "Tajawal",
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
          height: 1.3,
          fontSize: 22,
          fontFamily: "Tajawal",
          color: Colors.black,
          fontWeight: FontWeight.bold),
    ),
    appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        centerTitle: false,
        color: ColorResources.apphighlightColor,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),

        titleTextStyle: TextStyle(
            fontFamily: "Tajawal",
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500),

    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.lightScaffoldBackgroundColor,
        elevation: 0,
        selectedIconTheme: IconThemeData(
          color: ColorsManager.mainRed,
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.black,
        ),
        selectedItemColor: ColorsManager.mainRed,
        unselectedItemColor: Colors.black),

    //fontFamily: 'jannah',
  );
}
