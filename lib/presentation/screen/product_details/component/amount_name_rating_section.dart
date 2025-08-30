import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/ProductDetails/cubit/product_details_cubit.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';

class AmountNameRatingSection extends StatefulWidget {
  const AmountNameRatingSection({super.key});

  @override
  State<AmountNameRatingSection> createState() =>
      _AmountNameRatingSectionState();
}

class _AmountNameRatingSectionState extends State<AmountNameRatingSection> {
  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<ProductDetailsCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: Utils.formatPrice(
                  context, detailsCubit.featuredProducts!.price),
              fontSize: 18,
              color: redColor,
              fontWeight: FontWeight.bold,
            ),
            Row(
              children: [
                const CustomImage(path: KImages.star),
                Utils.horizontalSpace(6.0),
                Row(
                  children: [
                    CustomText(
                      text: detailsCubit.featuredProducts!.reviewsAvgRating,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                    CustomText(
                      text:
                          ' (${detailsCubit.featuredProducts!.reviewsCount}+)',
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
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
          text: detailsCubit.featuredProducts!.name,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          maxLine: 1,
        ),
        Utils.verticalSpace(6.0),
        CustomText(
          text: detailsCubit.featuredProducts!.shortDescription,
          color: Color(0xFF475569),
        ),
        Utils.verticalSpace(10.0),
      ],
    );
  }
}
