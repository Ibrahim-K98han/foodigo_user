import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/PaymentMethod/cubit/payment_method_cubit.dart';
import 'package:foodigo/features/PaymentMethod/model/payment_method_response_model.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../features/PaymentMethod/cubit/payment_method_state.dart';
import '../../../utils/utils.dart';
import '../../../widget/fetch_error_text.dart';
import '../../../widget/loading_widget.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  late PaymentMethodCubit pmCubit;

  @override
  void initState() {
    pmCubit = context.read<PaymentMethodCubit>();
    pmCubit.getAllPaymentMethodData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFD),
      appBar: const CustomAppBar(title: 'Payment Method', visibleLeading: true),
      body: BlocConsumer<PaymentMethodCubit, PaymentMethodState>(
          listener: (context, state) {
        final payment = state;
        if (payment is PaymentMethodStateError) {
          if (payment.statusCode == 503 ||
              pmCubit.paymentMethodResponseModel == null) {
            Utils.errorSnackBar(context, payment.message);
          }
        }
      }, builder: (context, state) {
        final payment = state;
        if (payment is PaymentMethodStateLoading) {
          return const LoadingWidget();
        } else if (payment is PaymentMethodStateError) {
          if (payment.statusCode == 503) {
            if (pmCubit.paymentMethodResponseModel != null) {
              return PaymentInfoLoadedWidget(
                payment: pmCubit.paymentMethodResponseModel,
              );
            }
          } else {
            return FetchErrorText(text: payment.message);
          }
        } else if (payment is PaymentMethodStateLoaded) {
          return PaymentInfoLoadedWidget(
            payment: pmCubit.paymentMethodResponseModel,
          );
        }
        if (pmCubit.paymentMethodResponseModel != null) {
          return PaymentInfoLoadedWidget(
            payment: pmCubit.paymentMethodResponseModel,
          );
        }
        return const FetchErrorText(text: 'Something went wrong');
      }),
    );
  }
}

class PaymentInfoLoadedWidget extends StatelessWidget {
  const PaymentInfoLoadedWidget({super.key, required this.payment});

  final PaymentMethodResponseModel? payment;

  @override
  Widget build(BuildContext context) {
    final methods = payment?.data?.paymentMethods;

    if (methods == null) {
      return const FetchErrorText(text: 'No payment methods available');
    }

    // List of all payment methods with status and icon
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

    // Filter only enabled methods
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
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              childAspectRatio: 4.0,
            ),
            itemCount: enabledMethods.length,
            itemBuilder: (context, index) {
              final method = enabledMethods[index];
              return Container(
                color: Colors.red,
                child: SinglePaymentCard(
                  onTap: () {},
                  icon: RemoteUrls.imageUrl(method['icon']!),
                ),
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
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        //padding: Utils.symmetric(v: 18.0, h: 0.0),
        // margin: Utils.symmetric(v: 12.0, h: 0.0).copyWith(bottom: 0.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFDBDBDB)),
          borderRadius: Utils.borderRadius(),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CustomImage(
            path: icon,
            fit: BoxFit.fill,
            height: 30.0,
            width: 130.0,
          ),
        ),
      ),
    );
  }
}
