import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../../features/HomeData/restaurant_model.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/title_and_navigator.dart';
import '../../../core/routes/route_names.dart';

class TopRestaurant extends StatelessWidget {
  const TopRestaurant({super.key, required this.restaurants});

  final List<Restaurants> restaurants;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      height: size.height * 0.32,
      decoration: const BoxDecoration(
        color: Color(0xFF000000),
      ),
      child: Padding(
        padding: Utils.symmetric(h: 0.0, v: 10.0),
        child: Column(
          children: [
            TitleAndNavigator(
              title: 'Top Restaurant',
              textColors: whiteColor,
              seeAllColors: whiteColor,
              press: () {
                Navigator.pushNamed(context, RouteNames.allRestaurantScreen);
              },
            ),
            Utils.verticalSpace(12.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  ...List.generate(restaurants.length, (index) {
                    final restaurant = restaurants[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: TopRestaurantCart(
                        restaurants: restaurant,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.restaurantProfileScreen,
                            arguments: restaurant.slug,
                          );
                        },
                      ),
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopRestaurantCart extends StatelessWidget {
  const TopRestaurantCart({super.key, required this.restaurants, this.onTap});

  final Restaurants restaurants;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.23,
        width: 260.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Align children to the start
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  child: CustomImage(
                    path: RemoteUrls.imageUrl(restaurants.coverImage),
                    fit: BoxFit.cover,
                    height: size.height * 0.12,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: const Color(0xFF00CF7E),
                    ),
                    child: Padding(
                      padding: Utils.symmetric(h: 6.0, v: 2.0),
                      child: const Center(
                          child: CustomText(
                        text: 'open',
                        color: whiteColor,
                      )),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -25,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.center,
                    // Centers the CircleAvatar horizontally
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: whiteColor,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: CustomImage(
                          path: RemoteUrls.imageUrl(restaurants.logo),
                          fit: BoxFit.fill,
                          height: 55,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:
                  Utils.only(top: 20.0, bottom: 4.0, right: 10.0, left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: restaurants.name,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        maxLine: 1,
                      ),
                      Utils.horizontalSpace(4.0),
                      const CustomImage(path: KImages.rating),
                    ],
                  ),
                  Divider(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          CustomImage(
                            path: KImages.location,
                            height: 20,
                            color: Colors.black.withOpacity(0.4),
                          ),
                          Utils.horizontalSpace(2.0),
                          CustomText(
                            text: restaurants.address,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: blackColor.withOpacity(0.6),
                          ),
                        ],
                      ),
                      Utils.horizontalSpace(4.0),
                      Container(
                        height: 5,
                        width: 5,
                        decoration: const BoxDecoration(
                            color: Color(0xFFF98C3B), shape: BoxShape.circle),
                      ),
                      Utils.horizontalSpace(4.0),
                      Row(
                        children: [
                          const CustomImage(path: KImages.star),
                          Utils.horizontalSpace(6.0),
                          Row(
                            children: [
                              CustomText(
                                text: restaurants.reviewsAvgRating,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              CustomText(
                                text: ' (${restaurants.reviewsCount})',
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: blackColor.withOpacity(0.4),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
