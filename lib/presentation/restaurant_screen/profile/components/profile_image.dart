import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                height: Utils.vSize(80.0),
                width: Utils.vSize(80.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: Utils.borderRadius(r: 50.0),
                  child: const CustomImage(
                    path: KImages.message,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 6,
                bottom: 0,
                child: Container(
                  height: 24.h,
                  width: 24.w,
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                      color: primaryColor, shape: BoxShape.circle),
                  child: const CustomImage(path: KImages.editIcon),
                ),
              )
            ],
          ),
          Utils.verticalSpace(8.0),
          const CustomText(
            text: 'McDonalds Cafe',
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          Utils.verticalSpace(16.0),
        ],
      ),
    );
  }
}