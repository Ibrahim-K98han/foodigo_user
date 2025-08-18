import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_text_style.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.maximumSize = const Size(double.infinity, 52),
    required this.text,
    this.fontSize = 16.0,
    required this.onPressed,
    this.textColor = blackColor,
    this.bgColor = primaryColor,
    this.minimumSize = const Size(double.infinity, 52),
    this.borderRadiusSize = 6.0,
    this.gradient = buttonGradient,
    this.isGradient = false,
  });

  final VoidCallback onPressed;

  final String text;
  final Size maximumSize;
  final Size minimumSize;
  final double fontSize;
  final double borderRadiusSize;
  final Color textColor;
  final Color bgColor;
  final bool isGradient;
  final LinearGradient gradient;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(borderRadiusSize);
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius,
        gradient: isGradient ? gradient : null,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: borderRadius)),
            backgroundColor: const WidgetStatePropertyAll(transparent),
            foregroundColor: const WidgetStatePropertyAll(transparent),
            minimumSize: WidgetStatePropertyAll(minimumSize),
            maximumSize: WidgetStatePropertyAll(maximumSize),
            shadowColor: const WidgetStatePropertyAll(transparent),
            splashFactory: NoSplash.splashFactory,
            elevation: const WidgetStatePropertyAll(0.0)),
        child: CustomText(
          text: text,
          color: textColor,
          fontSize: fontSize.sp,
          height: 1.5.h,
          fontWeight: FontWeight.w500,
          fontFamily: medium500,
        ),
      ),
    );
  }
}
