import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/presentation/screen/product_details/product_details_screen.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../../data/remote_url.dart';
import '../../../../features/HomeData/feature_product_model.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/title_and_navigator.dart';
import '../../../core/routes/route_names.dart';

class FeatureFood extends StatelessWidget {
  const FeatureFood({super.key, required this.featuredProducts});

  final List<FeaturedProducts> featuredProducts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndNavigator(
          title: 'Feature Food',
          press: () {
            Navigator.pushNamed(context, RouteNames.allFoodScreen);
          },
        ),
        Utils.verticalSpace(16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              ...List.generate(featuredProducts.length, (index) {
                final featureProduct = featuredProducts[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: FeatureFoodCart(
                    featuredProducts: featureProduct,
                  ),
                );
              })
            ],
          ),
        ),
      ],
    );
  }
}

class FeatureFoodCart extends StatelessWidget {
  const FeatureFoodCart({super.key, required this.featuredProducts});

  final FeaturedProducts featuredProducts;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, RouteNames.productDetailsScreen);
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
        height: size.height * 0.32,
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
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  child: CustomImage(
                    path: RemoteUrls.imageUrl(featuredProducts.image),
                    fit: BoxFit.fill,
                    height: 150,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: whiteColor,
                      ),
                      child: Padding(
                        padding: Utils.all(value: 6.0),
                        child: const Center(
                            child: CustomImage(
                          path: KImages.loveIcon,
                          color: blackColor,
                        )),
                      ),
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
                      CustomText(
                        text: '\$${featuredProducts.price}',
                        fontSize: 16,
                        color: redColor,
                        fontWeight: FontWeight.w700,
                      ),
                      Row(
                        children: [
                          const CustomImage(path: KImages.star),
                          Utils.horizontalSpace(6.0),
                          Row(
                            children: [
                              CustomText(
                                text: featuredProducts.reviewsAvgRating,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              CustomText(
                                text: ' (${featuredProducts.reviewsCount})',
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
                  CustomText(
                    text: featuredProducts.name,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: settingsIconBgColor,
                    maxLine: 1,
                  ),
                  Utils.verticalSpace(6.0),
                  Row(
                    children: [
                      CustomImage(
                        path: KImages.location,
                        height: 20,
                        color: blackColor.withOpacity(0.4),
                      ),
                      Utils.horizontalSpace(6.0),
                      CustomText(
                        text: 'QS Jose,Spain',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ],
                  ),
                  Utils.verticalSpace(6.0),
                  Row(
                    children: [
                      const CustomImage(path: KImages.rProfile, height: 20),
                      Utils.horizontalSpace(6.0),
                      const CustomText(
                        text: 'Chef’s Place',
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ],
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
