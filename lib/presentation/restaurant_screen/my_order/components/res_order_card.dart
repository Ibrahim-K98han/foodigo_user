import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../features/restaurant_features/Order/model/res_order_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';
import 'order_details_screen.dart';

class ResOrderCard extends StatelessWidget {
  const ResOrderCard({super.key, required this.order});

  final ResOrderModel order;

  String getOrderStatusText(dynamic status) {
    switch (status.toString()) {
      case '1':
        return 'Pending';
      case '2':
        return 'Confirmed';
      case '3':
        return 'Processing';
      case '4':
        return 'On The Way';
      case '5':
        return 'Delivered';
      case '6':
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  Color getOrderStatusColor(dynamic status) {
    switch (status.toString()) {
      case '1':
        return const Color(0xFF1F7EFA);
      case '2':
        return Colors.orange;
      case '3':
        return Colors.blueGrey;
      case '4':
        return Colors.purple;
      case '5':
        return Colors.green;
      case '6':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getOrderStatusBgColor(dynamic status) {
    switch (status.toString()) {
      case '1':
        return const Color(0xFF1F7EFA).withOpacity(0.2);
      case '2':
        return Colors.orange.withOpacity(0.2);
      case '3':
        return Colors.blueGrey.withOpacity(0.2);
      case '4':
        return Colors.purple.withOpacity(0.2);
      case '5':
        return Colors.green.withOpacity(0.2);
      case '6':
        return Colors.red.withOpacity(0.2);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              insetPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r)),
              child: OrderDetailsDialog(
                orderId: order.id.toString(),
              ),
            );
          },
        );
      },
      child: Container(
        height: 65.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: whiteColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: Utils.symmetric(h: 4.0, v: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CustomText(
                        text: "OrderId# ",
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: textColor,
                      ),
                      CustomText(
                        text: '${order.id}',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: textColor,
                      ),
                      Utils.horizontalSpace(8.0),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: getOrderStatusBgColor(order.orderStatus),
                        ),
                        child: Padding(
                          padding: Utils.symmetric(h: 8.0, v: 2.0),
                          child: CustomText(
                            text: getOrderStatusText(order.orderStatus),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: getOrderStatusColor(order.orderStatus),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Utils.verticalSpace(8.0),
                  Row(
                    children: [
                      CustomText(
                        text: DateFormat('hh:mm a')
                            .format(order.createdAt ?? DateTime.now()),
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
                      CustomText(
                        text: Utils.formatDate(order.createdAt),
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
              child: CustomText(
                text: Utils.formatPrice(context, order.grandTotal),
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
