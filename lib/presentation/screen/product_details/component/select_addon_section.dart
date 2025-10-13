// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../features/ProductDetails/cubit/product_details_cubit.dart';
// import '../../../../features/add_to_cart/cubit/add_cart_cubit.dart';
// import '../../../../features/add_to_cart/model/add_cart_state_model.dart';
// import '../../../../utils/constraints.dart';
// import '../../../../utils/utils.dart';
// import '../../../../widget/custom_text_style.dart';
//
// class SelectAddonSection extends StatefulWidget {
//   const SelectAddonSection({super.key});
//
//   @override
//   State<SelectAddonSection> createState() => _SelectAddonSectionState();
// }
//
// class _SelectAddonSectionState extends State<SelectAddonSection> {
//   List<int> selectedAddons = [];
//
//   @override
//   Widget build(BuildContext context) {
//     final detailsCubit = context.read<ProductDetailsCubit>();
//     final addCartCubit = context.read<AddCartCubit>();
//
//     final addonData = (detailsCubit.featuredProducts?.addonItems != null &&
//         detailsCubit.featuredProducts!.addons.isNotEmpty)
//         ? (json.decode(detailsCubit.featuredProducts!.addonItems) as List<dynamic>?)
//         ?.map((e) => int.parse(e.toString()))
//         .toList() ??
//         []
//         : [];
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: whiteColor,
//             border: Border.all(color: borderColor),
//             borderRadius: Utils.borderRadius(),
//           ),
//           child: Theme(
//             data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//             child: ExpansionTile(
//               initiallyExpanded: false,
//               iconColor: blackColor,
//               title: Row(
//                 children: [
//                   const CustomText(
//                       text: "Select Addon",
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Container(
//                       padding: Utils.symmetric(h: 10.0, v: 4.0),
//                       decoration: BoxDecoration(
//                         color: redColor.withOpacity(0.1),
//                         border: Border.all(color: redColor),
//                         borderRadius: BorderRadius.circular(50.r),
//                       ),
//                       child: const CustomText(
//                           text: 'Optional', color: redColor, fontSize: 12),
//                     ),
//                   ),
//                 ],
//               ),
//               children: [
//                 BlocConsumer<AddCartCubit, AddCartStateModel>(
//                   listener: (context, state) {},
//                   builder: (context, state) {
//                     return Column(
//                       children: addonData.map((addonId) {
//                         final isChecked = state.addons.contains(addonId);
//                         final qty = state.addonsQty['$addonId'] ?? 1;
//
//                         return Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: CheckboxListTile(
//                                 title: CustomText(
//                                   text: 'Addon $addonId',
//                                   fontSize: 14,
//                                 ),
//                                 value: isChecked,
//                                 activeColor: primaryColor,
//                                 onChanged: (val) {
//                                   final selected = List<int>.from(state.addons);
//                                   if (val == true) {
//                                     selected.add(addonId);
//                                   } else {
//                                     selected.remove(addonId);
//                                   }
//                                   context
//                                       .read<AddCartCubit>()
//                                       .selectAddons(selected);
//                                 },
//                                 controlAffinity:
//                                     ListTileControlAffinity.leading,
//                               ),
//                             ),
//                             if (isChecked)
//                               Row(
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(
//                                         Icons.remove_circle_outline,
//                                         color: primaryColor),
//                                     onPressed: () => context
//                                         .read<AddCartCubit>()
//                                         .decrementAddon(addonId),
//                                   ),
//                                   CustomText(text: '$qty'),
//                                   IconButton(
//                                     icon: const Icon(Icons.add_circle_outline,
//                                         color: primaryColor),
//                                     onPressed: () => context
//                                         .read<AddCartCubit>()
//                                         .incrementAddon(addonId),
//                                   ),
//                                 ],
//                               ),
//                           ],
//                         );
//                       }).toList(),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Utils.verticalSpace(20.0),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../features/ProductDetails/cubit/product_details_cubit.dart';
import '../../../../features/add_to_cart/cubit/add_cart_cubit.dart';
import '../../../../features/add_to_cart/model/add_cart_state_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class SelectAddonSection extends StatefulWidget {
  const SelectAddonSection({super.key});

  @override
  State<SelectAddonSection> createState() => _SelectAddonSectionState();
}

class _SelectAddonSectionState extends State<SelectAddonSection> {
  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<ProductDetailsCubit>();
    final addCartCubit = context.read<AddCartCubit>();

    // Get all addons directly from the product
    final allAddons = detailsCubit.featuredProducts?.addons ?? [];

    // If no addons available, don't show the section
    if (allAddons.isEmpty) {
      return const SizedBox.shrink();
    }

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
                    fontSize: 16,
                  ),
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
                        text: 'Optional',
                        color: redColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              children: [
                BlocConsumer<AddCartCubit, AddCartStateModel>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return Column(
                      children:
                          allAddons.map((addon) {
                            final isChecked = state.addons.contains(addon.id);
                            final qty = state.addonsQty['${addon.id}'] ?? 1;

                            // Parse price safely
                            final price =
                                double.tryParse(addon.price.toString()) ?? 0.0;

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              child: Row(
                                children: [
                                  // Checkbox and addon info
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: isChecked,
                                          activeColor: primaryColor,
                                          onChanged: (val) {
                                            final selected = List<int>.from(
                                              state.addons,
                                            );
                                            if (val == true) {
                                              selected.add(addon.id);
                                            } else {
                                              selected.remove(addon.id);
                                            }
                                            context
                                                .read<AddCartCubit>()
                                                .selectAddons(selected);
                                          },
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              CustomText(
                                                text: addon.name,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              CustomText(
                                                text:
                                                    ' (\$${price.toStringAsFixed(0)})',
                                                fontSize: 13,
                                                color: primaryColor,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Quantity controls (only show when checked)
                                  if (isChecked)
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: borderColor),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.remove_circle_outline,
                                              color: primaryColor,
                                            ),
                                            onPressed:
                                                () => context
                                                    .read<AddCartCubit>()
                                                    .decrementAddon(addon.id),
                                          ),
                                          CustomText(text: '$qty'),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add_circle_outline,
                                              color: primaryColor,
                                            ),
                                            onPressed:
                                                () => context
                                                    .read<AddCartCubit>()
                                                    .incrementAddon(addon.id),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            );
                          }).toList(),
                    );
                  },
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
        Utils.verticalSpace(20.0),
      ],
    );
  }
}
