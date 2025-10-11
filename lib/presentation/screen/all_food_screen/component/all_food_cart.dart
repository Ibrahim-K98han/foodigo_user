import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/AllFood/model/all_food_model.dart';

import '../../../../data/remote_url.dart';
import '../../../../features/WishList/cubit/wish_list_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../product_details/product_details_screen.dart';

class AllFoodCart extends StatefulWidget {
  const AllFoodCart({super.key, required this.foods});

  final Foods foods;

  @override
  State<AllFoodCart> createState() => _AllFoodCartState();
}

class _AllFoodCartState extends State<AllFoodCart> {
  bool isFavorite = false;
  late WishListCubit wishList;

  @override
  void initState() {
    super.initState();
    wishList = context.read<WishListCubit>();
    isFavorite =
        wishList.wishListModel?.data?.wishlistItems?.any(
          (item) => item.product?.id == widget.foods.id,
        ) ??
        false;
  }

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
          builder:
              (context) => DraggableScrollableSheet(
                initialChildSize: 0.85,
                minChildSize: 0.5,
                maxChildSize: 0.95,
                expand: false,
                builder: (context, scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: ProductDetailsScreen(id: widget.foods.id),
                  );
                },
              ),
        );
      },
      child: Container(
        height: size.height * 0.29.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Align children to the start
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0.r),
                    topRight: Radius.circular(10.0.r),
                  ),
                  child: CustomImage(
                    path: RemoteUrls.imageUrl(widget.foods.image),
                    fit: BoxFit.cover,
                    height: size.height * 0.17.h,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: GestureDetector(
                    onTap: () async {
                      final productId = widget.foods.id;

                      if (isFavorite) {
                        // Remove from wishlist
                        final wishlistItem = wishList
                            .wishListModel
                            ?.data
                            ?.wishlistItems
                            ?.firstWhere(
                              (item) => item.product?.id == productId,
                            );
                        if (wishlistItem != null) {
                          await wishList.removeFromWishList(
                            wishlistItem.wishlistId,
                          );
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
                        borderRadius: BorderRadius.circular(6.0.r),
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
                ),
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
                        text: Utils.formatPrice(
                          context,
                          widget.foods.offerPrice,
                        ),
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
                                text: widget.foods.reviewsAvgRating,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                              ),
                              CustomText(
                                text: ' (${widget.foods.reviewsCount})',
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
                    text: widget.foods.name,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                  Utils.verticalSpace(6.0),
                  // Row(
                  //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         CustomImage(
                  //             path: RemoteUrls.imageUrl(
                  //                 widget.foods.restaurants.logo),
                  //             height: 20),
                  //         Utils.horizontalSpace(6.0),
                  //         CustomText(
                  //           text: widget.foods.restaurants.name,
                  //           fontWeight: FontWeight.w500,
                  //           fontSize: 12.sp,
                  //         ),
                  //       ],
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 5),
                  //       child: Container(
                  //         width: 4.w,
                  //         height: 4.h,
                  //         decoration: const BoxDecoration(
                  //             color: smallContainerColor,
                  //             shape: BoxShape.circle),
                  //       ),
                  //     ),
                  //     Row(
                  //       children: [
                  //         const CustomImage(path: KImages.location, height: 20),
                  //         Utils.horizontalSpace(6.0),
                  //         CustomText(
                  //           text: widget.foods.restaurants[index].address,
                  //           fontWeight: FontWeight.w400,
                  //           fontSize: 12.sp,
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
