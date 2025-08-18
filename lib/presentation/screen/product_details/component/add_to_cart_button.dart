
import 'package:flutter/material.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({super.key});

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(v: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(
                Icons.remove,
              ),
              Utils.horizontalSpace(6.0),
              const CustomText(
                text: '2',
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              Utils.horizontalSpace(6.0),
              const Icon(Icons.add),
            ],
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: primaryColor),
              child: Padding(
                padding: Utils.symmetric(h: 45.0, v: 13.0),
                child: Row(
                  children: [
                    const CustomImage(
                      path: KImages.cart,
                      height: 25,
                    ),
                    Utils.horizontalSpace(6.0),
                    const CustomText(
                      text: 'Add to Cart',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
