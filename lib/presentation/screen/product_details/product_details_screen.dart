import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import 'component/add_to_cart_button.dart';
import 'component/amount_name_rating_section.dart';
import 'component/image_section.dart';
import 'component/select_addon_section.dart';
import 'component/select_size_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///=================== Product Details ====================///
        const ImageSection(),
        Padding(
          padding: Utils.symmetric(v: 10.0),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///================ Product Amount Name And Rating ===========///
              AmountNameRatingSection(),

              ///================ Select Product Size Dropdown ==============///
              SelectSizeSection(),

              ///=============== Select Addon Dropdown ======================///
              SelectAddonSection(),

              ///=============== Add To Cart Button ========================///
              AddToCartButton(),
            ],
          ),
        ),
      ],
    );
  }
}
