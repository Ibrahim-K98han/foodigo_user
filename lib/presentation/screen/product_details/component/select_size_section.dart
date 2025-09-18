// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:foodigo/features/add_to_cart/cubit/store_product_cubit.dart';
// import 'package:foodigo/widget/custom_text_style.dart';
//
// import '../../../../features/ProductDetails/cubit/product_details_cubit.dart';
// import '../../../../utils/constraints.dart';
// import '../../../../utils/utils.dart';
//
// class SelectSizeSection extends StatefulWidget {
//   const SelectSizeSection({super.key});
//
//   @override
//   State<SelectSizeSection> createState() => _SelectSizeSectionState();
// }
//
// class _SelectSizeSectionState extends State<SelectSizeSection> {
//   @override
//   Widget build(BuildContext context) {
//     final detailsCubit = context.read<ProductDetailsCubit>();
//     final addCubit = context.watch<AddCartCubit>();
//
//     Map<String, dynamic> sizeData = {};
//     if (detailsCubit.featuredProducts?.size != null) {
//       try {
//         sizeData = json.decode(detailsCubit.featuredProducts!.size)
//             as Map<String, dynamic>;
//       } catch (e) {
//         print("Error decoding size JSON: $e");
//       }
//     }
//     if (sizeData.isEmpty) {
//       return const Text("No sizes available");
//     }
//
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: whiteColor,
//         border: Border.all(color: borderColor),
//         borderRadius: Utils.borderRadius(),
//       ),
//       child: Theme(
//         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
//         child: ExpansionTile(
//           title: Row(
//             children: [
//               const CustomText(
//                   text: "Select Addon",
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Container(
//                   padding: Utils.symmetric(h: 10.0, v: 4.0),
//                   decoration: BoxDecoration(
//                     color: greenColor.withOpacity(0.1),
//                     border: Border.all(color: greenColor),
//                     borderRadius: BorderRadius.circular(50.r),
//                   ),
//                   child: const CustomText(
//                       text: 'Mandatory', color: greenColor, fontSize: 12),
//                 ),
//               ),
//             ],
//           ),
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: sizeData.entries.map((entry) {
//                 final sizeName = entry.key.toString();
//                 final price = entry.value.toString();
//                 final isChecked = addCubit.state.size == '$sizeName,$price';
//
//                 return SelectSizeWidget(
//                   size: sizeName,
//                   amount: '\$$price',
//                   isChecked: isChecked,
//                   onTap: (value) {
//                     if (value == true) {
//                       addCubit.selectSize('$sizeName,$price');
//                     } else {
//                       addCubit.selectSize('');
//                     }
//                   },
//                 );
//               }).toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class SelectSizeWidget extends StatelessWidget {
//   final String? size;
//   final String? amount;
//   final bool? isChecked;
//   final ValueChanged<bool?>? onTap;
//
//   const SelectSizeWidget({
//     super.key,
//     this.size,
//     this.amount,
//     this.isChecked,
//     this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//       activeColor: primaryColor,
//       value: isChecked,
//       onChanged: onTap,
//       controlAffinity: ListTileControlAffinity.leading,
//       title: CustomText(
//         text: size ?? '',
//         fontWeight: FontWeight.w500,
//         fontSize: 14,
//       ),
//       secondary: CustomText(
//         text: amount ?? '',
//         fontWeight: FontWeight.w600,
//         fontSize: 14,
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/add_to_cart/cubit/add_cart_cubit.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import '../../../../features/ProductDetails/cubit/product_details_cubit.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';

class SelectSizeSection extends StatefulWidget {
  const SelectSizeSection({super.key});

  @override
  State<SelectSizeSection> createState() => _SelectSizeSectionState();
}

class _SelectSizeSectionState extends State<SelectSizeSection> {
  @override
  Widget build(BuildContext context) {
    final detailsCubit = context.read<ProductDetailsCubit>();
    final addCubit = context.watch<AddCartCubit>();

    Map<String, dynamic> sizeData = {};
    if (detailsCubit.featuredProducts?.size != null) {
      try {
        sizeData = json.decode(detailsCubit.featuredProducts!.size)
        as Map<String, dynamic>;
      } catch (e) {
        print("Error decoding size JSON: $e");
      }
    }
    if (sizeData.isEmpty) {
      return const Text("No sizes available");
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: borderColor),
        borderRadius: Utils.borderRadius(),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Row(
            children: [
              const CustomText(
                  text: "Select Size",
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
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
                      text: 'Mandatory', color: greenColor, fontSize: 12),
                ),
              ),
            ],
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: sizeData.entries.map((entry) {
                final sizeName = entry.key.toString();
                final price = entry.value.toString();
                return RadioListTile<String>(
                  activeColor: primaryColor,
                  value: '$sizeName,$price',
                  groupValue: addCubit.state.size,
                  title: CustomText(
                    text: sizeName,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  secondary: CustomText(
                    text: '\$$price',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  onChanged: (value) {
                    addCubit.selectSize(value ?? '');
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
