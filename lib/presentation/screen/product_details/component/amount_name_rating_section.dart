import 'package:flutter/material.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';

class AmountNameRatingSection extends StatefulWidget {
  const AmountNameRatingSection({super.key});

  @override
  State<AmountNameRatingSection> createState() =>
      _AmountNameRatingSectionState();
}

class _AmountNameRatingSectionState extends State<AmountNameRatingSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // Add space between price and rating
          children: [
            const CustomText(
              text: "\$25.00",
              fontSize: 18,
              color: redColor,
              fontWeight: FontWeight.bold,
            ),
            Row(
              children: [
                const CustomImage(path: KImages.star),
                Utils.horizontalSpace(6.0),
                Row(
                  children: [
                    const CustomText(
                      text: '4.9 ',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    CustomText(
                      text: '(5k+)',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: blackColor.withOpacity(0.4),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Utils.verticalSpace(4.0),
        const CustomText(
          text: 'Sandwiches Strawberry',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          maxLine: 1,
        ),
        Utils.verticalSpace(6.0),
        const CustomText(
          text:
          'Strawberry sandwich" is a delightful treat, particularly popular in Japan, where its often referred to as a "fruit sando." Here  a breakdown of what it typically includes:',
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Color(0xFF475569),
        ),
        Utils.verticalSpace(10.0),
      ],
    );
  }
}