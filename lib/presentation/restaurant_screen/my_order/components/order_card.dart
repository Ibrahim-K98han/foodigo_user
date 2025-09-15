import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_image.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../core/routes/route_names.dart';

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
                  child: const OrderDetailsDialog());
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
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                shape: BoxShape.rectangle,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.r),
                    bottomLeft: Radius.circular(4.r),
                  ),
                  child: const CustomImage(
                    path: KImages.foodImage1,
                    fit: BoxFit.cover,
                  )),
            ),
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
                        text: "015454",
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

class OrderDetailsDialog extends StatelessWidget {
  const OrderDetailsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomText(
                  text: 'Chef\'s Place',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: redColor,
                  ),
                )
              ],
            ),
            Utils.verticalSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: '3891 Ranchview  California 62639',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
                const Row(
                  children: [
                    CustomText(
                      text: 'Mail: ',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                    CustomText(
                      text: 'cefespalace@gmail.com',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: subTitleTextColor,
                    ),
                  ],
                ),
                const Row(
                  children: [
                    CustomText(
                      text: 'Phone: ',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                    CustomText(
                      text: '+170797856',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: subTitleTextColor,
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black.withOpacity(0.1),
                ),
                const FoodInfo(),
                Divider(
                  color: Colors.black.withOpacity(0.1),
                ),
                const CustomText(
                  text: 'Customer Info',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                Divider(
                  color: Colors.black.withOpacity(0.1),
                ),
                const CustomerInfo(),
                const CustomText(
                  text: 'Order Info',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                Divider(
                  color: Colors.black.withOpacity(0.1),
                ),
                const OrderInfo(),
                Column(
                  children: [
                    Divider(
                      color: Colors.black.withOpacity(0.1),
                    ),
                    const ItemDetails(
                      title: 'Item Price',
                      subTitle: '\$${17.20}',
                    ),
                    const ItemDetails(
                      title: 'Subtotal',
                      subTitle: '\$${17.20}',
                    ),
                    const ItemDetails(
                      title: 'Discount',
                      subTitle: '\$${17.20}',
                    ),
                    const ItemDetails(
                      title: 'Coupon Discount',
                      subTitle: '\$${17.20}',
                    ),
                    const ItemDetails(
                      title: 'Vat',
                      subTitle: '\$${17.20}',
                    ),
                    const ItemDetails(
                      title: 'Item Price',
                      subTitle: '\$${17.20}',
                    ),
                    Divider(
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Total Amount',
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                    CustomText(
                      text: '\$${32.00}',
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black.withOpacity(0.1),
                ),
                const Center(
                    child: CustomText(
                  text: 'Thank You!',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                )),
                Divider(
                  color: Colors.black.withOpacity(0.1),
                ),
                const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: 'Foodigo.  ',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      CustomText(text: '\u00A9 Copyright 2025'),
                    ],
                  ),
                ),
                Utils.verticalSpace(20),
                Row(
                  children: [
                    Expanded(
                        child: PrimaryButton(
                            bgColor: textColor,
                            textColor: whiteColor,
                            fontSize: 12,
                            text: 'Print now',
                            onPressed: () {})),
                    Utils.horizontalSpace(8),
                    Expanded(
                        child: PrimaryButton(
                            bgColor: primaryColor,
                            fontSize: 12,
                            textColor: textColor,
                            text: 'Download PDF',
                            onPressed: () {})),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
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
        CustomText(
          text: title ?? '',
          fontSize: 16,
          color: subTitleTextColor,
        ),
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
        Info(
          title: 'Name',
          subTitle: 'Grilled lemon Chicken',
        ),
        Info(
          title: 'Quantity',
          subTitle: '2',
        ),
        Info(
          title: 'Variations Size',
          subTitle: 'Medium',
        ),
        Info(
          title: 'Price',
          subTitle: '\$${25}',
        ),
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
        Info(
          title: 'Order ID',
          subTitle: '#151054',
          colors: redColor,
        ),
        Info(
          title: 'Delivery Type',
          subTitle: 'Cash',
        ),
        Info(
          title: 'Time',
          subTitle: '02 Jan, 2024 - 06:44',
        ),
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
        Info(
          title: 'Name',
          subTitle: 'Osacar Ramio',
        ),
        Info(
          title: 'Location',
          subTitle: '2972 Rd. Santa Ana, 85486 ',
        ),
        Info(
          title: 'Phone',
          subTitle: '+101147774',
        ),
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
