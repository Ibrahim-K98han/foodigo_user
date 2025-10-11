import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/RestaurantDashboard/model/res_dashboard_model.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:intl/intl.dart';

class RecentOrderCard extends StatefulWidget {
  const RecentOrderCard({super.key, required this.item});

  final RecentOrder item;

  @override
  State<RecentOrderCard> createState() => _RecentOrderCardState();
}

class _RecentOrderCardState extends State<RecentOrderCard> {
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
      case '1': // Pending
        return const Color(0xFF1F7EFA);
      case '2': // Confirmed
        return Colors.orange;
      case '3': // Preparing
        return Colors.blueGrey;
      case '4': // Out for Delivery
        return Colors.purple;
      case '5': // Completed
        return Colors.green;
      case '6': // Cancelled
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color getOrderStatusBgColor(dynamic status) {
    switch (status.toString()) {
      case '1': // Pending
        return const Color(0xFF1F7EFA).withOpacity(0.2);
      case '2': // Confirmed
        return Colors.orange.withOpacity(0.2);
      case '3': // Preparing
        return Colors.blueGrey.withOpacity(0.2);
      case '4': // Out for Delivery
        return Colors.purple.withOpacity(0.2);
      case '5': // Completed
        return Colors.green.withOpacity(0.2);
      case '6': // Cancelled
        return Colors.red.withOpacity(0.2);
      default:
        return Colors.grey.withOpacity(0.2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
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
                      text: '${widget.item.id}',
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: textColor,
                    ),
                    Utils.horizontalSpace(8.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: getOrderStatusBgColor(widget.item.orderStatus),
                      ),
                      child: Padding(
                        padding: Utils.symmetric(h: 8.0, v: 2.0),
                        child: CustomText(
                          text: getOrderStatusText(widget.item.orderStatus),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: getOrderStatusColor(widget.item.orderStatus),
                        ),
                      ),
                    ),
                  ],
                ),
                Utils.verticalSpace(8.0),
                Row(
                  children: [
                    CustomText(
                      text: DateFormat('hh:mm a').format(widget.item.createdAt),
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
                          color: smallContainerColor,
                        ),
                      ),
                    ),
                    CustomText(
                      text: Utils.formatDate(widget.item.createdAt),
                      color: textColor,
                      fontSize: 12,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: Utils.only(right: 8.0),
            child: CustomText(
              text: Utils.formatPrice(context, widget.item.grandTotal),
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
