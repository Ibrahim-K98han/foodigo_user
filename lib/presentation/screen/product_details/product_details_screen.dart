import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/HomeData/feature_product_model.dart';
import 'package:foodigo/features/ProductDetails/cubit/product_details_cubit.dart';
import 'package:foodigo/features/ProductDetails/cubit/product_details_state.dart';
import 'package:foodigo/features/add_to_cart/cubit/add_cart_cubit.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/loading_widget.dart';

import '../../../features/add_to_cart/model/add_cart_state_model.dart';
import '../../../utils/utils.dart';
import 'component/add_to_cart_button.dart';
import 'component/amount_name_rating_section.dart';
import 'component/image_section.dart';
import 'component/select_addon_section.dart';
import 'component/select_size_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.id});

  final int id;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late ProductDetailsCubit productDetailsCubit;

  @override
  void initState() {
    super.initState();
    productDetailsCubit = context.read<ProductDetailsCubit>();
    productDetailsCubit.getProductDetailsData(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
      listener: (context, state) {
        if (state is ProductDetailsError) {
          FetchErrorText(
            text: state.message,
          );
        }
      },
      builder: (BuildContext context, ProductDetailsState state) {
        if (state is ProductDetailsLoading) {
          return const LoadingWidget();
        } else if (state is ProductDetailsError) {
          return FetchErrorText(text: state.message);
        } else if (state is ProductDetailsLoaded) {
          return ProductDetailData(
            featuredProducts: productDetailsCubit.featuredProducts!,
          );
        }
        return const Center(child: Text("Something went wrong"));
      },
    );
  }
}

class ProductDetailData extends StatelessWidget {
  const ProductDetailData({super.key, required this.featuredProducts});

  final FeaturedProducts featuredProducts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///=================== Product Details ====================///
        ImageSection(
          image: RemoteUrls.imageUrl(featuredProducts.image),
          featuredProducts: featuredProducts,
        ),
        Padding(
          padding: Utils.symmetric(v: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///================ Product Amount Name And Rating ===========///
              const AmountNameRatingSection(),

              ///================ Select Product Size Dropdown ==============///
              const SelectSizeSection(),

              ///=============== Select Addon Dropdown ======================///
              Utils.verticalSpace(10),
              const SelectAddonSection(),

              ///=============== Add To Cart Button ========================///
              BlocBuilder<AddCartCubit, AddCartStateModel>(
                builder: (context, state) {
                  final addCartCubit = context.read<AddCartCubit>();
                  return AddToCartButton(
                    text: state.qty.toString(),
                    decrementBtn: () => addCartCubit.decrementQty(),
                    incrementBtn: () => addCartCubit.incrementQty(),
                    addToCartBtn: () async {
                      /// Check if size is selected
                      if (state.size.isEmpty) {
                        Navigator.pop(context);
                        Utils.failureSnackBar(
                            context, 'Please Select Item Size First');
                        return;
                      }

                      /// Add to cart
                      await addCartCubit.addCart(context, featuredProducts.id);

                      /// Only pop if addCartResponseModel is not null
                      if (addCartCubit.addCartResponseModel != null) {
                        Navigator.pop(context);
                        Utils.successSnackBar(
                            context, 'Successfully added to cart');
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
