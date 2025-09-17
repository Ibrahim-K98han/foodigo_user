import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../../features/restaurant_features/RestaurantDashboard/model/res_dashboard_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';
import 'order_details_screen.dart';

class OrderCart extends StatelessWidget {
  const OrderCart({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.r)),
                  child: CustomText(text: 'text'));
            });
      },
      child: Container(
        height: 80.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Container(
            //   width: 80.0,
            //   height: 80.0,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10.0),
            //     shape: BoxShape.rectangle,
            //   ),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(4.r),
            //       bottomLeft: Radius.circular(4.r),
            //     ),
            //     child: CustomImage(
            //       path: RemoteUrls.imageUrl(recentOrders.grandTotal),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            Padding(
              padding: Utils.symmetric(h: 4.0, v: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CustomText(
                        text: "OrderId#",
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: textColor,
                      ),
                      const CustomText(
                        text: '  recentOrders.items!.first.productId',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: textColor,
                      ),
                      Utils.horizontalSpace(8.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: const Color(0xFFE8ECFD),
                        ),
                        child: Padding(
                          padding: Utils.symmetric(h: 8.0, v: 2.0),
                          child: const CustomText(
                            text: 'Delivery',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF1F7EFA),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Utils.verticalSpace(8.0),
                  Row(
                    children: [
                      const CustomText(
                        text: "09:10 AM",
                        color: textColor,
                        fontSize: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          height: 5,
                          width: 5,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: smallContainerColor),
                        ),
                      ),
                      const CustomText(
                        text: "21 Aug 2021",
                        color: textColor,
                        fontSize: 12,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: Utils.only(right: 8.0),
              child: const CustomText(
                text: "\$250",
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
