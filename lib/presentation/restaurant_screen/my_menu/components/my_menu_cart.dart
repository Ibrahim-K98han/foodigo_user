import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/remote_url.dart';
import '../../../../features/restaurant_features/Products/model/product_model.dart';
import '../../../../features/restaurant_features/StoreProduct/cubit/store_product_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../core/routes/route_names.dart';

class MyMenuCart extends StatelessWidget {
  const MyMenuCart({super.key, required this.productList, required this.index});

  final ProductList productList;
  final int index;

  @override
  Widget build(BuildContext context) {
    final storeProduct = context.read<StoreProductCubit>();
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, RouteNames.productDetailsScreen);
        // showModalBottomSheet(
        //   context: context,
        //   showDragHandle: true,
        //   backgroundColor: whiteColor,
        //   constraints: BoxConstraints.loose(
        //     Size(
        //       Utils.mediaQuery(context).width,
        //       Utils.mediaQuery(context).height * 0.9,
        //     ),
        //   ),
        //   isScrollControlled: true,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //       topLeft: Radius.circular(Utils.radius(10.0)),
        //       topRight: Radius.circular(Utils.radius(10.0)),
        //     ),
        //   ),
        //   builder: (context) => DraggableScrollableSheet(
        //     initialChildSize: 0.85,
        //     minChildSize: 0.5,
        //     maxChildSize: 0.95,
        //     expand: false,
        //     builder: (context, scrollController) {
        //       return SingleChildScrollView(
        //         controller: scrollController,
        //         child: const ProductDetailsScreen(),
        //       );
        //     },
        //   ),
        // );
      },
      child: Container(
        //  height: 220.0,
        width: 240.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          color: whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Align children to the start
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r)),
                  child: CustomImage(
                    path: RemoteUrls.imageUrl(productList.image!),
                    fit: BoxFit.fill,
                    height: 110.h,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.editFoodScreen,
                            arguments: productList.id.toString(),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: whiteColor, shape: BoxShape.circle),
                          child: Padding(
                            padding: Utils.all(value: 4.0),
                            child: const Center(
                                child: CustomImage(
                              path: KImages.editIcon,
                              width: 16,
                              height: 16,
                              color: redColor,
                            )),
                          ),
                        ),
                      ),
                      Utils.horizontalSpace(4.w),
                      GestureDetector(
                        onTap: () {
                          storeProduct
                              .deleteStoreProduct(productList.id.toString());
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                              color: whiteColor, shape: BoxShape.circle),
                          child: Padding(
                            padding: Utils.all(value: 4.0),
                            child: const Center(
                                child: CustomImage(
                              path: KImages.deleteIcon,
                              width: 16,
                              height: 16,
                              color: redColor,
                            )),
                          ),
                        ),
                      )
                    ],
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
                        text: Utils.formatPrice(context, productList.price!),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: redColor,
                      ),
                      Row(
                        children: [
                          const CustomImage(path: KImages.star),
                          Utils.horizontalSpace(4.0),
                          CustomText(
                            text: productList.reviews!.isNotEmpty
                                ? productList.reviews!.first.rating.toString()
                                : "0.0",
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Utils.verticalSpace(4.0),
                  CustomText(
                    text: productList.name!,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    maxLine: 2,
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
