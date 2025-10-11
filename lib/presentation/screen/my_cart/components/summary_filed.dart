
import 'package:flutter/material.dart';
import 'package:foodigo/widget/custom_text_style.dart';

class SummaryField extends StatelessWidget {
  const SummaryField({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF334155),
        ),
        CustomText(text: subTitle, fontSize: 14, fontWeight: FontWeight.w600),
      ],
    );
  }
}

