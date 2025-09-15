import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../../utils/constraints.dart';
import 'add_bank_account_bottom_sheet.dart';

class WithdrawAmountBottomSheet extends StatelessWidget {
  const WithdrawAmountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(h: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Set Amount',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          const CustomText(text: 'How much would you like to top up?'),
          TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              hintText: '\$0.00',
            ),
          ),
          Divider(
            height: 30,
            color: Colors.black.withOpacity(0.1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildAmountButton('\$10.00'),
              _buildAmountButton('\$50.00'),
              _buildAmountButton('\$100.00'),
            ],
          ),
          Utils.verticalSpace(30),
          PrimaryButton(
              text: 'Withdraw',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  backgroundColor: const Color(0xFFFDFDFD),
                  constraints: BoxConstraints.loose(
                    Size(
                      Utils.mediaQuery(context).width,
                      Utils.mediaQuery(context).height * 0.9,
                    ),
                  ),
                  isScrollControlled: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Utils.radius(32.0)),
                      topRight: Radius.circular(Utils.radius(32.0)),
                    ),
                  ),
                  builder: (context) => DraggableScrollableSheet(
                    initialChildSize: 0.85,
                    minChildSize: 0.5,
                    maxChildSize: 0.95,
                    expand: false,
                    builder: (context, scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: const AddBankAccountBottomSheet(),
                      );
                    },
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget _buildAmountButton(String label) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
            color: textColor, borderRadius: BorderRadius.circular(16.r)),
        child: CustomText(text: label));
  }
}
