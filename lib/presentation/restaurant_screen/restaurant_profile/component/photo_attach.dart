import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_cubit.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_state.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../my_menu/components/edit_food_screen.dart';

class PhotoAttach extends StatelessWidget {
  const PhotoAttach({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.read<RestaurantProfileCubit>();

    final logoUrl =
        profile.restaurantProfileModel!.restaurantProfile!.logo.isNotEmpty
            ? RemoteUrls.imageUrl(
                profile.restaurantProfileModel!.restaurantProfile!.logo)
            : KImages.profile;

    final coverUrl =
        profile.restaurantProfileModel!.restaurantProfile!.coverImage.isNotEmpty
            ? RemoteUrls.imageUrl(
                profile.restaurantProfileModel!.restaurantProfile!.coverImage)
            : KImages.foodImage1;

    return UpdateProductTile(
      title: 'Photo Attachment',
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Profile Logo',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          Utils.verticalSpace(8),
          Stack(
            alignment: Alignment.center,
            children: [
              CustomImage(
                path: logoUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                top: 40,
                right: 95,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 30.w,
                    height: 30.h,
                    padding: EdgeInsets.all(4.r),
                    decoration: const BoxDecoration(
                        color: redColor, shape: BoxShape.circle),
                    child: const CustomImage(path: KImages.camera),
                  ),
                ),
              ),
            ],
          ),
          Utils.verticalSpace(16),
          const CustomText(
            text: 'Cover Photo',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          Utils.verticalSpace(8),
          Stack(
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: CustomImage(
                    path: coverUrl,
                    width: 280.w,
                    height: 125.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 280.w,
                  height: 125.h,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6.r)),
                ),
              ),
              const Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomImage(
                      path: KImages.camera,
                      width: 30,
                      height: 30,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: 'Uploaded Photo',
                          color: whiteColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
