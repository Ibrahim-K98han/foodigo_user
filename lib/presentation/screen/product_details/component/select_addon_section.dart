import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../features/ProductDetails/cubit/product_details_cubit.dart';
import '../../../../features/add_to_cart/cubit/add_cart_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class SelectAddonSection extends StatefulWidget {
  const SelectAddonSection({super.key});

  @override
  State<SelectAddonSection> createState() => _SelectAddonSectionState();
}

class _SelectAddonSectionState extends State<SelectAddonSection> {
  List<int> selectedAddons = [];

  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<ProductDetailsCubit>();
    final addCartCubit = context.read<AddCartCubit>();

    final addonData = detailsCubit.featuredProducts?.addonItems != null
        ? (json.decode(detailsCubit.featuredProducts!.addonItems)
                as List<dynamic>)
            .map((e) => int.parse(e.toString()))
            .toList()
        : <int>[];
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
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: false,
              iconColor: blackColor,
              title: Row(
                children: [
                  const CustomText(
                      text: "Select Addon",
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      padding: Utils.symmetric(h: 10.0, v: 4.0),
                      decoration: BoxDecoration(
                        color: redColor.withOpacity(0.1),
                        border: Border.all(color: redColor),
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: const CustomText(
                          text: 'Optional', color: redColor, fontSize: 12),
                    ),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: Utils.symmetric(h: 10.0),
                  child: Column(
                    children: addonData.map((addonId) {
                      final isChecked = selectedAddons.contains(addonId);
                      final currentQty =
                          addCartCubit.state.addonsQty['$addonId'] ?? 1;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              title: Text('Addon $addonId'),
                              value: isChecked,
                              activeColor: primaryColor,
                              onChanged: (val) {
                                setState(() {
                                  if (val == true) {
                                    selectedAddons.add(addonId);
                                  } else {
                                    selectedAddons.remove(addonId);
                                  }
                                  // Update selected addons in Cubit
                                  addCartCubit.selectAddons(selectedAddons);
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),

                          ///================ Increment/Decrement Buttons =================///
                          if (isChecked)
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline,color: primaryColor,),
                                  onPressed: () {
                                    if (currentQty > 1) {
                                      final updatedQty = Map<String, int>.from(
                                          addCartCubit.state.addonsQty);
                                      updatedQty['$addonId'] = currentQty - 1;
                                      addCartCubit.updateAddonQty(updatedQty);
                                    }
                                  },
                                ),
                                Text('$currentQty'),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline,color: primaryColor,),
                                  onPressed: () {
                                    final updatedQty = Map<String, int>.from(
                                        addCartCubit.state.addonsQty);
                                    updatedQty['$addonId'] = currentQty + 1;
                                    addCartCubit.updateAddonQty(updatedQty);
                                  },
                                ),
                              ],
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Utils.verticalSpace(20.0),
      ],
    );
  }
}
