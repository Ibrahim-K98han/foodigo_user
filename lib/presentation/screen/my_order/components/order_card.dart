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
    final orderDetails = context.read<OrderCubit>();
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
                      width: size.width * 0.5.w,
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
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    elevation: 5,
                                    backgroundColor: Colors.white,
                                    child: SizedBox(
                                      height: 400.h,
                                      child: BlocBuilder<
                                        OrderCubit,
                                        OrderState
                                      >(
                                        builder: (context, state) {
                                          if (state
                                              is OrderDetailsStateLoading) {
                                            return const Center(
                                              child: LoadingWidget(),
                                            );
                                          } else if (state
                                              is OrderDetailsStateError) {
                                            return Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Text(
                                                "Error: ${state.message}",
                                              ),
                                            );
                                          } else if (state
                                              is OrderDetailsStateSuccess) {
                                            final orderDetails =
                                                state.orderDetails;
                                            return Padding(
                                              padding: EdgeInsets.all(10.r),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Expanded(
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount:
                                                          orderDetails
                                                              .items
                                                              ?.length ??
                                                          0,
                                                      itemBuilder: (
                                                        context,
                                                        index,
                                                      ) {
                                                        final item =
                                                            orderDetails
                                                                .items![index];
                                                        final product =
                                                            item.products!;
                                                        final sizeMap =
                                                            jsonDecode(
                                                                  item.size,
                                                                )
                                                                as Map<
                                                                  String,
                                                                  dynamic
                                                                >;
                                                        final sizeName =
                                                            sizeMap.keys.first;
                                                        final sizePrice =
                                                            sizeMap
                                                                .values
                                                                .first;

                                                        final decodedAddons =
                                                            jsonDecode(
                                                              item.addons,
                                                            );

                                                        Map<String, dynamic>
                                                        addonMap = {};
                                                        if (decodedAddons
                                                            is Map<
                                                              String,
                                                              dynamic
                                                            >) {
                                                          addonMap =
                                                              decodedAddons;
                                                        } else if (decodedAddons
                                                            is List) {
                                                          addonMap = {
                                                            for (var e
                                                                in decodedAddons)
                                                              e.toString(): 1,
                                                          };
                                                        }

                                                        return Card(
                                                          margin:
                                                              EdgeInsets.symmetric(
                                                                vertical: 5.h,
                                                              ),
                                                          child: ListTile(
                                                            leading: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    6.r,
                                                                  ),
                                                              child: CustomImage(
                                                                path:
                                                                    RemoteUrls.imageUrl(
                                                                      product
                                                                          .image,
                                                                    ),
                                                                width: 50.w,
                                                                height: 50.h,
                                                                fit:
                                                                    BoxFit
                                                                        .cover,
                                                              ),
                                                            ),
                                                            title: CustomText(
                                                              text:
                                                                  product.name,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                            subtitle: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                CustomText(
                                                                  text:
                                                                      "Size: $sizeName",
                                                                ),
                                                                CustomText(
                                                                  text:
                                                                      "Price: $sizePrice",
                                                                ),
                                                                CustomText(
                                                                  text:
                                                                      "Quantity: ${item.qty}",
                                                                ),
                                                                CustomText(
                                                                  text:
                                                                      "Delivery Charge: ${orderModel.deliveryCharge}",
                                                                ),
                                                                CustomText(
                                                                  text:
                                                                      "Vat: ${orderModel.vat}",
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(
                                                            context,
                                                          ).pop();
                                                        },
                                                        child: const CustomText(
                                                          text: 'Close',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
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
