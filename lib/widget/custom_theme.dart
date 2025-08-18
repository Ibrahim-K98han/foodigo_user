import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';

class MyTheme {
  static final borderRadius = BorderRadius.circular(Utils.hPadding(size: 10.0));
  static final theme = ThemeData(
      brightness: Brightness.light,
      primaryColor: whiteColor,
      scaffoldBackgroundColor: scaffoldBackground,
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: whiteColor),
      colorScheme: const ColorScheme.light(secondary: lightningYellowColor),
      appBarTheme: const AppBarTheme(
        backgroundColor: whiteColor,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: blackColor, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: blackColor),
        elevation: 0,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        const TextTheme(
          bodySmall: TextStyle(fontSize: 12, height: 1.83),
          bodyLarge: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, height: 1.375),
          bodyMedium: TextStyle(fontSize: 14, height: 1.5714),
          labelLarge:
              TextStyle(fontSize: 16, height: 2, fontWeight: FontWeight.w600),
          // titleLarge: const TextStyle(
          //     fontSize: 16, height: 2, fontWeight: FontWeight.w600),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 64),
          backgroundColor: lightningYellowColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll<double>(0.0),
          splashFactory: NoSplash.splashFactory,
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0))),
          shadowColor: const WidgetStatePropertyAll<Color>(transparent),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 3,
        backgroundColor: whiteColor,
        showUnselectedLabels: true,
        selectedLabelStyle:
            GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w500),
        unselectedLabelStyle:
            GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w400),
        selectedItemColor: const Color(0xFF333333),
        unselectedItemColor: const Color(0xFF606060),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        hintStyle: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
            color: grayColorWithOpacity),
        labelStyle: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w400,
            fontSize: 14.0,
            color: grayColorWithOpacity),
        contentPadding: EdgeInsets.symmetric(
            horizontal: Utils.hPadding(size: 20.0),
            vertical: Utils.vPadding(size: 18.0)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide:  const BorderSide(
            color: borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide:  const BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
          borderSide:  const BorderSide(
            color: borderColor,
          ),
        ),
        fillColor: Colors.transparent,
        filled: true,
        focusColor: borderColor,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: blackColor,
        selectionColor: blackColor,
        selectionHandleColor: blackColor,
      ),
      progressIndicatorTheme:
          const ProgressIndicatorThemeData(color: primaryColor));
}
