import 'package:dartz/dartz.dart' as featureProduct;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';

import '../../../../features/SingleRestaurant/model/single_restaurant_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../product_details/product_details_screen.dart';

class BestSellingProduct extends StatelessWidget {
  BestSellingProduct({super.key, required this.products});

  final List<Products> products;

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
      child: products.isEmpty
          ? const CustomImage(path: KImages.notFound)
          : ListView.builder(
              itemCount: products.length,
              shrinkWrap: true,
              padding: Utils.all(),
              itemBuilder: (context, int index) {
                final product = products[index];
                return Padding(
                  padding: Utils.symmetric(h: 16.0, v: 6.0),
                  child: ProductCard(
                    product: product,
                  ),
                );
              }),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final Products product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Utils.symmetric(h: 0.0, v: 0.0),
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0.r), color: whiteColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 124.w,
                height: 86.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0.r),
                  shape: BoxShape.rectangle,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(3.0.r),
                    child: CustomImage(
                      path: RemoteUrls.imageUrl(product.image),
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                top: 4.h,
                left: 4.w,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0.r),
                    color: whiteColor,
                  ),
                  child: Padding(
                    padding: Utils.all(value: 4.0),
                    child: const Center(
                        child: CustomImage(path: KImages.loveIcon)),
                  ),
                ),
              )
            ],
          ),
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
                        text: Utils.formatPrice(context, product.price),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFE94222),
                      ),
                      GestureDetector(
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
                                  child: ProductDetailsScreen(
                                    id: product.id,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Padding(
                          padding: Utils.only(right: 6),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0.r),
                              border: Border.all(color: borderColor),
                            ),
                            child: Padding(
                              padding: Utils.symmetric(h: 10.0.h, v: 6.0.w),
                              child: const Center(
                                child: CustomText(
                                  text: 'Add to Cart',
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
