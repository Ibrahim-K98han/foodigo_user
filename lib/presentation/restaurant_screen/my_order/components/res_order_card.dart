import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/OrderStatus/cubit/order_status_cubit.dart';
import 'package:intl/intl.dart';

import '../../../../features/restaurant_features/Order/model/res_order_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';
import 'order_details_screen.dart';

class ResOrderCard extends StatefulWidget {
  const ResOrderCard({
    super.key,
    required this.order,
  });

  final ResOrderModel order;

  @override
  State<ResOrderCard> createState() => _ResOrderCardState();
}

class _ResOrderCardState extends State<ResOrderCard> {
  String? selectedStatus;
  late OrderStatusCubit orderStatusCubit;

  final List<String> statusList = [
    'Pending',
    'Confirmed',
    'Processing',
    'On The Way',
    'Delivered',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    orderStatusCubit = context.read<OrderStatusCubit>();
    selectedStatus = getOrderStatusText(widget.order.orderStatus);
  }

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

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: OrderDetailsDialog(orderId: order.id.toString()),
            );
          },
        );
      },
      child: Container(
        height: 90.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: whiteColor,
        ),
        child: Padding(
          padding: Utils.symmetric(h: 8.0, v: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Left Side
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                      Utils.horizontalSpace(4.0),
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
                  Utils.verticalSpace(6.0),
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
                            color: smallContainerColor,
                          ),
                        ),
                      ),
                      CustomText(
                        text: Utils.formatDate(order.createdAt),
                        color: textColor,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ],
              ),

              /// Right Side
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: Utils.formatPrice(context, order.grandTotal),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  Utils.verticalSpace(8.0),
                  SizedBox(
                    height: 35.h,
                    width: 110.w,
                    child: DropdownButtonFormField<String>(
                      value: selectedStatus,
                      decoration: InputDecoration(
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 6,
                        ),
                      ),
                      items: statusList.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 13),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedStatus = value;
                          });

                          String statusId =
                          (statusList.indexOf(value) + 1).toString();

                          // Update the status in cubit with the status text
                          orderStatusCubit.changeStatus(value);

                          // Call API to change order status
                          orderStatusCubit.changeOrderStatus(
                            order.id.toString(),
                            statusId,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}