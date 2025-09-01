import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/Cart/cubit/cart_cubit.dart';
import 'package:foodigo/features/Cart/cubit/cart_state.dart';
import 'package:foodigo/features/Cart/model/cart_model.dart';
import 'package:foodigo/features/Cart/model/cart_state_model.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
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
              PopupMenuItem<String>(
                value: 'Clear All',
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                   cartCubit.clearCart();
                  },
                  child: const CustomText(
                    text: 'Clear All',
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocConsumer<CartCubit, CartStateModel>(
        listener: (context, state) {
          if (state.cartState is CartDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product removed from cart')),
            );
          }
          if (state.cartState is CartError) {
            final error = state.cartState as CartError;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error.message)),
            );
          }
        },
        builder: (context, state) {
          if (state.cartState is CartLoading ||
              state.cartState is CartInitial) {
            return const LoadingWidget();
          }

          if (state.cartState is CartLoaded) {
            final cart = (state.cartState as CartLoaded).cartModel;
            return CartDataLoaded(cartModel: cart);
          }

          if (state.cartState is CartDeleteSuccess) {
            final cart = (state.cartState as CartDeleteSuccess).updatedCart;
            return CartDataLoaded(cartModel: cart);
          }

          if (state.cartState is CartIncrementSuccess) {
            final cart = (state.cartState as CartIncrementSuccess).updatedCart;
            return CartDataLoaded(cartModel: cart);
          }

          if (state.cartState is CartDecrementSuccess) {
            final cart = (state.cartState as CartDecrementSuccess).updatedCart;
            return CartDataLoaded(cartModel: cart);
          }

          return const Center(child: CustomImage(path: KImages.cartNotFound));
        },
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 4.0),
        child: PrimaryButton(
            text: 'Checkout',
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.addressScreen);
            }),
      ),
    );
  }
}

class CartDataLoaded extends StatefulWidget {
  const CartDataLoaded({super.key, required this.cartModel});

  final CartModel cartModel;

  @override
  State<CartDataLoaded> createState() => _CartDataLoadedState();
}

class _CartDataLoadedState extends State<CartDataLoaded> {
  late List<CartItems> items;

  @override
  void initState() {
    super.initState();
    items = List.from(widget.cartModel.cartItems ?? []);
  }

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
          child: (widget.cartModel.cartItems != null &&
                  widget.cartModel.cartItems!.isNotEmpty)
              ? Column(
                  children: List.generate(widget.cartModel.cartItems!.length,
                      (index) {
                    final cartItem = widget.cartModel.cartItems![index];
                    return Padding(
                      padding: Utils.only(bottom: 12.0),
                      child: CheckoutCart(
                        cartItem: cartItem,
                        onDelete: (id) {
                          context.read<CartCubit>().deleteProduct(id);
                        },
                      ),
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
    required this.onDelete,
  });

  final CartItems cartItem;
  final Function(String productId) onDelete;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final Product? product = cartItem.product;
    final productId = product?.id ?? cartItem.cartId;
    final cartCubit = context.read<CartCubit>();
    return Dismissible(
      key: ValueKey(product?.id ?? cartItem.cartId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            title: const CustomText(
              text: 'Delete Item',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            content: const CustomText(
              text: 'Are you sure you want to remove this item from the cart?',
              fontSize: 14,
            ),
            actions: [
              PrimaryButton(
                minimumSize: Size(90.w, 40.h),
                text: 'Cancel',
                fontSize: 14.sp,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              PrimaryButton(
                  fontSize: 14.sp,
                  minimumSize: Size(90.w, 40.h),
                  text: 'Delete',
                  onPressed: () {
                    Navigator.pop(context, true);
                  })
            ],
          ),
        );
      },
      onDismissed: (direction) {
        onDelete(product?.id.toString() ?? cartItem.cartId.toString());
      },
      child: Container(
        padding: Utils.symmetric(h: 8.0, v: 4.0),
        height: size.height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: whiteColor,
        ),
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
                  path: product != null
                      ? RemoteUrls.imageUrl(product.image)
                      : KImages.foodImage1,
                  fit: BoxFit.cover,
                ),
              ),
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
                        text: product?.name ?? 'Unknown Product',
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
                          color: const Color(0xFFE94222),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                cartCubit
                                    .decrementProduct(productId.toString());
                              },
                              child: Container(
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
                            ),
                            Utils.horizontalSpace(8.0),
                            CustomText(
                              text: cartItem.qty.toString(),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            Utils.horizontalSpace(8.0),
                            GestureDetector(
                              onTap: () {
                                cartCubit
                                    .incrementProduct(productId.toString());
                              },
                              child: Container(
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
      ),
    );
  }
}
