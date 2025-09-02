import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/Order/model/order_model.dart';
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
    required this.orderModel,
  });

  final OrderModel orderModel;

  String _mapStatus(String status) {
    switch (status) {
      case '1':
        return "Pending";
      case '2':
        return "Confirmed";
      case '3':
        return "Processing";
      case '4':
        return "On the way";
        case '5':
        return "Delivered";
        case '6':
        return "Cancelled";
      default:
        return "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: Utils.symmetric(h: 10.0, v: 6.0),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: whiteColor,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🖼️ প্রথম product এর image
              Container(
                width: 92.0,
                height: 72.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  shape: BoxShape.rectangle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: CustomImage(
                    path: KImages.foodImage1,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Flexible(
                child: Padding(
                  padding: Utils.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 💰 Order Total
                      CustomText(
                        text: "৳ ${orderModel.total.toString()}",
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFE94222),
                      ),
                      Flexible(
                        child: CustomText(
                          text: orderModel.items![0].total,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          maxLine: 1,
                        ),
                      ),
                      Utils.verticalSpace(6),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 🆔 Order ID
                          CustomText(
                            text: "Order ID: #${orderModel.id}",
                            fontSize: 13,
                            color: const Color(0xFF6C727F),
                          ),

                          // 📌 Status Badge
                          Container(
                            padding: Utils.symmetric(h: 12.0, v: 3.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8ECFD),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Center(
                              child: CustomText(
                                text: _mapStatus(orderModel.orderStatus),
                                color: const Color(0xff1F7EFA),
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

          orderModel.orderStatus == '1'
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
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
