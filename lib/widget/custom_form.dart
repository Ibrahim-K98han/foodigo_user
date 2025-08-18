import 'package:flutter/material.dart';

import '../utils/constraints.dart';
import '../utils/utils.dart';
import 'custom_text_style.dart';

class CustomFormWidget extends StatelessWidget {
  final String label;
  final Widget child;
  final double bottomSpace;
  final Color labelColor;

  const CustomFormWidget({
    super.key,
    required this.label,
    required this.child,
    this.bottomSpace = 0.0,
    this.labelColor = blackColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 16.0,
          color: labelColor,
          fontWeight: FontWeight.w500,
        ),
        Utils.verticalSpace(4.0),
        child,
        Utils.verticalSpace(bottomSpace),
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.maxLine,
    this.keyboardType,
  });

  final String label;
  final String hintText;
  TextInputType? keyboardType;

  int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 14.0,
          color: labelColor,
          fontWeight: FontWeight.w400,
        ),
        Utils.verticalSpace(4.0),
        TextField(
          keyboardType: keyboardType,
          maxLines: maxLine,
          decoration: InputDecoration(
            fillColor: const Color(0xffF8FAFC),
            //labelText: label,
            hintText: hintText,
            labelStyle: const TextStyle(
              color: Colors.grey,
            ),
            hintStyle: const TextStyle(
              color: Colors.black,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                color: borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                color: borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(
                color: borderColor,
              ),
            ),
          ),
        ),
        Utils.verticalSpace(10.0),
      ],
    );
  }
}
