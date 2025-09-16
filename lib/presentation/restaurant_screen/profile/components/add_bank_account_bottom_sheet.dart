import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../../utils/constraints.dart';

class AddBankAccountBottomSheet extends StatelessWidget {
  const AddBankAccountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(h: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Credit & Debit Card',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          Container(
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(6.r)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CustomImage(path: KImages.message),
                    Utils.horizontalSpace(4),
                    const CustomText(text: 'Add New Card')
                  ],
                ),
                const CustomText(
                  text: 'Link',
                  color: redColor,
                )
              ],
            ),
          ),
          Utils.verticalSpace(20),
          const CustomText(
            text: 'Confirm',
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.maxFinite,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CustomImage(path: KImages.paypal),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Container(
                            width: 20.w,
                            height: 20.h,
                            decoration: const BoxDecoration(
                                color: greenColor, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.check,
                              color: whiteColor,
                              size: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
