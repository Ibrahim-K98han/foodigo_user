import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/Cart/cubit/cart_cubit.dart';
import 'package:foodigo/features/Cart/cubit/cart_state.dart';
import 'package:foodigo/features/Cart/model/cart_model.dart';
import 'package:foodigo/features/add_to_cart/cubit/add_cart_cubit.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../features/Cart/model/cart_state_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../core/routes/route_names.dart';
import '../product_details/product_details_screen.dart';

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
        title: 'My Cart',
        visibleLeading: false,
        action: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (String value) {},
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Clear All',
                    child: GestureDetector(
                      onTap: () {
                        cartCubit.clearCart();
                        Navigator.pop(context);
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
          if (state.cartState is CartError) {
            final error = state.cartState as CartError;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error.message)));
          }
        },
        builder: (context, state) {
          if (state.cartState is CartLoading) {
            return const LoadingWidget();
          }

          if (state.cartState is CartLoaded) {
            final cart = (state.cartState as CartLoaded).cartModel;
            if (cart.cartItems == null || cart.cartItems!.isEmpty) {
              return const Center(
                child: CustomImage(path: KImages.cartNotFound),
              );
            }
            return CartDataLoaded(cartModel: cart);
          }

          if (state.cartState is CartDeleteSuccess) {
            final cart = (state.cartState as CartDeleteSuccess).updatedCart;
            if (cart.cartItems == null || cart.cartItems!.isEmpty) {
              return const Center(
                child: CustomImage(path: KImages.cartNotFound),
              );
            }
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

          if (state.cartState is CartError) {
            return const Center(child: CustomImage(path: KImages.cartNotFound));
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartStateModel>(
        builder: (context, state) {
          CartModel? cart;

          if (state.cartState is CartLoaded) {
            cart = (state.cartState as CartLoaded).cartModel;
          } else if (state.cartState is CartDeleteSuccess) {
            cart = (state.cartState as CartDeleteSuccess).updatedCart;
          } else if (state.cartState is CartIncrementSuccess) {
            cart = (state.cartState as CartIncrementSuccess).updatedCart;
          } else if (state.cartState is CartDecrementSuccess) {
            cart = (state.cartState as CartDecrementSuccess).updatedCart;
          }

          if (cart != null &&
              cart.cartItems != null &&
              cart.cartItems!.isNotEmpty) {
            return Padding(
              padding: Utils.symmetric(v: 4.0),
              child: PrimaryButton(
                text: 'Checkout',
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RouteNames.addressScreen,
                    arguments: {'isSelected': true},
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class CartDataLoaded extends StatelessWidget {
  const CartDataLoaded({super.key, required this.cartModel});

  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    final items = cartModel.cartItems ?? [];

    if (items.isEmpty) {
      return const Center(child: CustomImage(path: KImages.cartNotFound));
    }

    return ListView(
      padding: Utils.symmetric(),
      children:
          items.map((cartItem) {
            return Padding(
              padding: Utils.only(bottom: 12.0),
              child: CheckoutCart(
                cartItem: cartItem,
                onDelete: (id) {
                  context.read<CartCubit>().deleteProduct(id);
                },
              ),
            );
          }).toList(),
    );
  }
}

class CheckoutCart extends StatelessWidget {
  const CheckoutCart({
    super.key,
    required this.cartItem,
    required this.onDelete,
  });

  final CartItems cartItem;
  final Function(String productId) onDelete;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final product = cartItem.product;
    final productId = cartItem.productId;
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
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder:
              (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                title: const CustomText(
                  text: 'Delete Item',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                content: const CustomText(
                  text:
                      'Are you sure you want to remove this item from the cart?',
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
                      context.read<AddCartCubit>().clear();
                      Navigator.pop(context, true);
                    },
                  ),
                ],
              ),
        );
      },
      onDismissed: (direction) {
        onDelete(product?.id.toString() ?? cartItem.cartId.toString());
      },
      child: GestureDetector(
        onTap: () {
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
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Utils.radius(10.0)),
                topRight: Radius.circular(Utils.radius(10.0)),
              ),
            ),
            builder: (context) {
              return DraggableScrollableSheet(
                initialChildSize: 0.85,
                minChildSize: 0.5,
                maxChildSize: 0.95,
                expand: false,
                builder: (context, scrollController) {
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: ProductDetailsScreen(
                      id: cartItem.productId,
                      inInCart: true,
                    ),
                  );
                },
              );
            },
          );
        },
        child: Container(
          padding: Utils.symmetric(h: 8.0, v: 4.0),
          height: size.height * 0.1,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
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
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CustomImage(
                    path:
                        product != null
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
                          text: product?.name ?? 'Product name not available',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          maxLine: 2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: '${cartItem.size} (\$${cartItem.sizePrice})',
                            fontSize: 14,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap:
                                    () => cartCubit.decrementProduct(
                                      productId.toString(),
                                    ),
                                child: Container(
                                  height: 24.h,
                                  width: 24.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
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

                              Padding(
                                padding: Utils.symmetric(h: 10, v: 0),
                                child: CustomText(
                                  text: cartItem.qty.toString(),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              GestureDetector(
                                onTap:
                                    () => cartCubit.incrementProduct(
                                      productId.toString(),
                                    ),
                                child: Container(
                                  height: 24.h,
                                  width: 24.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
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
                      CustomText(
                        text: 'Addon Price (\$${cartItem.addonPrice})',
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
