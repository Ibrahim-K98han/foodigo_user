import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/WithdrawData/cubit/withdraw_cubit.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../../features/restaurant_features/WithdrawData/cubit/withdraw_state.dart';
import '../../../../features/restaurant_features/WithdrawData/model/withdraw_store_state_model.dart';
import '../../../../utils/constraints.dart';

class WithdrawAmountBottomSheet extends StatefulWidget {
  const WithdrawAmountBottomSheet({super.key});

  @override
  State<WithdrawAmountBottomSheet> createState() =>
      _WithdrawAmountBottomSheetState();
}

class _WithdrawAmountBottomSheetState extends State<WithdrawAmountBottomSheet> {
  String? selectedMethodValue;
  late WithdrawCubit withdrawCubit;

  @override
  void initState() {
    super.initState();
    withdrawCubit = context.read<WithdrawCubit>();
    withdrawCubit.getWithdraw();
  }

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
          Utils.verticalSpace(20),
          const CustomText(
            text: 'Select Payment Method',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          Utils.verticalSpace(8),
          BlocBuilder<WithdrawCubit, WithdrawStoreStateModel>(
            builder: (context, state) {
              final ws = state.withdrawState;
              if (ws is WithdrawMethodLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (ws is WithdrawMethodLoaded) {
                final List methods =
                    ws.withdrawModel.methods ?? ws.withdrawModel.methods ?? [];
                return DropdownButtonFormField<String>(
                  hint: const Text('Select Method'),
                  value: selectedMethodValue,
                  isExpanded: true,
                  onChanged: (value) {
                    withdrawCubit.methodId(value!);
                  },
                  items: methods.map<DropdownMenuItem<String>>((met) {
                    return DropdownMenuItem(
                      value: met.id.toString(),
                      child: Text(met.methodName),
                    );
                  }).toList(),
                );
              }
              if (ws is WithdrawMethodError) {
                return Text(ws.message,
                    style: const TextStyle(color: Colors.red));
              }
              return const SizedBox();
            },
          ),
          Utils.verticalSpace(10),
          BlocBuilder<WithdrawCubit, WithdrawStoreStateModel>(
            builder: (context, state) {
              return TextFormField(
                initialValue: state.amount,
                onChanged: withdrawCubit.amount,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: '\$0.00',
                ),
              );
            },
          ),
          Utils.verticalSpace(10),
          BlocBuilder<WithdrawCubit, WithdrawStoreStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Bank Info',
                child: TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Enter Bank Description'),
                  initialValue: state.bankDescription,
                  onChanged: withdrawCubit.description,
                  maxLines: 3,
                ),
              );
            },
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     _buildAmountButton('\$10.00'),
          //     _buildAmountButton('\$50.00'),
          //     _buildAmountButton('\$100.00'),
          //   ],
          // ),
          Utils.verticalSpace(30),
          PrimaryButton(
            text: 'Withdraw',
            onPressed: () {
              withdrawCubit.addNewWithdraw();
              // showModalBottomSheet(
              //   context: context,
              //   showDragHandle: true,
              //   backgroundColor: const Color(0xFFFDFDFD),
              //   constraints: BoxConstraints.loose(
              //     Size(
              //       Utils.mediaQuery(context).width,
              //       Utils.mediaQuery(context).height * 0.9,
              //     ),
              //   ),
              //   isScrollControlled: false,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(Utils.radius(32.0)),
              //       topRight: Radius.circular(Utils.radius(32.0)),
              //     ),
              //   ),
              //   builder: (context) => DraggableScrollableSheet(
              //     initialChildSize: 0.85,
              //     minChildSize: 0.5,
              //     maxChildSize: 0.95,
              //     expand: false,
              //     builder: (context, scrollController) {
              //       return SingleChildScrollView(
              //         controller: scrollController,
              //         child: const AddBankAccountBottomSheet(),
              //       );
              //     },
              //   ),
              // );
            },
          )
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
