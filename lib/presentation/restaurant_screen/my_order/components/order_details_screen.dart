import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../features/restaurant_features/Order/cubit/res_order_cubit.dart';
import '../../../../features/restaurant_features/Order/cubit/res_order_state.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class OrderDetailsDialog extends StatefulWidget {
  final String orderId;

  const OrderDetailsDialog({super.key, required this.orderId});

  @override
  State<OrderDetailsDialog> createState() => _OrderDetailsDialogState();
}

class _OrderDetailsDialogState extends State<OrderDetailsDialog> {
  late ResOrderCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ResOrderCubit>();
    cubit.getOrderDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResOrderCubit, ResOrderState>(
      builder: (context, state) {
        if (state is ResOrderLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ResOrderDetailsLoaded) {
          final order = state.resOrderModel;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: order.restaurant.restaurantName,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),

                    /// Close Button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, color: redColor),
                    ),
                  ],
                ),
                Utils.verticalSpace(10),

                /// Address
                CustomText(
                  text: order.restaurant.address ?? "",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
                Info(title: "Email: ", subTitle: order.restaurant.email),
                Info(title: "Phone: ", subTitle: order.restaurant.ownerPhone),
                Divider(color: Colors.black.withOpacity(0.1)),

                /// Example Food Info
                Info(
                  title: "Order ID",
                  subTitle: "#${order.id}",
                  colors: redColor,
                ),
                Info(
                  title: "Delivery Type",
                  subTitle: order.paymentMethod ?? "",
                ),
                Info(
                  title: "Created",
                  subTitle: Utils.formatDate(order.createdAt),
                ),

                Divider(color: Colors.black.withOpacity(0.1)),

                /// Customer Info
                const CustomText(
                  text: "Customer Info",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                Info(title: "Name", subTitle: order.user?.name ?? ""),
                Info(title: "Location", subTitle: order.user?.address ?? ""),

                Info(title: "Phone", subTitle: order.user?.phone ?? ""),
                Info(title: "Email", subTitle: order.user?.email ?? ""),

                Divider(color: Colors.black.withOpacity(0.1)),

                /// Customer Info
                const CustomText(
                  text: "Order Info",
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: order.items!.length,
                  itemBuilder: (context, index) {
                    final item = order.items![index];


                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: item.product?.name ?? '',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        Info(title: "Quantity", subTitle: item.qty),
                        Info(
                          title: "Variation",
                          subTitle: item.size.entries
                              .map((e) => e.key)
                              .join(", "),
                        ),

                        Info(
                          title: "Addons",
                          subTitle: item.detailsAddons
                              ?.map((addon) => '${addon.name} (\$${addon.price})')
                              .join(", ") ?? "None",
                        ),
                        Info(
                          title: "Price",
                          subTitle: item.size.entries
                              .map((e) => Utils.formatPrice(context, e.value))
                              .join(", "),
                        ),
                      ],
                    );
                  },
                ),

                Divider(color: Colors.black.withOpacity(0.1)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: 'Item Price',
                      fontSize: 12,
                      color: textColor,
                    ),
                    CustomText(
                      text: Utils.formatPrice(context, order.total),
                      fontSize: 12,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: 'Discount',
                      fontSize: 12,
                      color: textColor,
                    ),
                    CustomText(
                      text: Utils.formatPrice(context, order.discountAmount),
                      fontSize: 12,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: 'Coupon Discount',
                      fontSize: 12,
                      color: textColor,
                    ),
                    CustomText(
                      text: Utils.formatPrice(context, order.coupon),
                      fontSize: 12,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: 'Vat/Tax',
                      fontSize: 12,
                      color: textColor,
                    ),
                    CustomText(
                      text: Utils.formatPrice(context, order.vat),
                      fontSize: 12,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: 'Delivery Fee',
                      fontSize: 12,
                      color: textColor,
                    ),
                    CustomText(
                      text: Utils.formatPrice(context, order.deliveryCharge),
                      fontSize: 12,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                Divider(color: Colors.black.withOpacity(0.1)),

                /// Total
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: 'Total Amount',
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: Utils.formatPrice(context, order.grandTotal),
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),

                Divider(color: Colors.black.withOpacity(0.1)),
                const Center(
                  child: CustomText(
                    text: 'Thank You!',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Divider(color: Colors.black.withOpacity(0.1)),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: 'Foodigo.', fontWeight: FontWeight.w600),
                    CustomText(text: '© Copyright 2024'),
                  ],
                ),
                Utils.verticalSpace(20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     GestureDetector(
                //       onTap: () {},
                //       child: Container(
                //         padding: Utils.symmetric(h: 20, v: 14),
                //         decoration: BoxDecoration(
                //             color: textColor,
                //             borderRadius: BorderRadius.circular(6.r)),
                //         child: const CustomText(
                //           text: 'Print now',
                //           color: whiteColor,
                //         ),
                //       ),
                //     ),
                //     SizedBox(
                //       width: 10.w,
                //     ),
                //     GestureDetector(
                //       onTap: () {},
                //       child: Container(
                //         padding: Utils.symmetric(h: 20, v: 14),
                //         decoration: BoxDecoration(
                //             color: primaryColor,
                //             borderRadius: BorderRadius.circular(6.r)),
                //         child: const CustomText(text: 'Download PDF'),
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
          );
        } else if (state is ResOrderError) {
          return Center(child: Text("Error: ${state.message}"));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key, this.title, this.subTitle});

  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: title ?? '', fontSize: 16, color: subTitleTextColor),
        CustomText(
          text: subTitle ?? '',
          fontSize: 16,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ],
    );
  }
}

class OrderInfo extends StatelessWidget {
  const OrderInfo({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Info(title: 'Name', subTitle: 'Grilled lemon Chicken'),
        Info(title: 'Quantity', subTitle: '2'),
        Info(title: 'Variations Size', subTitle: 'Medium'),
        Info(title: 'Price', subTitle: '\$${25}'),
      ],
    );
  }
}

class FoodInfo extends StatelessWidget {
  const FoodInfo({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Info(title: 'Order ID', subTitle: '#151054', colors: redColor),
        Info(title: 'Delivery Type', subTitle: 'Cash'),
        Info(title: 'Time', subTitle: '02 Jan, 2024 - 06:44'),
      ],
    );
  }
}

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Info(title: 'Name', subTitle: 'Osacar Ramio'),
        Info(title: 'Location', subTitle: '2972 Rd. Santa Ana, 85486 '),
        Info(title: 'Phone', subTitle: '+101147774'),
      ],
    );
  }
}

class Info extends StatelessWidget {
  const Info({super.key, this.title, this.subTitle, this.colors});

  final String? title;
  final String? subTitle;
  final Color? colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: '$title: ',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        CustomText(
          text: '$subTitle',
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: colors ?? subTitleTextColor,
        ),
      ],
    );
  }
}
