import 'package:flutter/material.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../core/routes/route_names.dart';
import '../my_cart_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Order Now"),
      body: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 40,
              offset: Offset(0, 2),
              spreadRadius: 10,
            )
          ],
        ),
        child: Padding(
          padding: Utils.symmetric(),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                ...List.generate(2, (index) {
                  return Padding(
                    padding: Utils.only(bottom: 10.0),
                    child: const CheckoutCart(),
                  );
                }),
                Utils.verticalSpace(10.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: borderColor),
                    borderRadius: Utils.borderRadius(),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: transparent),
                    child: ExpansionTile(
                      iconColor: blackColor,
                      title: const CustomText(
                        text: 'Delivery to',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        Padding(
                          padding: Utils.all(value: 10.0),
                          child: Row(
                            children: [
                              const Flexible(
                                child: CustomText(
                                  text: 'Sulfat Street 131366 Pluto. Cyber Arm',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF334155),
                                  maxLine: 3,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, RouteNames.addressScreen);
                                },
                                child: const CustomText(
                                  text: "Change Address",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Color(0xFFE94222),
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Utils.verticalSpace(10.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: borderColor),
                    borderRadius: Utils.borderRadius(),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: transparent),
                    child: ExpansionTile(
                      iconColor: blackColor,
                      childrenPadding: Utils.symmetric(h: 12.0, v: 10.0),
                      title: const CustomText(
                        text: 'Payment Summary',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        const SummaryField(
                          title: 'Sub Total',
                          subTitle: "\$57.92",
                        ),
                        const SummaryField(
                          title: 'Extra Addons',
                          subTitle: "\$10.92",
                        ),
                        const SummaryField(
                          title: 'Fee and Delivery',
                          subTitle: "\$10.92",
                        ),
                        Utils.verticalSpace(10.0),
                        Container(
                          height: 0.5,
                          width: double.infinity,
                          color: borderColor,
                        ),
                        Utils.verticalSpace(10.0),
                        const SummaryField(
                          title: 'Total Price',
                          subTitle: "\$89.92",
                        ),
                      ],
                    ),
                  ),
                ),
                Utils.verticalSpace(10.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    border: Border.all(color: borderColor),
                    borderRadius: Utils.borderRadius(),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: transparent),
                    child: ExpansionTile(
                      iconColor: blackColor,
                      childrenPadding: Utils.symmetric(h: 12.0, v: 10.0),
                      title: const CustomText(
                        text: 'Payment Methods',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CustomImage(path: KImages.paypal),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteNames.paymentMethodScreen);
                              },
                              child: const CustomText(
                                text: "Change",
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Color(0xFFE94222),
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Utils.verticalSpace(12.0),
                CustomFormWidget(
                  label: 'Special instructions',
                  labelColor: const Color(0xFF0C1321),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'comments', fillColor: whiteColor),
                    maxLines: 4,
                  ),
                ),
                Utils.verticalSpace(10.0),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: PrimaryButton(
            text: 'Order Now',
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.paymentMethodScreen);
            }),
      ),
    );
  }
}

class SummaryField extends StatelessWidget {
  const SummaryField({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
            text: title,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF334155)),
        CustomText(text: subTitle, fontSize: 14, fontWeight: FontWeight.w600),
      ],
    );
  }
}
