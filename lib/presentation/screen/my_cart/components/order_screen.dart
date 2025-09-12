import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/ApplyCoupon/cubit/apply_coupon_cubit.dart';
import 'package:foodigo/features/checkout/cubit/checkout_cubit.dart';
import 'package:foodigo/features/checkout/model/checkout_response_model.dart';
import 'package:foodigo/features/checkout/model/checkout_state_model.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../../features/Cart/cubit/cart_cubit.dart';
import '../../../../features/address/model/address_model.dart';
import '../../../../features/checkout/cubit/checkout_state.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../core/routes/route_names.dart';
import '../my_cart_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({
    super.key,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String? selectedOrderType;
  final List<String> orderTypeValue = ['delivery', 'pickup'];

  late CheckoutCubit checkoutCubit;
  late ApplyCouponCubit applyCouponCubit;

  @override
  void initState() {
    super.initState();
    checkoutCubit = context.read<CheckoutCubit>();
    applyCouponCubit = context.read<ApplyCouponCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final order = context.read<CartCubit>();
    final address = ModalRoute.of(context)!.settings.arguments as Address;
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
                                  text: address.address,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF334155),
                                  maxLine: 3,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.addressScreen,
                                    arguments: {
                                      'isSelected': true,
                                    },
                                  );
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
                        text: 'Coupon & Order Type',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: 'Order Type',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            Utils.verticalSpace(4),
                            DropdownButtonFormField<String>(
                              dropdownColor: whiteColor,
                              value: selectedOrderType,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                              ),
                              hint: const CustomText(
                                  text: 'Delivery Type', color: lightGrayColor),
                              items: orderTypeValue.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: CustomText(text: value, fontSize: 14),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  checkoutCubit.orderType(newValue!);
                                });
                              },
                              validator: (value) => value == null
                                  ? 'Please select an option'
                                  : null,
                            ),
                            Utils.verticalSpace(8),
                            const CustomText(
                              text: 'Coupon',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                applyCouponCubit.couponCode(value);
                              },
                              decoration: InputDecoration(
                                contentPadding: Utils.symmetric(v: 12.0),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    applyCouponCubit.applyCoupon();
                                  },
                                  child: Container(
                                    width: 80.w,
                                    height: 36.h,
                                    margin: Utils.symmetric(v: 4.0, h: 4.0),
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF0C1321),
                                        borderRadius:
                                            BorderRadius.circular(6.r)),
                                    child: const Center(
                                      child: CustomText(
                                        text: 'Apply',
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Utils.verticalSpace(10.0),
                Utils.verticalSpace(12.0),
                CustomFormWidget(
                  label: 'Special instructions',
                  labelColor: const Color(0xFF0C1321),
                  child: TextFormField(
                    onChanged: (value) {
                      checkoutCubit.deliveryInstruction(value);
                    },
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
        child: BlocListener<CheckoutCubit, CheckoutStateModel>(
          listener: (context, state) {
            final cart = state.checkoutState;
            if (cart is CheckoutStateLoading) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (cart is CheckoutStateError) {
                Utils.showSnackBar(context, cart.message);
              } else if (cart is CheckoutStateSuccess) {
                showModalBottomSheet(
                  context: context,
                  showDragHandle: true,
                  backgroundColor: whiteColor,
                  constraints: BoxConstraints.loose(
                    Size(
                      Utils.mediaQuery(context).width,
                      Utils.mediaQuery(context).height * 0.9,
                    ),
                  ),
                  isScrollControlled: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Utils.radius(20.0)),
                      topRight: Radius.circular(Utils.radius(20.0)),
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
                        child: OrderSummaryBottomSheet(
                          checkoutResponseModel: cart.checkoutResponseModel,
                        ),
                      );
                    },
                  ),
                );
              }
            }
          },
          child: PrimaryButton(
              text: "Order Now",
              onPressed: () {
                checkoutCubit.checkOut(address.id.toString());
              }),
        ),
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

class OrderSummaryBottomSheet extends StatefulWidget {
  final CheckoutResponseModel checkoutResponseModel;

  const OrderSummaryBottomSheet(
      {super.key, required this.checkoutResponseModel});

  @override
  State<OrderSummaryBottomSheet> createState() =>
      _OrderSummaryBottomSheetState();
}

class _OrderSummaryBottomSheetState extends State<OrderSummaryBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(h: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: Utils.symmetric(h: 12.0, v: 8.0),
            decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(6.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Order Summary',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                Utils.verticalSpace(4),
                const Divider(
                  color: Color(0xFFF1F5F9),
                ),
                Utils.verticalSpace(4),
                SummaryField(
                  title: 'Sub Total',
                  subTitle:
                      '${widget.checkoutResponseModel.checkoutData!.pricingBreakdown.subtotal}',
                ),
                // SummaryField(
                //   title: 'Extra Addon (3)',
                //   subTitle: ,
                // ),
                SummaryField(
                  title: 'Fee and Delivery',
                  subTitle:
                      '\$${widget.checkoutResponseModel.checkoutData!.pricingBreakdown.deliveryFee}',
                ),
                SummaryField(
                  title: 'Vat',
                  subTitle: widget.checkoutResponseModel.checkoutData!
                      .pricingBreakdown.taxRate,
                ),
                SummaryField(
                  title: 'Discount Amount',
                  subTitle:
                      '\$${widget.checkoutResponseModel.checkoutData!.pricingBreakdown.couponDiscount}',
                ),
                Utils.verticalSpace(4),
                const Divider(
                  color: Color(0xFFF1F5F9),
                ),
                Utils.verticalSpace(4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      text: 'Total Price',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text:
                          '\$${widget.checkoutResponseModel.checkoutData!.pricingBreakdown.totalAmount}',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                )
              ],
            ),
          ),
          Utils.verticalSpace(16),
          PrimaryButton(
            text: 'Pay Now',
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.paymentMethodScreen,
                  arguments: widget.checkoutResponseModel);
            },
          )
        ],
      ),
    );
  }
}
