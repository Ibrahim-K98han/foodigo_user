import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../utils/constraints.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Notification',
        visibleLeading: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return const NotificationWidget();
          },
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
              width: 48.w,
              height: 48.h,
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                  color: textColor, shape: BoxShape.circle),
              child: const CustomImage(path: KImages.message)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Orders Cancelled',
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              Row(
                children: [
                  const CustomText(
                    text: '19 Dec, 2022',
                    fontSize: 12,
                    color: subTitleTextColor,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Container(
                      width: 4.w,
                      height: 4.h,
                      decoration: const BoxDecoration(
                          color: smallContainerColor, shape: BoxShape.circle),
                    ),
                  ),
                  const CustomText(
                    text: '20:50 PM',
                    fontSize: 12,
                    color: subTitleTextColor,
                  ),
                ],
              )
            ],
          ),
          trailing: Container(
            alignment: Alignment.center,
            width: 42.w,
            height: 20.h,
            decoration: BoxDecoration(
                color: textColor,
                borderRadius: BorderRadius.circular(3.r)),
            child: const CustomText(
              text: 'New',
              color: whiteColor,
              fontSize: 10,
            ),
          ),
        ),
        const CustomText(
          text:
              'You have canceled an order at Burger Hut. We will try to improve our service next time 🥲',
          fontSize: 12,
          color: subTitleTextColor,
        ),
        Divider(
          color: Colors.black.withOpacity(0.1),
        )
      ],
    );
  }
}
