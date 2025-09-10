import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/Order/cubit/order_cubit.dart';
import 'package:foodigo/features/address/cubit/get_address_cubit.dart';
import 'package:foodigo/features/checkout/cubit/checkout_cubit.dart';
import 'package:foodigo/presentation/screen/main_page/component/main_controller.dart';

import '../../../../features/Subscription/cubit/subscription_cubit.dart';
import '../../../../features/Subscription/cubit/subscription_state.dart';
import '../../../../features/Subscription/model/payment_to_map_model.dart';
import '../../../../widget/primary_button.dart';
import '../../../core/routes/route_names.dart';

class BankPaymentScreen extends StatefulWidget {
  const BankPaymentScreen({super.key});

  @override
  State<BankPaymentScreen> createState() => _BankPaymentScreenState();
}

class _BankPaymentScreenState extends State<BankPaymentScreen> {
  late SubscriptionCubit sCubit;
  late GetAddressCubit adCubit;
  late OrderCubit orCubit;
  late CheckoutCubit chCubit;

  TextEditingController tnxInfoController = TextEditingController();

  late MainController mainController;

  @override
  void initState() {
    super.initState();
    sCubit = context.read<SubscriptionCubit>();
    adCubit = context.read<GetAddressCubit>();
    orCubit = context.read<OrderCubit>();
    chCubit = context.read<CheckoutCubit>();
    mainController = MainController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 25),
            BlocBuilder<SubscriptionCubit, PaymentToMapModel>(
              builder: (context, state) {
                return TextFormField(
                  controller: tnxInfoController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Enter Bank Transaction Info',
                    border: OutlineInputBorder(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            BlocConsumer<SubscriptionCubit, PaymentToMapModel>(
              listener: (context, state) {
                final currentState = state.subscriptionListState;
                if (currentState is BankPaymentStateLoading) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const AlertDialog(
                      title: Text('Processing Payment'),
                      content: SizedBox(
                        height: 60,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  );
                } else if (currentState is BankPaymentStateLoaded) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => AlertDialog(
                      title: const Text('Payment Successful'),
                      content: Text(currentState.message),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RouteNames.mainScreen,
                              (route) => false,
                            );
                            Future.delayed(Duration(milliseconds: 100), () {
                              MainController().changeTab(2);
                            });
                          },
                          child: const Text('Go to My Orders'),
                        ),
                      ],
                    ),
                  );
                } else if (currentState is BankPaymentStateError) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Payment Failed'),
                      content: Text(currentState.message),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return PrimaryButton(
                  text: 'Pay Now',
                  onPressed: () {
                    final order = orCubit.orderModel;
                    sCubit.payWithBank(
                      transactionInfo: tnxInfoController.text.trim(),
                      addressId: chCubit
                          .checkoutResponseModel!.checkoutData!.addressInfo.id
                          .toString(),
                      orderType: order?.orderType ?? 'delivery',
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
