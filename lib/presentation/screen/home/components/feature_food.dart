import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/HomeData/restaurant_model.dart';
import 'package:foodigo/presentation/screen/product_details/product_details_screen.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../../data/remote_url.dart';
import '../../../../features/HomeData/feature_product_model.dart';
import '../../../../features/WishList/cubit/wish_list_cubit.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/title_and_navigator.dart';
import '../../../core/routes/route_names.dart';

class FeatureFood extends StatelessWidget {
  const FeatureFood(
      {super.key, required this.featuredProducts, required this.restaurant});

  final List<FeaturedProducts> featuredProducts;
  final List<Restaurants> restaurant;

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
        // Utils.verticalSpace(16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              ...List.generate(featuredProducts.length, (index) {
                final featureProduct = featuredProducts[index];
                final res = restaurant[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: FeatureFoodCart(
                    featuredProducts: featureProduct,
                    restaurants: res,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        showDragHandle: true,
                        backgroundColor: whiteColor,
                        constraints: BoxConstraints.loose(
                          Size(
                            Utils
                                .mediaQuery(context)
                                .width,
                            Utils
                                .mediaQuery(context)
                                .height * 0.9,
                          ),
                        ),
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Utils.radius(10.0)),
                            topRight: Radius.circular(Utils.radius(10.0)),
                          ),
                        ),
                        builder: (context) =>
                            DraggableScrollableSheet(
                              initialChildSize: 0.85,
                              minChildSize: 0.5,
                              maxChildSize: 0.95,
                              expand: false,
                              builder: (context, scrollController) {
                                return SingleChildScrollView(
                                  controller: scrollController,
                                  child: ProductDetailsScreen(
                                    id: featureProduct.id,
                                  ),
                                );
                              },
                            ),
                      );
                    },
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

class FeatureFoodCart extends StatefulWidget {
  const FeatureFoodCart({super.key,
    required this.featuredProducts,
    this.onTap,
    required this.restaurants});

  final FeaturedProducts featuredProducts;
  final Restaurants restaurants;

  final VoidCallback? onTap;

  @override
  State<FeatureFoodCart> createState() => _FeatureFoodCartState();
}

class _FeatureFoodCartState extends State<FeatureFoodCart> {
  bool isFavorite = false;
  late WishListCubit wishList;

  @override
  void initState() {
    super.initState();
    wishList = context.read<WishListCubit>();
    isFavorite = wishList.wishListModel?.data?.wishlistItems
        ?.any((item) => item.product?.id == widget.featuredProducts.id) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: size.height * 0.34.h,
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
                    path: RemoteUrls.imageUrl(widget.featuredProducts.image),
                    fit: BoxFit.cover,
                    height: size.height * 0.17.h,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () async {
                      final productId = widget.featuredProducts.id;

                      if (isFavorite) {
                        // Remove from wishlist
                        final wishlistItem = wishList
                            .wishListModel?.data?.wishlistItems
                            ?.firstWhere(
                                (item) => item.product?.id == productId);
                        if (wishlistItem != null) {
                          await wishList
                              .removeFromWishList(wishlistItem.wishlistId);
                        }
                      } else {
                        // Add to wishlist
                        await wishList.addToWishList(productId);
                      }

                      await wishList.getWishList(); // Refresh the wishlist

                      setState(() {
                        isFavorite = !isFavorite; // Toggle favorite state
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: whiteColor,
                      ),
                      child: Padding(
                        padding: Utils.all(value: 6.0),
                        child: Center(
                          child: Icon(
                            isFavorite
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: isFavorite ? Colors.red : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: Utils.symmetric(v: 8.0.w, h: 10.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // Align children to the start
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // Add space between price and rating
                      children: [
                        CustomText(
                          text: '\$${widget.featuredProducts.price}',
                          fontSize: 16.sp,
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
                                  text:
                                  widget.featuredProducts.reviewsAvgRating,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                ),
                                CustomText(
                                  text:
                                  ' (${widget.featuredProducts.reviewsCount})',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
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
                      text: widget.featuredProducts.name,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: settingsIconBgColor,
                      height: 1.0.h,
                      maxLine: 2,
                    ),
                    Utils.verticalSpace(6.0),
                    Row(
                      children: [
                        CustomImage(
                          path: KImages.location,
                          height: 20.h,
                          color: blackColor.withOpacity(0.4),
                        ),
                        Utils.horizontalSpace(6.0),
                        CustomText(
                          text: widget.restaurants.address,
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: Colors.black.withOpacity(0.4),
                        ),
                      ],
                    ),
                    Utils.verticalSpace(6.0),
                    Row(
                      children: [
                         CustomImage(path: RemoteUrls.imageUrl(widget.restaurants.logo), height: 20),
                        Utils.horizontalSpace(6.0),
                        CustomText(
                          text: widget.restaurants.restaurantName,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
