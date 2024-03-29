import 'package:flutter/material.dart';

class AppStyle {
  static const Color blackColor = Color(0xFF333333);
  static const Color mainColor = blackColor;
  static const Color seconderyColor = blackColor;
  // static const Color darkBlueColor = Color(0xff20315a);
  // static const Color lightBlueColor = Color(0xFF2C52AB);
  static const Color kBackGroundColor = Color(0xffF0F0F0);
  static const Color kLightGrey = Color(0xFFE4E4E4);
  static const Color kGreyColor = Color(0xFFb5b5b5);
  static const Color redColor = Color(0xFFD81721);
  static const Color kGreenColor = Color(0xff4BBCA7);
  static const String fontName = "Cairo";

  static ThemeData theme = ThemeData(
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: kBackGroundColor),
    primaryColor: mainColor,
    useMaterial3: true,
    scaffoldBackgroundColor: kBackGroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color(0xFF145770),
      secondary: const Color(0xFF145770),
    ),
    chipTheme: const ChipThemeData(
        backgroundColor: Colors.white, selectedColor: mainColor),
    progressIndicatorTheme: const ProgressIndicatorThemeData()
        .copyWith(refreshBackgroundColor: kBackGroundColor),
    radioTheme: const RadioThemeData()
        .copyWith(fillColor: MaterialStateProperty.all<Color>(mainColor)),
    checkboxTheme: const CheckboxThemeData()
        .copyWith(fillColor: MaterialStateProperty.all<Color>(mainColor)),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: kBackGroundColor,
      surfaceTintColor: mainColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 24,
        color: blackColor,
        fontFamily: fontName,
        fontWeight: AppFontWeight.bold,
      ),
    ),
    dividerColor: const Color(0xFFD9D9D9),
    fontFamily: fontName,
    textTheme: const TextTheme(
      // headline1: TextStyle(),
      headline1: TextStyle(
        fontSize: 35,
        fontWeight: AppFontWeight.bold,
        fontFamily: fontName,
        color: blackColor,
      ),
      headline2: TextStyle(
        fontSize: 28,
        fontWeight: AppFontWeight.bold,
        color: blackColor,
      ),
      headline3: TextStyle(
        fontSize: 24,
        fontWeight: AppFontWeight.bold,
        color: blackColor,
      ),
      headline4: TextStyle(
        fontSize: 20,
        color: blackColor,
        fontWeight: AppFontWeight.bold,
      ),
      headline5: TextStyle(fontSize: 18, color: blackColor),
      headline6: TextStyle(
        fontSize: 16,
        color: blackColor,
        fontWeight: AppFontWeight.medium,
      ),

      bodyText1: TextStyle(
        fontSize: 18,
        color: blackColor,
        fontWeight: AppFontWeight.light,
      ),
      bodyText2: TextStyle(
        fontSize: 14,
        color: blackColor,
        fontWeight: AppFontWeight.light,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.black,
            surfaceTintColor: Colors.black,
            foregroundColor: kGreyColor)),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      border: InputBorder.none,
      hintStyle: const TextStyle(color: kGreyColor),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: redColor),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: redColor),
      ),
    ),
  );

  static const k30BorderRadius = BorderRadius.all(Radius.circular(30));
  static const k15BorderRadius = BorderRadius.all(Radius.circular(15));

  static const k8BorderRadius = BorderRadius.all(Radius.circular(8));
  static const k4RadiusLowerPadding = BorderRadius.all(Radius.circular(4));

  static const k30TopBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  );
  static const k10TopBorderRectangle = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  );
}

abstract class AppFontWeight {
  static const FontWeight light = FontWeight.w200;
  static const FontWeight medium = FontWeight.w400;
  static const FontWeight bold = FontWeight.w800;
}
