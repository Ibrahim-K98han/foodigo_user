// my_food_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/restaurant_features/Products/model/product_model.dart';
import 'package:foodigo/presentation/restaurant_screen/product_details/product_details_screen.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../../widget/title_and_navigator.dart';

class MyFood extends StatelessWidget {
  const MyFood({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final productList = productModel.productList ?? [];
    return Column(
      children: [
        TitleAndNavigator(
          title: 'My Food Menu',
          textColors: textColor,
          seeAllColors: subTitleTextColor,
          press: () {},
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: List.generate(productList.length, (index) {
              final product = productList[index];
              return Padding(
                padding: const EdgeInsets.only(right: 14),
                child: FoodCart(product: product),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class FoodCart extends StatelessWidget {
  const FoodCart({super.key, required this.product});

  final ProductList product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return const ProductDetailsScreen();
          },
        );
      },
      child: Container(
        height: 230.h,
        width: 240.w,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:  BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
              child: CustomImage(
                path: RemoteUrls.imageUrl(product.image!),
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: Utils.symmetric(v: 8.0, h: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: Utils.formatPrice(context, product.price ?? 0),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: redColor,
                  ),
                  Utils.verticalSpace(4.0),
                  CustomText(
                    text: product.name ?? 'Product Name',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    maxLine: 2,
                    color: textColor,
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
