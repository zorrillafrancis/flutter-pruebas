import 'package:flutter/material.dart';
import '../utils/constants.dart';

ThemeData getTheme(BuildContext context) {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'Muli',
      textTheme: textTheme(),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      colorSchemeSeed: const Color(0xff6750a4),
      brightness: Brightness.light,
      appBarTheme: appBarTheme(context),
      inputDecorationTheme: inputDecarationTheme());
}

TextTheme textTheme() {
  return const TextTheme(
    bodyLarge: TextStyle(color: kTextColor),
    bodyMedium: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme(BuildContext context) {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.black),
    titleTextStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontFamily: 'Muli', fontSize: 20, color: const Color(0XFF8B8B8B)),
  );
}

InputDecorationTheme inputDecarationTheme() {
  var outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: kTextColor),
      gapPadding: 10);

  return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      contentPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder);
}
