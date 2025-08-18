import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_text_style.dart';

class TitleAndNavigator extends StatelessWidget {
  const TitleAndNavigator({
    super.key,
    required this.title,
    required this.press,
    this.isSeeAll = true,
    this.textColors = textColor,
    this.seeAllColors = blueColor,
  });

  final String title;
  final VoidCallback press;
  final bool isSeeAll;
  final Color textColors;
  final Color seeAllColors;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            color: textColors,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
          isSeeAll
              ? GestureDetector(
                  onTap: press,
                  child: const CustomText(
                    text: 'See All',
                    color: greyColor,
                    fontFamily: regular400,
                  ),
                )
              : const SizedBox(),
          //Utils.horizontalSpace(6),
          //const Icon(Icons.arrow_forward, color: primaryColor),
        ],
      ),
    );
  }
}
