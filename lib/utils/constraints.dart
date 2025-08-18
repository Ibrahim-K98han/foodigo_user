import 'package:flutter/material.dart';

const titleTextColor = Color(0xFF121A26);
const hTextColor = Color(0xFF061533);
const subTitleTextColor = Color(0xFF64748B);
const textColor = Color(0xFF001C31);

const primaryColor = Color(0xFFF9C200);
const labelColor = Color(0xFF001C31);
const blueColor = Color(0xFF1778F1);
const redColor = Color(0xFFF54748);
const backgroundColor = Color(0xFF5F21A3);
const Color lightningYellowColor = Color(0xffFFBB38);
const Color blackColor = Color(0xFF061533);
const Color greyColor = Color(0xFF6C798B);
const Color scaffoldBackground = Color(0xFFFFFFFF);
// const Color scaffoldBackground = Color(0xFFF6F8FA);
const Color inputFieldBGColor = Color(0x00ffe8f2);
const Color whiteColor = Color(0xFFFFFFFF);
const Color scaffoldBgColor = Color(0xFFF4F4F4);
const Color scaffoldBg = Color(0xFFF8F8F8);
const Color inputBGColor = Color(0xFFF9FAFB);
const Color transparent = Colors.transparent;
const Color grayColorWithOpacity = Color(0xFF535769);
const Color borderColor = Color(0xFFE2E8F0) ;
const Color greenColor = Color(0xFF27AE60);
const Color yellowColor = Color(0xFFFFC107);
const Color dialogBgColor = Color(0xFFF8FAFC);
const Color settingsIconBgColor = Color(0xFF0C1321);
const Color lightGrayColor = Color(0xFF475569);
const Color grayBgColor = Color(0xFFF1F5F9);
const Color faqBgColor = Color(0xFF0C1321);
const Color bottomNavIconColor = Color(0xFF334155);
const Color textGrayColor = Color(0xFF64748B);
const Color smallContainerColor = Color(0xFFF98C3B);




const kDuration = Duration(microseconds: 300);

///custom fonts
const String regular400 = 'Regular400';
const String medium500 = 'Medium500';
const String bold700 = 'Bold700';
// const String roboto400 = 'Roboto-400';
// const String roboto500 = 'Roboto-500';
// const String roboto700 = 'Roboto-700';

//app logo gradient
const logoGradient = LinearGradient(
  tileMode: TileMode.clamp,
  colors: [
    Color(0xFF4D22AA),
    Color(0xFF851C91),
    Color(0xFFC21575),
    Color(0xFFDA126A),
  ],
);

Shader textGradient = const LinearGradient(
  colors: [
    Color(0xFF4D22AA),
    Color(0xFF851C91),
    Color(0xFFC21575),
    Color(0xFFDA126A),
  ],
).createShader(const Rect.fromLTWH(0.0, 0.0, 51.0, 12.0));

final themeGradient = LinearGradient(
  colors: [
    const Color(0xFF4D22AA).withOpacity(0.2),
    const Color(0xFF851C91).withOpacity(0.36),
    const Color(0xFFC21575).withOpacity(0.79),
    const Color(0xFFDA126A),
  ],
);
//banner gradient

const bannerGradient = LinearGradient(colors: [
  Color(0xFF5E2AD0),
  Color(0xFF851C91),
  Color(0xFFC21575),
  Color(0xFFDA126A),
]);
const buttonGradient = LinearGradient(
  begin: Alignment(0.00, -1.00),
  end: Alignment(0, 1),
  colors: [Color(0xFF885DF1), Color(0xFF6610F2)],
);

const activeTabButtonGradient = LinearGradient(
  begin: Alignment(0.00, -1.00),
  end: Alignment(0, 1),
  colors: [Color(0xFFFFC107), Color(0xFFFD7E14)],
);

const inactiveTabButtonGradient = LinearGradient(
  begin: Alignment(0.00, -1.00),
  end: Alignment(0, 1),
  colors: [Colors.white, whiteColor],
);
const dialogCircleGradient = LinearGradient(
  begin: Alignment(0.00, -1.00),
  end: Alignment(0, 1),
  colors: [Color(0xFFFFC107), Color(0xFFFD7E14)],
);
