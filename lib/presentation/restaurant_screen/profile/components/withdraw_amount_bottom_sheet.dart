import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/restaurant_features/WithdrawData/cubit/withdraw_cubit.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/primary_button.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../features/restaurant_features/WithdrawData/cubit/withdraw_state.dart';
import '../../../../features/restaurant_features/WithdrawData/model/withdraw_store_state_model.dart';

class WithdrawAmountBottomSheet extends StatefulWidget {
  const WithdrawAmountBottomSheet({super.key});

  @override
  State<WithdrawAmountBottomSheet> createState() =>
      _WithdrawAmountBottomSheetState();
}

class _WithdrawAmountBottomSheetState extends State<WithdrawAmountBottomSheet> {
  final _formKey = GlobalKey<FormState>();
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
    return BlocListener<WithdrawCubit, WithdrawStoreStateModel>(
      listener: (context, state) {
        final ws = state.withdrawState;
        if (ws is WithdrawStoreLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Utils.successSnackBar(
              context,
              'Withdraw request has been sent. Please await admin approval',
            );
            Navigator.pop(context);
          });
        }
      },
      child: Padding(
        padding: Utils.symmetric(h: 10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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

              // Payment Method Dropdown
              BlocBuilder<WithdrawCubit, WithdrawStoreStateModel>(
                builder: (context, state) {
                  final ws = state.withdrawState;
                  if (ws is WithdrawMethodLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (ws is WithdrawMethodLoaded) {
                    final methods = ws.withdrawModel.methods ?? [];
                    return DropdownButtonFormField<String>(
                      hint: const Text('Select Method'),
                      value: selectedMethodValue,
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() => selectedMethodValue = value);
                        withdrawCubit.methodId(value!);
                      },
                      items:
                          methods.map<DropdownMenuItem<String>>((met) {
                            return DropdownMenuItem(
                              value: met.id.toString(),
                              child: Text(met.methodName),
                            );
                          }).toList(),
                      validator: FormBuilderValidators.required(
                        errorText: 'Please select a method',
                      ),
                    );
                  }

                  if (ws is WithdrawMethodError) {
                    return Text(
                      ws.message,
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  return const SizedBox();
                },
              ),
              Utils.verticalSpace(10),

              // Amount input
              BlocBuilder<WithdrawCubit, WithdrawStoreStateModel>(
                builder: (context, state) {
                  final validate = state.withdrawState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        initialValue: state.amount,
                        onChanged: withdrawCubit.amount,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '\$0.00',
                        ),
                        validator: FormBuilderValidators.required(
                          errorText: 'Please enter an amount',
                        ),
                      ),
                      if (validate is WithdrawValidateStateError) ...[
                        if (validate.errors.withdrawAmount.isNotEmpty)
                          FetchErrorText(
                            text: validate.errors.withdrawAmount.first,
                          ),
                      ],
                    ],
                  );
                },
              ),
              Utils.verticalSpace(10),

              // Bank info input
              BlocBuilder<WithdrawCubit, WithdrawStoreStateModel>(
                builder: (context, state) {
                  final validate = state.withdrawState;
                  return Column(
                    children: [
                      CustomFormWidget(
                        label: 'Bank Info',
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter Bank Description',
                          ),
                          initialValue: state.bankDescription,
                          onChanged: withdrawCubit.description,
                          maxLines: 3,
                          validator: FormBuilderValidators.required(
                            errorText: 'Please enter Bank Info',
                          ),
                        ),
                      ),
                      if (validate is WithdrawValidateStateError) ...[
                        if (validate.errors.accountInfo.isNotEmpty)
                          FetchErrorText(
                            text: validate.errors.accountInfo.first,
                          ),
                      ],
                    ],
                  );
                },
              ),
              Utils.verticalSpace(30),

              // Withdraw button
              PrimaryButton(
                text: 'Withdraw',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    withdrawCubit.addNewWithdraw();
                  }
                },
              ),
              Utils.verticalSpace(10),
            ],
          ),
        ),
      ),
    );
  }
}
