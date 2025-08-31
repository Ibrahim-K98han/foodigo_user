import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/address/cubit/get_address_cubit.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../../features/Cart/cubit/cart_cubit.dart';
import '../../../../features/address/model/address_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/k_images.dart';
import '../../../../utils/utils.dart';
import '../../../core/routes/route_names.dart';
import '../my_cart_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, });


  @override
  Widget build(BuildContext context) {
    final order = context.read<CartCubit>();
    final Address? selectedAddress =
    ModalRoute.of(context)?.settings.arguments as Address?;
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
                ...List.generate(order.cartModel!.cartItems!.length, (index) {
                  final orderItem = order.cartModel!.cartItems![index];
                  return Padding(
                    padding: Utils.only(bottom: 10.0),
                    child: CheckoutCart(
                      cartItem: orderItem,
                      onDelete: (id) {
                        context.read<CartCubit>().deleteProduct(id);
                      },
                    ),
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
                              Flexible(
                                child: CustomText(
                                  text: selectedAddress?.address ?? 'No address selected',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF334155),
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
                        SummaryField(
                          title: 'Sub Total',
                          subTitle: '\$${order.cartModel!.subtotal}',
                        ),
                         SummaryField(
                          title: 'Extra Addons',
                          subTitle: ''
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
