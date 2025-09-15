import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';

class BestSellingProduct extends StatelessWidget {
  const BestSellingProduct({super.key});

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
      child: ListView.builder(
          itemCount: 20,
          shrinkWrap: true,
          padding: Utils.all(),
          //  physics: BouncingScrollPhysics(),
          itemBuilder: (context, int index) {
            return Padding(
              padding: Utils.symmetric(h: 16.0, v: 6.0),
              child: const ProductCard(),
            );
          }),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              Container(
                width: 124.w,
                height: 86.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  shape: BoxShape.rectangle,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(3.0),
                    child: const CustomImage(
                      path: KImages.foodImage1,
                      fit: BoxFit.cover,
                    )),
              ),
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
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
                  const Flexible(
                    child: CustomText(
                      text: 'Chicken Shawarma Special Thai Fried and ',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      maxLine: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: '\$35.0',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE94222),
                      ),
                      GestureDetector(
                        onTap: () {},
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
                                )),
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