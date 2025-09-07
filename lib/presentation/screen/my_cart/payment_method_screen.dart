import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/PaymentMethod/cubit/payment_method_cubit.dart';
import 'package:foodigo/features/PaymentMethod/model/payment_method_response_model.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../features/PaymentMethod/cubit/payment_method_state.dart';
import '../../../features/PaymentMethod/model/payment_method_response_model.dart';
import '../../../utils/utils.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/loading_widget.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late PaymentCubit pmCubit;

  @override
  void initState() {
    super.initState();
    pmCubit = context.read<PaymentCubit>();
    pmCubit.fetchPaymentMethods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFD),
      appBar: const CustomAppBar(title: 'Payment Method', visibleLeading: true),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          if (state is PaymentError) {
            if (state.statusCode == 503 || pmCubit.paymentMethodModel == null) {
              Utils.errorSnackBar(context, state.message);
            }
          }
        },
        builder: (context, state) {
          if (state is PaymentLoading) {
            return const LoadingWidget();
          } else if (state is PaymentError) {
            if (state.statusCode == 503 && pmCubit.paymentMethodModel != null) {
              return PaymentInfoLoadedWidget(
                payment: pmCubit.paymentMethodModel,
              );
            }
            return FetchErrorText(text: state.message);
          } else if (state is PaymentLoaded) {
            return PaymentInfoLoadedWidget(
              payment: pmCubit.paymentMethodModel,
            );
          }

          if (pmCubit.paymentMethodModel != null) {
            return PaymentInfoLoadedWidget(
              payment: pmCubit.paymentMethodModel,
            );
          }

          return const FetchErrorText(text: 'Something went wrong');
        },
      ),
    );
  }
}

class PaymentInfoLoadedWidget extends StatelessWidget {
  const PaymentInfoLoadedWidget({super.key, required this.payment});

  final PaymentMethodModel? payment;

  @override
  Widget build(BuildContext context) {
    final methods = payment;

    if (methods == null) {
      return const FetchErrorText(text: 'No payment methods available');
    }

    final methodsList = [
      {'status': methods.stripeStatus.trim(), 'icon': methods.stripeImage},
      {'status': methods.paypalStatus.trim(), 'icon': methods.paypalImage},
      {'status': methods.razorpayStatus.trim(), 'icon': methods.razorpayImage},
      {
        'status': methods.flutterwaveStatus.trim(),
        'icon': methods.flutterwaveLogo
      },
      {'status': methods.mollieStatus.trim(), 'icon': methods.mollieImage},
      {'status': methods.paystackStatus.trim(), 'icon': methods.paystackImage},
      {
        'status': methods.instamojoStatus.trim(),
        'icon': methods.instamojoImage
      },
      {'status': methods.bankStatus.trim(), 'icon': methods.bankImage},
    ];

    final enabledMethods = methodsList
        .where((e) => (e['status']?.toString().trim() ?? '') == '1')
        .toList();

    if (enabledMethods.isEmpty) {
      return const FetchErrorText(text: 'No enabled payment methods');
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            'Select the payment method you want to use',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // 2-column grid
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 3.5,
            ),
            itemCount: enabledMethods.length,
            itemBuilder: (context, index) {
              final method = enabledMethods[index];
              return SinglePaymentCard(
                onTap: () {
                  print('object');
                },
                icon: RemoteUrls.imageUrl(method['icon']!),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SinglePaymentCard extends StatelessWidget {
  const SinglePaymentCard({super.key, required this.onTap, required this.icon});

  final VoidCallback onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFDBDBDB)),
          borderRadius: Utils.borderRadius(),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CustomImage(
            path: icon,
            fit: BoxFit.contain,
            height: 40.0,
            width: 120.0,
          ),
        ),
      ),
    );
  }
}
