import 'package:flutter/material.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';

import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../../widget/primary_button.dart';
import '../../core/routes/route_names.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String selectedMethod = 'Razorpay'; // default selected method

  final List<Map<String, dynamic>> paymentMethods = [
    {'logo': KImages.paypal},
    {'logo': KImages.paypal},
    {'logo': KImages.paypal},
    {'logo': KImages.paypal},
    {'logo': KImages.paypal},
    {'logo': KImages.paypal},
    {'logo': KImages.paypal},
    {'logo': KImages.paypal},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFD),
      appBar: const CustomAppBar(title: 'Payment Method', visibleLeading: true),
      body: Padding(
        padding: Utils.symmetric(h: 20.0),
        child: Column(
          children: [
            const Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: 'Select the payment method want to use',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  final method = paymentMethods[index];
                  final isSelected = selectedMethod == method['logo'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedMethod = method['logo'];
                      });
                    },
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color:
                                isSelected ? Colors.green : Colors.transparent,
                            width: 1.5,
                          ),
                        ),
                        child: CustomImage(path: method['logo'])),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actions: [
                            Column(
                              children: [
                                Utils.verticalSpace(20.0),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                const CustomImage(path: KImages.orderSuccess),
                                const CustomText(
                                  textAlign: TextAlign.center,
                                  text: 'Thank you! for Order Successfully',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                                Utils.verticalSpace(16.0),
                                PrimaryButton(
                                  bgColor: blackColor,
                                  text: 'Track your order',
                                  textColor: whiteColor,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RouteNames.trackOrderScreen);
                                  },
                                )
                              ],
                            ),
                          ],
                        );
                      });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content:
                            Text("Payment method updated to $selectedMethod")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Updated now",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
