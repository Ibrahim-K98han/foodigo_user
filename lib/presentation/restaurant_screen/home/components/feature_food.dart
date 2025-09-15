import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/title_and_navigator.dart';
import '../../../core/routes/route_names.dart';
import '../../product_details/product_details_screen.dart';

class MyFood extends StatelessWidget {
  const MyFood({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndNavigator(
          title: 'My Food Menu',
          textColors: textColor,
          seeAllColors: subTitleTextColor,
          press: () {},
        ),
        Utils.verticalSpace(16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              ...List.generate(5, (index) {
                // final service = DummyData.influencerList[index];
                return const Padding(
                  padding: EdgeInsets.only(right: 14),
                  child: FoodCart(),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}

class FoodCart extends StatelessWidget {
  const FoodCart({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, RouteNames.editFoodScreen);
        showModalBottomSheet(
          context: context,
          showDragHandle: true,
          backgroundColor: whiteColor,
          constraints: BoxConstraints.loose(
            Size(
              Utils.mediaQuery(context).width,
              Utils.mediaQuery(context).height * 0.9,
            ),
          ),
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Utils.radius(10.0)),
              topRight: Radius.circular(Utils.radius(10.0)),
            ),
          ),
          builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.85,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: const ProductDetailsScreen(),
              );
            },
          ),
        );
      },
      child: Container(
        height: 230.0,
        width: 240.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Align children to the start
          children: [
            Stack(
              children: [
                const ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  child: CustomImage(
                    path: KImages.foodImage1,
                    fit: BoxFit.fill,
                    height: 150,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    height: 30.h,
                    width: 30.w,
                    decoration: const BoxDecoration(
                      color: whiteColor,
                      shape: BoxShape.circle
                    ),
                    child: Padding(
                      padding: Utils.all(value: 6.0),
                      child: const Center(
                          child: CustomImage(
                        path: KImages.editIcon,
                        color: redColor,
                      )),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: Utils.symmetric(v: 8.0, h: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // Align children to the start
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // Add space between price and rating
                    children: [
                      const CustomText(
                        text: "\$25.00",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: redColor,
                      ),
                      Row(
                        children: [
                          const CustomImage(path: KImages.star),
                          Utils.horizontalSpace(6.0),
                          const CustomText(
                            text: '4.9 ',
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                          const CustomText(
                            text: ' (5k+)',
                            fontSize: 13,
                            color: subTitleTextColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Utils.verticalSpace(4.0),
                  const CustomText(
                    text: 'Sandwiches Strawberry',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                    color: textColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
