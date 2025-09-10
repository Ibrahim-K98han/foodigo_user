import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_image.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Language', visibleLeading: true),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: PrimaryButton(text: 'Update Profile', onPressed: () {}),
      ),
      body: Padding(
        padding: Utils.symmetric(h: 24.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 18.h,
                ),
                hintText: 'Search...',
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(10),
                  child: CustomImage(
                    path: KImages.searchIcon,
                    color: textColor,
                  ),
                ),
              ),
            ),
            Utils.verticalSpace(20.0),
            SelectLanguage(
              onTap: () {},
            ),
            SelectLanguage(
              onTap: () {},
            ),
            SelectLanguage(
              onTap: () {},
            ),
            SelectLanguage(
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () {},
            leading: const CustomImage(path: KImages.us),
            title: const CustomText(text: 'English', fontSize: 16.0),
            trailing: Container(
              width: 20.w,
              height: 20.h,
              decoration: const BoxDecoration(
                color: greenColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: whiteColor,
                size: 16,
              ),
            ),
          ),
          Divider(
            color: Colors.black.withOpacity(0.1),
          ),
          Utils.verticalSpace(8),
        ],
      ),
    );
  }
}
