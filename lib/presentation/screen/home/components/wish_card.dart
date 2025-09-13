import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/remote_url.dart';
import '../../../../features/WishList/cubit/wish_list_cubit.dart';
import '../../../../features/WishList/model/wish_list_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../product_details/product_details_screen.dart';

class WishCard extends StatelessWidget {
  const WishCard({
    super.key,
    required this.wishlistItem,
  });

  final WishlistItems wishlistItem;

  @override
  Widget build(BuildContext context) {
    final product = wishlistItem.product;

    String sizeText = "";
    if (product?.size != null && product!.size.isNotEmpty) {
      try {
        final sizeMap = Map<String, dynamic>.from(json.decode(product.size));
        if (sizeMap.isNotEmpty) {
          final firstEntry = sizeMap.entries.first;
          sizeText = " \$${firstEntry.value}";
        }
      } catch (e) {
        sizeText = "";
      }
    }

    return Container(
      padding: Utils.symmetric(h: 0.0, v: 0.0),
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0), color: whiteColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              // Product image
              Container(
                width: 124.w,
                height: 86.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: CustomImage(
                    path: RemoteUrls.imageUrl(product!.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Remove from wishlist icon
              Positioned(
                top: 4,
                left: 4,
                child: GestureDetector(
                  onTap: () async {
                    final cubit = context.read<WishListCubit>();
                    await cubit.removeFromWishList(wishlistItem.wishlistId);
                    await cubit.getWishList(); // Refresh the list
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: whiteColor,
                    ),
                    child: Padding(
                      padding: Utils.all(value: 4.0),
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.red, // Always red since it's in wishlist
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),

          // Product info
          Flexible(
            child: Padding(
              padding: Utils.only(left: 8.0, top: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: CustomText(
                      text: product.name,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      maxLine: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: sizeText.isNotEmpty ? sizeText : 'No Size Info',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFE94222),
                      ),
                      // Add to Cart button
                      GestureDetector(
                        onTap: () async {
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
                                  child: ProductDetailsScreen(
                                    id: product.id,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: borderColor),
                            ),
                            child: Padding(
                              padding: Utils.symmetric(h: 10.0, v: 6.0),
                              child: const Center(
                                child: CustomText(
                                  text: 'Add to Cart',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
