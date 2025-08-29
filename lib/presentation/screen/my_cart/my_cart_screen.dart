import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/Cart/cubit/cart_cubit.dart';
import 'package:foodigo/features/Cart/cubit/cart_state.dart';
import 'package:foodigo/features/Cart/model/cart_model.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../core/routes/route_names.dart';

class MyCartScreen extends StatefulWidget {
  const MyCartScreen({super.key});

  @override
  State<MyCartScreen> createState() => _MyCartScreenState();
}

class _MyCartScreenState extends State<MyCartScreen> {
  late CartCubit cartCubit;

  @override
  void initState() {
    super.initState();
    cartCubit = context.read<CartCubit>();
    cartCubit.getCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Carts',
        visibleLeading: false,
        action: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert), // The three-dot icon
            onSelected: (String value) {
              // Handle selection
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected: $value')),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                  value: 'Clear All',
                  child: CustomText(
                    text: 'Clear All',
                    color: Colors.red,
                  )),
            ],
          ),
        ],
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is CartError) {
            FetchErrorText(
              text: state.message,
            );
          }
        },
        builder: (context, state) {
          if (state is CartLoading) {
            return const LoadingWidget();
          } else if (state is CartError) {
            if (state.statusCode == 503 || cartCubit.cartModel != null) {
              return CartDataLoaded(
                cartModel: cartCubit.cartModel!,
              );
            } else {
              return FetchErrorText(text: state.message);
            }
          } else if (state is CartLoaded) {
            return CartDataLoaded(
              cartModel: cartCubit.cartModel!,
            );
          }
          if (cartCubit.cartModel != null) {

            return CartDataLoaded(
              cartModel: cartCubit.cartModel!,
            );
          } else {
            return const FetchErrorText(text: 'Something Went Wrong');
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 4.0),
        child: PrimaryButton(
            text: 'Checkout',
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.orderScreen);
            }),
      ),
    );
  }
}

class CartDataLoaded extends StatelessWidget {
  const CartDataLoaded({super.key, required this.cartModel});

  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: Utils.symmetric(),
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
          child: (cartModel.cartItems != null &&
                  cartModel.cartItems!.isNotEmpty)
              ? Column(
                  children: List.generate(cartModel.cartItems!.length, (index) {
                    final cartItem = cartModel.cartItems![index];
                    return Padding(
                      padding: Utils.only(bottom: 12.0),
                      child: CheckoutCart(cartItem: cartItem),
                    );
                  }),
                )
              : const Center(
                  child: CustomImage(path: KImages.cartNotFound),
                ),
        ),
      ],
    );
  }
}

class CheckoutCart extends StatelessWidget {
  CheckoutCart({
    super.key,
    required this.cartItem,
  });

  final CartItems cartItem;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Container(
      padding: Utils.symmetric(h: 8.0, v: 4.0),
      height: size.height * 0.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0), color: whiteColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 92.0,
            height: 72.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              shape: BoxShape.rectangle,
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CustomImage(
                  path: RemoteUrls.imageUrl(cartItem.product.image),
                  fit: BoxFit.cover,
                )),
          ),
          Flexible(
            child: Padding(
              padding: Utils.only(left: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: CustomText(
                      text: cartItem.product.name,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      maxLine: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: Utils.formatPrice(context, cartItem.sizePrice),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE94222),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              shape: BoxShape.rectangle,
                              color: primaryColor.withOpacity(0.2),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          Utils.horizontalSpace(8.0),
                          const CustomText(
                            text: '1',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          Utils.horizontalSpace(8.0),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              shape: BoxShape.rectangle,
                              color: primaryColor,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: blackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
