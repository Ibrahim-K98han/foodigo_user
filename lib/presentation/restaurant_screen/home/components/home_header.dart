import 'package:flutter/material.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../core/routes/route_names.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: Utils.vSize(size.height * 0.22),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFFF6EEEE),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      //Utils.horizontalSpace(10),
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, RouteNames.editProfile),
                        },
                        child: Container(
                          height: Utils.vSize(52.0),
                          width: Utils.vSize(52.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child:  const CustomImage(
                              path: KImages.profile,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Utils.horizontalSpace(10.0),
                      const Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Welcome',
                              color: Color(0xFF334155),
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            CustomText(
                              text: 'Hi, Mouton Cafe',
                              color: blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      Utils.horizontalSpace(10),
                    ],
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(
                        //     context, RouteNames.notificationScreen);
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: whiteColor, width: 1.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: CustomImage(
                            path: KImages.notificationIcon,
                            height: 25,
                          ),
                        ),
                      ),
                    ),
                    Utils.horizontalSpace(8.0),
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, RouteNames.editFoodScreen);
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: const BoxDecoration(
                          color: redColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 35,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: -30.0,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: double.infinity,
                // height: Utils.vSize(60.0),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: Utils.borderRadius(),
                  border: Border.all(
                    color: borderColor,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 40,
                      offset: Offset(0, 2),
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: Padding(
                  padding: Utils.symmetric(v: 20.0),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "My Balance",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            CustomText(
                              text: "\$2536.00",
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: primaryColor),
                          child: Padding(
                            padding: Utils.symmetric(h: 10.0, v: 10.0),
                            child: Row(
                              children: [
                                 const CustomImage(
                                  path: KImages.withdraw,
                                  height: 24,
                                ),
                                Utils.horizontalSpace(6.0),
                                const CustomText(
                                  text: 'Withdraw',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
