import 'package:flutter/material.dart';

class AppTextStyles {
  // Arabic Font
  static const String arabicFontFamily = 'Bahij_TheSansArabic-Bold';

  // English Font
  static const String englishFontFamily = 'SF-Pro-Rounded-Regular';

  // Example Text Styles
  static const TextStyle arabicTextStyle = TextStyle(
    fontFamily: arabicFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static const TextStyle englishTextStyle = TextStyle(
    fontFamily: englishFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static const TextStyle categoryTextStyle = TextStyle(
    fontFamily: englishFontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    color: Colors.white
  );

  static const TextStyle cartTextStyle = TextStyle(
      fontFamily: englishFontFamily,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      //color: ColorResources.apphighlightColor
  );
}
