import 'package:flutter/material.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isVisibleBorder = true,
    this.version = false,
  });

  final String icon;
  final String title;
  final bool isVisibleBorder;
  final bool version;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(v: 20.0).copyWith(top: 0.0, bottom: 20.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomImage(
                      path: icon,
                      fit: BoxFit.cover,
                      color: blackColor,
                      height: 26,
                    ),
                    Utils.horizontalSpace(12.0),
                    CustomText(
                      text: title,
                      color: blackColor,
                      fontSize: 16.0,
                      fontFamily: regular400,
                    ),
                  ],
                ),
                version
                    ? const CustomText(
                  text: '1.0.0',
                  color: blackColor,
                  fontSize: 16.0,
                  fontFamily: bold700,
                )
                    : const SizedBox(),
              ],
            ),
          ),
          isVisibleBorder
              ? Container(
            height: 1.0,
            width: double.infinity,
            margin: Utils.only(right: 20.0, top: 20.0),
            color: greyColor.withOpacity(0.2),
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}