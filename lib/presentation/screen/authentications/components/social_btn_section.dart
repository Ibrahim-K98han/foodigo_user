import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class SocialBtn extends StatelessWidget {
  const SocialBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Divider(color: Colors.black.withOpacity(0.1)),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: CustomText(text: 'OR'),
            ),
            Expanded(
              child: Divider(color: Colors.black.withOpacity(0.1)),
            )
          ],
        ),
        Utils.verticalSpace(16),
        const Row(
          children: [
            SocialItem(
              name: "Sign in with Google",
              icon: KImages.googleIcon,
            ),
          ],
        ),
      ],
    );
  }
}

class SocialItem extends StatelessWidget {
  const SocialItem({
    super.key,
    required this.name,
    required this.icon,
  });

  final String name;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 52.h,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFF040415).withOpacity(0.1),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(icon),
            Utils.horizontalSpace(10),
            CustomText(
              text: name,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
