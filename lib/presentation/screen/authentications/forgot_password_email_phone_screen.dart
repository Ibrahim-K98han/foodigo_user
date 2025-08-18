import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../utils/k_images.dart';
import '../../../widget/custom_image.dart';

class ForgotPasswordEmailPhoneScreen extends StatefulWidget {
  const ForgotPasswordEmailPhoneScreen({super.key});

  @override
  State<ForgotPasswordEmailPhoneScreen> createState() =>
      _ForgotPasswordEmailPhoneScreenState();
}

class _ForgotPasswordEmailPhoneScreenState
    extends State<ForgotPasswordEmailPhoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomImage(
          path: KImages.logo,
          height: 30,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            const CustomText(
              text: 'Forgot Password',
              fontSize: 24,
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
            const CustomText(
              text:
                  'Select verification method and we will send verification code',
              fontSize: 16,
              color: textGrayColor,
            ),
            const SizedBox(
              height: 44,
            ),
            EmailOrPhone(
              icon: Icons.email_outlined,
              type: 'Email',
              description: 'Send to your email',
              onTap: () {
                Navigator.pushNamed(context, RouteNames.forgotPassScreen);
              },
            ),
            const SizedBox(height: 20),
            EmailOrPhone(
              icon: Icons.phone_outlined,
              type: 'Phone Number',
              description: 'Send to your phone number',
              onTap: () {
                Navigator.pushNamed(context, RouteNames.forgotPassScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EmailOrPhone extends StatelessWidget {
  const EmailOrPhone(
      {super.key, this.icon, this.type, this.description, this.onTap});

  final IconData? icon;
  final String? type;
  final String? description;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        decoration: BoxDecoration(
            color: dialogBgColor, borderRadius: BorderRadius.circular(6.r)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration:
                  BoxDecoration(color: grayBgColor, shape: BoxShape.circle),
              child: Icon(icon),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: type ?? '',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: description ?? '',
                    color: textGrayColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
