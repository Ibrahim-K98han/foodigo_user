import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class SelectSizeSection extends StatefulWidget {
  const SelectSizeSection({super.key});

  @override
  State<SelectSizeSection> createState() => _SelectSizeSectionState();
}

class _SelectSizeSectionState extends State<SelectSizeSection> {
  bool small = false;
  bool medium = false;
  bool large = false;
  bool extraLarge = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
            border: Border.all(color: borderColor),
            borderRadius: Utils.borderRadius(),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: transparent),
            child: ExpansionTile(
              initiallyExpanded: true,
              iconColor: blackColor,
              title: Row(
                children: [
                  const CustomText(
                    text: "Select Size",
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      padding: Utils.symmetric(h: 10.0, v: 4.0),
                      decoration: BoxDecoration(
                        color: greenColor.withOpacity(0.1),
                        border: Border.all(color: greenColor),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: const CustomText(
                        text: 'Mandatory',
                        color: greenColor,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
              children: [
                Padding(
                  padding: Utils.symmetric(h: 10.0),
                  child: Column(
                    children: [
                      SelectSizeWidget(
                        size: 'Small',
                        amount: '\$30',
                        isChecked: small,
                        onTap: (value) {
                          setState(() {
                            small = value!;
                          });
                        },
                      ),
                      SelectSizeWidget(
                        size: 'Medium',
                        amount: '\$30',
                        isChecked: medium,
                        onTap: (value) {
                          setState(() {
                            medium = value!;
                          });
                        },
                      ),
                      SelectSizeWidget(
                        size: 'Large',
                        amount: '\$30',
                        isChecked: large,
                        onTap: (value) {
                          setState(() {
                            large = value!;
                          });
                        },
                      ),
                      SelectSizeWidget(
                        size: 'Extra Large',
                        amount: '\$30',
                        isChecked: extraLarge,
                        onTap: (value) {
                          setState(() {
                            extraLarge = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Utils.verticalSpace(10.0),
      ],
    );
  }
}

class SelectSizeWidget extends StatefulWidget {
  const SelectSizeWidget(
      {super.key, this.size, this.amount, this.isChecked, this.onTap});

  final String? size;
  final String? amount;
  final bool? isChecked;
  final ValueChanged<bool?>? onTap;

  @override
  State<SelectSizeWidget> createState() => _SelectSizeWidgetState();
}

class _SelectSizeWidgetState extends State<SelectSizeWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: borderColor),
      ),
      child: CheckboxListTile(
        contentPadding: Utils.symmetric(h: 10.0),
        controlAffinity: ListTileControlAffinity.leading,
        secondary: CustomText(
          text: widget.amount ?? '',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        title: CustomText(
          text: widget.size ?? '',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        checkColor: blackColor,
        activeColor: primaryColor,
        side: const BorderSide(
          color: primaryColor,
          width: 2.0,
        ),
        value: widget.isChecked,
        onChanged: widget.onTap,
      ),
    );
  }
}
