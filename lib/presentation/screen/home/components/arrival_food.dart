import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import '../../../../features/HomeData/feature_product_model.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/title_and_navigator.dart';
import '../../../core/routes/route_names.dart';
import '../../product_details/product_details_screen.dart';

class ArrivalFood extends StatelessWidget {
  const ArrivalFood({super.key, required this.newArrivalProducts});

  final List<FeaturedProducts> newArrivalProducts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Utils.symmetric(),
          child: const CustomText(
            text: 'New Arrival Food',
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Utils.verticalSpace(16),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              ...List.generate(newArrivalProducts.length, (index) {
                final newArrival = newArrivalProducts[index];
                return Padding(
                  padding:  EdgeInsets.only(
                    bottom: 16.0.h,
                  ),
                  child: FoodCart(
                    newArrivalProducts: newArrival,
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

class FoodCart extends StatelessWidget {
  const FoodCart({super.key, required this.newArrivalProducts});

  final FeaturedProducts newArrivalProducts;

  @override
  Widget build(BuildContext context) {
    final size = Utils.mediaQuery(context);
    return GestureDetector(
      onTap: () {
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
        width: double.infinity,
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
                  borderRadius:  BorderRadius.only(
                      topLeft: Radius.circular(10.0.r),
                      topRight: Radius.circular(10.0.r)),
                  child: CustomImage(
                    path: RemoteUrls.imageUrl(newArrivalProducts.image),
                    fit: BoxFit.cover,
                    height: size.height * 0.17.h,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0.r),
                        color: whiteColor,
                      ),
                      child: Padding(
                        padding: Utils.all(value: 6.0),
                        child: const Center(
                            child: CustomImage(path: KImages.loveIcon)),
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
                        text: Utils.formatPrice(context, newArrivalProducts.price),
                        fontSize: 16.sp,
                        color: redColor,
                        fontWeight: FontWeight.w700,
                      ),
                      Row(
                        children: [
                          const CustomImage(path: KImages.star),
                          Utils.horizontalSpace(6.0),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: newArrivalProducts.reviewsAvgRating,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                              ),
                              CustomText(
                                text: ' (${newArrivalProducts.reviewsCount})',
                                fontSize: 12.sp,
                                color: Colors.black.withOpacity(0.4),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Utils.verticalSpace(4.0),
                  CustomText(
                    text: newArrivalProducts.name,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                  Utils.verticalSpace(6.0),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomImage(path: KImages.rProfile, height: 20),
                          Utils.horizontalSpace(6.0),
                           CustomText(
                            text: 'Chef’s Place',
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          width: 4.w,
                          height: 4.h,
                          decoration: const BoxDecoration(
                              color: smallContainerColor,
                              shape: BoxShape.circle),
                        ),
                      ),
                      Row(
                        children: [
                          const CustomImage(path: KImages.location, height: 20),
                          Utils.horizontalSpace(6.0),
                           CustomText(
                            text: 'QS Jose,Spain',
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
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
