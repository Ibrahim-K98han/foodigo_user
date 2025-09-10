import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/utils.dart';
import 'custom_text_style.dart';

class FeedBackDialog extends StatelessWidget {
  const FeedBackDialog({
    super.key,
    required this.image,
    required this.message,
    required this.child,
    this.height = 300.0,
    this.radius = 10.0,
  });
  final String image;
  final String message;
  final Widget child;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 4.0,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: SizedBox(
          width: 330.0.w,
          height: height.h,
          child: Column(
            children: [
              Utils.verticalSpace(20.0),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFFD7E14).withOpacity(0.2),
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(image, height: 80.0.h, width: 80.0.w),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Utils.verticalSpace(16),
                    CustomText(
                      text: message,
                      fontWeight: FontWeight.w500,
                      fontSize: 24.0,
                      textAlign: TextAlign.center,
                      color: const Color(0xFF162B49),
                    ),
                    Utils.verticalSpace(20.0),
                    child,
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
