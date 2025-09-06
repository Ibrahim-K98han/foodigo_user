import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/WishList/cubit/wish_list_cubit.dart';
import 'package:foodigo/features/WishList/cubit/wish_list_state.dart';
import 'package:foodigo/features/WishList/model/wish_list_model.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/page_refresh.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/fetch_error_text.dart';
import '../../../../widget/loading_widget.dart';
import '../../product_details/product_details_screen.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  late WishListCubit wishListCubit;

  @override
  void initState() {
    super.initState();
    wishListCubit = context.read<WishListCubit>();
    wishListCubit.getWishList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: 'Wishlist'),
        body: PageRefresh(
          onRefresh: () async {
            wishListCubit.getWishList();
          },
          child: BlocConsumer<WishListCubit, WishListState>(
            listener: (context, state) {
              final wishList = state;
              if (wishList is WishListError) {
                if (wishList.statusCode == 503) {
                  FetchErrorText(text: wishList.message);
                }
              }
            },
            builder: (context, state) {
              final wishList = state;
              if (wishList is WishListLoading) {
                return const LoadingWidget();
              } else if (wishList is WishListError) {
                if (wishList.statusCode == 503 ||
                    wishListCubit.wishListModel != null) {
                  return LoadWishListData(
                    wishListModel: wishListCubit.wishListModel!,
                  );
                } else {
                  return FetchErrorText(text: wishList.message);
                }
              } else if (wishList is WishListLoaded) {
                return LoadWishListData(
                  wishListModel: wishListCubit.wishListModel!,
                );
              }
              if (wishListCubit.wishListModel != null) {
                return LoadWishListData(
                  wishListModel: wishListCubit.wishListModel!,
                );
              } else {
                return const FetchErrorText(text: 'Something Went Wrong');
              }
            },
          ),
        ));
  }
}

class LoadWishListData extends StatelessWidget {
  const LoadWishListData({super.key, required this.wishListModel});

  final WishListModel wishListModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 40,
            offset: Offset(0, 2),
            spreadRadius: 10,
          )
        ],
      ),
      child: Padding(
        padding: Utils.symmetric(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(wishListModel.data!.wishlistItems!.length,
                  (index) {
                return Padding(
                  padding: Utils.only(bottom: 12.0),
                  child: WishCard(
                    wishlistItem: wishListModel.data!.wishlistItems![index],
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

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
