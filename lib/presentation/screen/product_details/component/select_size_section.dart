import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../features/ProductDetails/cubit/product_details_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class SelectSizeSection extends StatefulWidget {
  const SelectSizeSection({super.key});

  @override
  State<SelectSizeSection> createState() => _SelectSizeSectionState();
}

class _SelectSizeSectionState extends State<SelectSizeSection> {
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<ProductDetailsCubit>();

    final sizeData = detailsCubit.featuredProducts?.size != null
        ? json.decode(detailsCubit.featuredProducts!.size)
    as Map<String, dynamic>
        : {};

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
                    children: sizeData.entries.map((entry) {
                      final sizeName = entry.key;
                      final price = entry.value.toString();
                      return SelectSizeWidget(
                        size: sizeName,
                        amount: '\$$price',
                        isChecked: selectedSize == sizeName,
                        onTap: (value) {
                          setState(() {
                            if (value == true) {
                              selectedSize = sizeName;
                            } else {
                              selectedSize = null;
                            }
                          });
                        },
                      );
                    }).toList(),
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

class SelectSizeWidget extends StatelessWidget {
  const SelectSizeWidget({
    super.key,
    this.size,
    this.amount,
    this.isChecked,
    this.onTap,
  });

  final String? size;
  final String? amount;
  final bool? isChecked;
  final ValueChanged<bool?>? onTap;

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
          text: amount ?? '',
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        title: CustomText(
          text: size ?? '',
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        checkColor: blackColor,
        activeColor: primaryColor,
        side: const BorderSide(
          color: primaryColor,
          width: 2.0,
        ),
        value: isChecked,
        onChanged: onTap,
      ),
    );
  }
}
