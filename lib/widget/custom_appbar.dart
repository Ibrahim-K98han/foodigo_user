import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.onTap,
    this.horSpace = 24.0,
    this.bgColor = Colors.transparent,
    this.textColor = blackColor,
    this.iconColor = blackColor,
    this.visibleLeading = true,
    this.iconBgColor = primaryColor,
    this.action = const [],
  });
  final String title;
  final double horSpace;
  final Color bgColor;
  final Color textColor;
  final Color iconColor;
  final bool visibleLeading;
  final Color iconBgColor;
  final Function()? onTap;
  final List<Widget> action;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      surfaceTintColor: bgColor,
      centerTitle: true,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if (visibleLeading)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.arrow_back_sharp,
                size: 26.0,
                color: Color(0xFF040415),
              ),
            ),
         // Utils.horizontalSpace(horSpace),
          const Spacer(),
          CustomText(
            text: title,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
          const Spacer(),
        ],
      ),
      actions: action,
      toolbarHeight: Utils.vSize(70.0),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(Utils.vSize(70.0));
}
