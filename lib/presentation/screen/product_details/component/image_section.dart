import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../features/HomeData/feature_product_model.dart';
import '../../../../features/WishList/cubit/wish_list_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';

class ImageSection extends StatefulWidget {
  final String image;
  final FeaturedProducts featuredProducts;

  const ImageSection(
      {super.key, required this.image, required this.featuredProducts});

  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
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
    return Stack(
      children: [
        CustomImage(
          path: widget.image,
          fit: BoxFit.cover,
          height: 260,
          width: double.infinity,
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () async {
              final productId = widget.featuredProducts.id;

              if (isFavorite) {
                // Remove from wishlist
                final wishlistItem = wishList.wishListModel?.data?.wishlistItems
                    ?.firstWhere((item) => item.product?.id == productId);
                if (wishlistItem != null) {
                  await wishList.removeFromWishList(wishlistItem.wishlistId);
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
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.transparent,
              ),
              child: Padding(
                padding: Utils.all(value: 6.0),
                child: Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(6.r)),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
