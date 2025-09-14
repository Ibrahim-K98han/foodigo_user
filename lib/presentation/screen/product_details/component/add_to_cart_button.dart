import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton(
      {super.key,
      this.incrementBtn,
      this.decrementBtn,
      this.addToCartBtn,
      this.text, this.btnName});

  final VoidCallback? incrementBtn;
  final VoidCallback? decrementBtn;
  final VoidCallback? addToCartBtn;
  final String? text;
  final String? btnName;

  @override
  State<AddToCartButton> createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(h: 0.0, v: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: widget.decrementBtn,
                child: const Icon(
                  Icons.remove,
                  size: 30,
                ),
              ),
              Utils.horizontalSpace(8.0),
              CustomText(
                text: widget.text ?? '',
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              Utils.horizontalSpace(8.0),
              GestureDetector(
                  onTap: widget.incrementBtn,
                  child: const Icon(
                    Icons.add,
                    size: 30,
                  )),
            ],
          ),
          GestureDetector(
            onTap: widget.addToCartBtn,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0.r),
                  color: primaryColor),
              child: Padding(
                padding: Utils.symmetric(h: 40.0, v: 13.0),
                child: Row(
                  children: [
                    const CustomImage(
                      path: KImages.cart,
                      height: 25,
                    ),
                    Utils.horizontalSpace(6.0),
                    CustomText(
                      text: widget.btnName!,
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
