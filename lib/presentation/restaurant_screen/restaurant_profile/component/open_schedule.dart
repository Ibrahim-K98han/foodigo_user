import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_cubit.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../my_menu/components/edit_food_screen.dart';

class OpenSchedule extends StatelessWidget {
  const OpenSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.read<RestaurantProfileCubit>();
    return UpdateProductTile(
      title: 'Open Schedule',
      widget: Column(
        children: [
          ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Sunday',
                      fontWeight: FontWeight.w500,
                    ),
                    Utils.verticalSpace(2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 250.w,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(color: borderColor)),
                          child: Row(
                            children: [
                              const CustomImage(
                                path: KImages.message,
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                              Utils.horizontalSpace(4),
                              CustomText(
                                  text:
                                      '${profile.restaurantProfileModel!.restaurantProfile!.openingHour} - ${profile.restaurantProfileModel!.restaurantProfile!.closingHour}'),
                            ],
                          ),
                        ),
                        const CustomImage(
                          path: KImages.time_square,
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
          Utils.verticalSpace(8),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Container(
          //     width: 105.w,
          //     height: 36.h,
          //     padding: const EdgeInsets.symmetric(horizontal: 6),
          //     decoration: BoxDecoration(
          //         border: Border.all(color: greenColor),
          //         borderRadius: BorderRadius.circular(4.r)),
          //     child: const Row(
          //       children: [
          //         Icon(
          //           Icons.add,
          //           color: greenColor,
          //         ),
          //         CustomText(
          //           text: 'Add New',
          //           color: greenColor,
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
