import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/Cart/model/cart_model.dart';
import 'package:foodigo/features/checkout/model/checkout_response_model.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/presentation/screen/my_cart/components/summary_filed.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/primary_button.dart';

class OrderSummaryBottomSheet extends StatefulWidget {
  final CheckoutResponseModel checkoutResponseModel;
  final CartModel cartModel;

  const OrderSummaryBottomSheet({
    super.key,
    required this.checkoutResponseModel,
    required this.cartModel,
  });

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
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Order Summary',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                Utils.verticalSpace(4),
                const Divider(color: Color(0xFFF1F5F9)),
                Utils.verticalSpace(4),
                SummaryField(
                  title: 'Sub Total',
                  subTitle:
                      '${widget.checkoutResponseModel.checkoutData!.pricingBreakdown.subtotal}',
                ),
              
                SummaryField(
                  title: 'Fee and Delivery',
                  subTitle:
                      '\$${widget.checkoutResponseModel.checkoutData!.pricingBreakdown.deliveryFee}',
                ),
                SummaryField(
                  title: 'Vat',
                  subTitle:
                      widget
                          .checkoutResponseModel
                          .checkoutData!
                          .pricingBreakdown
                          .taxRate,
                ),
                SummaryField(
                  title: 'Discount Amount',
                  subTitle:
                      '\$${widget.checkoutResponseModel.checkoutData!.pricingBreakdown.couponDiscount}',
                ),
                Utils.verticalSpace(4),
                const Divider(color: Color(0xFFF1F5F9)),
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
                ),
              ],
            ),
          ),
          Utils.verticalSpace(16),
          PrimaryButton(
            text: 'Pay Now',
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteNames.paymentMethodScreen,
                arguments: widget.checkoutResponseModel,
              );
            },
          ),
        ],
      ),
    );
  }
}
