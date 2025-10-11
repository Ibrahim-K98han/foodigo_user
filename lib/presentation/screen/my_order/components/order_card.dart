import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/Order/cubit/order_cubit.dart';
import 'package:foodigo/features/Order/model/order_model.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/loading_widget.dart';

import '../../../../features/Order/cubit/order_state.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class OrderCard extends StatelessWidget {
  OrderCard({super.key, required this.orderModel});

  final OrderModel orderModel;

  final Map<String, String> orderStatusMap = {
    '1': "Pending",
    '2': "Confirmed",
    '3': "Processing",
    '4': "On the Way",
    '5': "Delivered",
    '6': "Canceled",
  };

  final Map<String, Color> statusColorMap = {
    '1': Colors.green,
    '2': Colors.orange,
    '3': Colors.blue,
    '4': Colors.red,
    '5': Colors.purple,
    '6': Colors.brown,
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    context.read<OrderCubit>();
    return Container(
      padding: Utils.symmetric(h: 10.0, v: 6.0),
      height:
          orderStatusMap[orderModel.orderStatus] == 'Pending'
              ? size.height / 8.1.h
              : size.height / 8.1.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.r),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: CustomImage(
                  path: RemoteUrls.imageUrl(orderModel.restaurant!.logo!),
                  width: 92.w,
                  height: 72.h,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: Utils.only(left: 10.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.54,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: Utils.formatPrice(
                              context,
                              orderModel.grandTotal,
                            ),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFE94222),
                          ),
                          GestureDetector(
                            onTap: () {
                              context.read<OrderCubit>().getOrderDetails(
                                orderModel.id,
                              );
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return ShowOrderDetailsDialog(
                                    orderModel: orderModel,
                                  );
                                },
                              );
                            },
                            child: const Icon(
                              Icons.visibility,
                              color: greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CustomText(
                      text: orderModel.restaurant!.restaurantName!,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      maxLine: 2,
                    ),
                    Utils.verticalSpace(6),
                    Row(
                      children: [
                        CustomText(text: "Order ID: #${orderModel.id}"),
                        Utils.horizontalSpace(20.0),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: statusColorMap[orderModel.orderStatus]
                                ?.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: CustomText(
                            text:
                                orderStatusMap[orderModel.orderStatus] ??
                                'Unknown',
                            color:
                                statusColorMap[orderModel.orderStatus] ??
                                Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // orderStatusMap[orderModel.orderStatus] == 'Pending'
          //     ? GestureDetector(
          //         onTap: () {
          //           Navigator.pushNamed(context, RouteNames.smsScreen);
          //         },
          //         child: Padding(
          //           padding: Utils.only(top: 20.h),
          //           child: Container(
          //             padding: Utils.symmetric(v: 8.w),
          //             decoration: BoxDecoration(
          //                 color: blackColor,
          //                 borderRadius: BorderRadius.circular(6.r)),
          //             child: Row(
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 CustomImage(
          //                   path: KImages.message,
          //                   width: 16.w,
          //                   height: 16.h,
          //                 ),
          //                 Utils.horizontalSpace(4),
          //                 const CustomText(
          //                   text: 'Message',
          //                   color: whiteColor,
          //                   fontSize: 14,
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //       )
          //     : const SizedBox()
        ],
      ),
    );
  }
}

class ShowOrderDetailsDialog extends StatefulWidget {
  const ShowOrderDetailsDialog({super.key, required this.orderModel});

  final OrderModel orderModel;

  @override
  State<ShowOrderDetailsDialog> createState() => _ShowOrderDetailsDialogState();
}

class _ShowOrderDetailsDialogState extends State<ShowOrderDetailsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      elevation: 5,
      backgroundColor: Colors.white,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
          minHeight: 100.h,
        ),
        child: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderDetailsStateLoading) {
              return const Center(child: LoadingWidget());
            } else if (state is OrderDetailsStateError) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Text("Error: ${state.message}"),
              );
            } else if (state is OrderDetailsStateSuccess) {
              final orderDetails = state.orderDetails;

              if (orderDetails.items == null || orderDetails.items!.isEmpty) {
                return const Center(
                  child: CustomText(
                    text: "No product available",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.all(10.r),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Utils.verticalSpace(10),
                    const CustomText(
                      text: 'Order Details',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    Divider(color: greyColor.withOpacity(0.2)),
                    Utils.verticalSpace(10),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: orderDetails.items?.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = orderDetails.items![index];
                          final product = item.products;

                          if (product == null) {
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 5.h),
                              child: const ListTile(
                                leading: Icon(Icons.error, color: Colors.red),
                                title: CustomText(
                                  text: "Product not available",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }

                          // ✅ safely decode size
                          Map<String, dynamic> sizeMap = {};
                          String sizeName = "";
                          dynamic sizePrice;

                          // ✅ safely decode addon
                          Map<String, dynamic> addonMap = {};
                          String addonName = "";
                          dynamic addonPrice;

                          try {
                            final decoded = jsonDecode(item.size);
                            if (decoded is Map<String, dynamic>) {
                              sizeMap = decoded;
                              sizeName = sizeMap.keys.first;
                              sizePrice = sizeMap.values.first;
                            }
                          } catch (_) {}

                          try {
                            final decoded = jsonDecode(item.addons);
                            if (decoded is Map<String, dynamic>) {
                              addonMap = decoded;
                              addonName = addonMap.keys.first;
                              addonPrice = addonMap.values.first;
                            }
                          } catch (_) {}

                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 6.h),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: greyColor.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),

                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(6.r),
                                    child: CustomImage(
                                      path: RemoteUrls.imageUrl(product.image),
                                      width: 80.w,
                                      height: 70.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: product.name,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        if (sizeName.isNotEmpty)
                                          CustomText(text: "Size: $sizeName"),
                                        if (sizePrice != null)
                                          CustomText(text: "Price: $sizePrice"),
                                        CustomText(
                                          text: "Quantity: ${item.qty}",
                                        ),

                                        if (addonName.isNotEmpty ||
                                            addonPrice != null)
                                          CustomText(
                                            text:
                                                "Addon: $addonName${addonPrice != null ? ' (\$$addonPrice)' : ''}",
                                          ),

                                        CustomText(
                                          text:
                                              "Delivery Charge: ${widget.orderModel.deliveryCharge}",
                                        ),
                                        CustomText(
                                          text: "Vat: ${widget.orderModel.vat}",
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const CustomText(
                          text: 'Close',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
