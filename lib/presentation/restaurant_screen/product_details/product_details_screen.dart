import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/widget/custom_image.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text_style.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool small = false;
  bool medium = false;
  bool large = false;
  bool extraLarge = false;
  bool dSmall = false;
  bool dMedium = false;
  bool dLarge = false;
  bool dExtraLarge = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Stack(
            children: [
              CustomImage(
                path: KImages.foodImage1,
                fit: BoxFit.cover,
                height: 260,
                width: double.infinity,
              ),
            ],
          ),
          Padding(
            padding: Utils.symmetric(v: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // Add space between price and rating
                  children: [
                    const CustomText(
                      text: "\$25.00",
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: redColor,
                    ),
                    Row(
                      children: [
                        const CustomImage(path: KImages.star),
                        Utils.horizontalSpace(4.0),
                        const CustomText(
                          text: '4.9 ',
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        const CustomText(
                          text: '(5k+)',
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
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: borderColor),
                    borderRadius: Utils.borderRadius(),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: transparent),
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      iconColor: blackColor,
                      title: const CustomText(
                        text: "Size",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      children: [
                        Padding(
                          padding: Utils.symmetric(v: 10.0),
                          child: Column(
                            children: [
                              ...List.generate(4, (index) {
                                return Padding(
                                  padding: Utils.symmetric(h: 0, v: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(color: borderColor),
                                    ),
                                    child: Padding(
                                      padding: Utils.symmetric(v: 10.0),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: 'Medium',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          CustomText(
                                            text: '\$25.0',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Utils.verticalSpace(10.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: borderColor),
                    borderRadius: Utils.borderRadius(),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: transparent),
                    child: ExpansionTile(
                      initiallyExpanded: false,
                      iconColor: blackColor,
                      title: const CustomText(
                        text: "Addon",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      children: [
                        Padding(
                          padding: Utils.symmetric(v: 10.0),
                          child: Column(
                            children: [
                              ...List.generate(4, (index) {
                                return Padding(
                                  padding: Utils.symmetric(h: 0, v: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(color: borderColor),
                                    ),
                                    child: Padding(
                                      padding: Utils.symmetric(v: 10.0),
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            text: 'Small',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          CustomText(
                                            text: '\$25.0',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Utils.verticalSpace(20.0),
              ],
            ),
          ),
          Padding(
            padding: Utils.symmetric(v: 20.0),
            child: GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, RouteNames.editFoodScreen);
              },
              child: Container(
                height: 46.h,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomImage(path: KImages.editIcon),
                      Utils.horizontalSpace(8),
                      const CustomText(
                        text: 'Edit',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
