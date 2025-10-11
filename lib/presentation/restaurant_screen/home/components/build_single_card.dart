
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

class BuildSingleCard extends StatelessWidget {
  const BuildSingleCard({
    super.key,
    required this.icon,
    required this.count,
    required this.title,
    required this.bgColor,
  });

  final String icon;
  final String count;
  final String title;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Utils.symmetric(v: 10.0, h: 8.0),
      height: Utils.vSize(80.0),
      width: Utils.hSize(162.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: borderColor),
        borderRadius: Utils.borderRadius(r: 6.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.05),
            blurRadius: 60,
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: title,
                fontSize: 13.0,
                fontWeight: FontWeight.w400,
                color: blackColor,
              ),
              CustomText(
                text: count.padLeft(2, '0'),
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: blackColor,
              ),
            ],
          ),
          Container(
            height: Utils.vSize(45.0),
            width: Utils.vSize(45.0),
            margin: Utils.only(left: 8.0, right: 6.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: bgColor,
            ),
            child: CustomImage(
              path: icon,
              height: 20.h,
              width: 20.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
