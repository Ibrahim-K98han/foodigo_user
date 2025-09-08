import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/Order/cubit/order_cubit.dart';
import 'package:foodigo/features/address/cubit/get_address_cubit.dart';
import 'package:foodigo/features/checkout/cubit/checkout_cubit.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../../features/Subscription/cubit/subscription_cubit.dart';
import '../../../../features/Subscription/cubit/subscription_state.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/primary_button.dart';
import '../../../core/routes/route_names.dart';

class BankPaymentScreen extends StatefulWidget {
  const BankPaymentScreen({
    super.key,
  });

  @override
  State<BankPaymentScreen> createState() => _BankPaymentScreenState();
}

class _BankPaymentScreenState extends State<BankPaymentScreen> {
  late SubscriptionCubit sCubit;
  late GetAddressCubit adCubit;
  late OrderCubit orCubit;
  late CheckoutCubit chCubit;

  TextEditingController tnxInfoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    sCubit = context.read<SubscriptionCubit>();
    adCubit = context.read<GetAddressCubit>();
    orCubit = context.read<OrderCubit>();
    chCubit = context.read<CheckoutCubit>();
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
            BlocBuilder<SubscriptionCubit, SubscriptionListState>(
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
            BlocConsumer<SubscriptionCubit, SubscriptionListState>(
              listener: (context, state) {
                if (state is BankPaymentStateLoading) {
                  // Show loading dialog
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
                } else {
                  // Close previous dialog if any
                  if (Navigator.canPop(context)) Navigator.pop(context);

                  if (state is BankPaymentStateLoaded) {
                    // Show success in a dialog
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (_) => AlertDialog(
                        title: const Text('Payment Successful'),
                        content: Text(state.message),
                      ),
                    );

                    // Automatically navigate after 2 seconds
                    Future.delayed(const Duration(seconds: 2), () {
                      if (Navigator.canPop(context))
                        Navigator.pop(context); // close dialog
                      Navigator.pushReplacementNamed(
                          context, RouteNames.paymentMethodScreen);
                    });
                  } else if (state is BankPaymentStateError) {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CustomImage(path: KImages.orderSuccess),
                            const CustomText(
                              textAlign: TextAlign.center,
                              text: 'Thank you! for\nOrder Successfully',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                            Utils.verticalSpace(10),
                            PrimaryButton(
                              text: 'Tack Your Order',
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteNames.trackOrderScreen);
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }
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
                          .checkoutResponseModel!.checkoutData!.addressInfo.id,
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
