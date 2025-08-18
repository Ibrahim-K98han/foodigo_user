import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/custom_text_style.dart';
import '../../core/routes/route_names.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F8FA),
      appBar: const CustomAppBar(title: 'Settings', visibleLeading: true),
      body: Padding(
        padding: Utils.symmetric(h: 24.0),
        child: ListView(
          children: [
            SwitchWidget(
              text: 'Notification',
              initialValue: true,
              onToggle: (bool value) {},
            ),
            SettingsWidget(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.myOrderScreen);
              },
              text: 'Order Status',
              icon: KImages.time_square,
            ),
            SettingsWidget(
              onTap: () {},
              text: 'Offers & Rewards',
              icon: KImages.offers,
            ),
            SettingsWidget(
              onTap: () {
                Navigator.pushNamed(context, RouteNames.languageScreen);
              },
              text: 'Language',
              icon: KImages.language,
              languageText: 'English',
            ),
            SettingsWidget(
              onTap: () {
                // Navigator.pushNamed(context, RouteNames.faqScreen);
              },
              text: 'FAQ',
              icon: KImages.faq,
            ),
            Utils.verticalSpace(60),
            PrimaryButton(text: 'Update Profile', onPressed: () {})
          ],
        ),
      ),
    );
  }
}

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    super.key,
    this.text,
    required this.initialValue,
    required this.onToggle,
    this.widget,
  });

  final String? text;
  final bool initialValue;
  final ValueChanged<bool> onToggle;
  final Widget? widget;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = widget.initialValue;
  }

  void _toggle() {
    setState(() => isOn = !isOn);
    widget.onToggle(isOn);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CustomImage(
                  path: KImages.notificationIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
                Utils.horizontalSpace(12),
                CustomText(
                  text: widget.text ?? '',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Row(
              children: [
                const CustomText(
                  text: 'On',
                  fontWeight: FontWeight.w500,
                ),
                Utils.horizontalSpace(8),
                GestureDetector(
                  onTap: _toggle,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: 50,
                    height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: isOn ? textColor : Colors.grey.shade100,
                    ),
                    child: AnimatedAlign(
                      duration: const Duration(milliseconds: 100),
                      alignment:
                          isOn ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsWidget extends StatelessWidget {
  const SettingsWidget(
      {super.key, this.text, this.icon, this.onTap, this.languageText});

  final String? text;
  final String? languageText;
  final String? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CustomImage(
                  path: icon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
                Utils.horizontalSpace(12),
                CustomText(
                  text: text ?? '',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            Row(
              children: [
                CustomText(
                  text: languageText ?? '',
                  fontWeight: FontWeight.w500,
                  color: lightGrayColor,
                ),
                Utils.horizontalSpace(8),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 24.w,
                    height: 24.h,
                    padding: Utils.all(value: 2),
                    decoration: BoxDecoration(
                        color: settingsIconBgColor,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: const Icon(
                      Icons.arrow_forward_sharp,
                      color: whiteColor,
                      size: 16,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
