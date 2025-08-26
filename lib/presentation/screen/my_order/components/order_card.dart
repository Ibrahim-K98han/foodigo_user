import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    this.status = 'Active',
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: Utils.symmetric(h: 10.0, v: 6.0),
      height: size.height * 0.18,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0), color: whiteColor),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 92.0,
                height: 72.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  shape: BoxShape.rectangle,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: const CustomImage(
                      path: KImages.foodImage1,
                      fit: BoxFit.cover,
                    )),
              ),
              Flexible(
                child: Padding(
                  padding: Utils.only(left: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: '\$35.0',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE94222),
                      ),
                      const Flexible(
                        child: CustomText(
                          text: 'Chicken Shawarma Special Thai Fried and ',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          maxLine: 1,
                        ),
                      ),
                      Utils.verticalSpace(6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomText(
                            text: 'Order ID: #123456789',
                            fontSize: 13,
                            color: Color(0xFF6C727F),
                          ),
                          Container(
                            padding: Utils.symmetric(h: 12.0, v: 3.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8ECFD),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: const Center(
                              child: CustomText(
                                text: 'Active',
                                color: Color(0xff1F7EFA),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Utils.verticalSpace(8),
          status == 'Active'
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    minimumSize: Size(double.maxFinite, 38.h),
                    backgroundColor: textColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.smsScreen);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImage(
                        path: KImages.message,
                        height: 18.h,
                        width: 18.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 8.w),
                      const CustomText(
                        text: 'Message',
                        color: whiteColor,
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
