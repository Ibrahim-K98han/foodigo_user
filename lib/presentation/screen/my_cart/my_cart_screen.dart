import 'package:flutter/material.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../core/routes/route_names.dart';

class MyCartScreen extends StatelessWidget {
  const MyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Carts',
        visibleLeading: false,
        action: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert), // The three-dot icon
            onSelected: (String value) {
              // Handle selection
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected: $value')),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                  value: 'Clear All',
                  child: CustomText(
                    text: 'Clear All',
                    color: Colors.red,
                  )),
            ],
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: Utils.symmetric(),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 40,
                  offset: Offset(0, 2),
                  spreadRadius: 10,
                )
              ],
            ),
            child: Column(
              children: [
                ...List.generate(7, (index) {
                  return Padding(
                    padding: Utils.only(bottom: 12.0),
                    child: const CheckoutCart(),
                  );
                })
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 4.0),
        child: PrimaryButton(
            text: 'Checkout',
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.orderScreen);
            }),
      ),
    );
  }
}

class CheckoutCart extends StatelessWidget {
  const CheckoutCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Utils.symmetric(h: 8.0, v: 4.0),
      height: 90.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0), color: whiteColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 92.0,
            height: 72.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              shape: BoxShape.rectangle,
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
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
                  const Flexible(
                    child: CustomText(
                      text: 'Chicken Shawarma Special Thai Fried and ',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      maxLine: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CustomText(
                        text: '\$35.0',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE94222),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              shape: BoxShape.rectangle,
                              color: primaryColor.withOpacity(0.2),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          Utils.horizontalSpace(8.0),
                          const CustomText(
                            text: '1',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          Utils.horizontalSpace(8.0),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              shape: BoxShape.rectangle,
                              color: primaryColor,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: blackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
