import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/utils.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});
  final String icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Utils.verticalSpace(30),
        SvgPicture.asset(
          icon,
          height: 290.h,
        ),
        Utils.verticalSpace(10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF051533),
            fontSize: 22,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w700,
            height: 1.36,
          ),
        ),
        Utils.verticalSpace(8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF535769),
            fontSize: 14,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w400,
            height: 1.57,
          ),
        )
      ],
    );
  }
}
