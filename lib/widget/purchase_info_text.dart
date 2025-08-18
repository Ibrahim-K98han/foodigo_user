import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseInfoText extends StatelessWidget {
  const PurchaseInfoText({
    super.key,
    required this.text,
    required this.trailText,
    this.textColor = const Color(0xFF535769),
    this.fontWeight = FontWeight.w500,
  });
  final String text;
  final String trailText;
  final Color textColor;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14.sp,
            fontFamily: 'Work Sans',
            fontWeight: fontWeight,
            height: 1.43,
          ),
        ),
        Text(
          trailText,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontFamily: 'Work Sans',
            fontWeight: fontWeight,
            height: 1.43,
          ),
        )
      ],
    );
  }
}
