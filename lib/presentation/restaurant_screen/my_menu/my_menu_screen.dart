import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/restaurant_features/Category/cubit/res_categories_cubit.dart';
import 'package:foodigo/features/restaurant_features/Category/cubit/res_categories_state.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/cubit/store_product_cubit.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/page_refresh.dart';
import '../../../features/restaurant_features/Products/cubit/product_cubit.dart';
import '../../../features/restaurant_features/Products/cubit/product_state.dart';
import '../../../features/restaurant_features/Products/model/product_model.dart';
import '../../../utils/constraints.dart';
import '../../../utils/utils.dart';
import '../../core/routes/route_names.dart';
import 'components/my_menu_cart.dart';

class MyMenuScreen extends StatefulWidget {
  const MyMenuScreen({super.key});

  @override
  State<MyMenuScreen> createState() => _MyMenuScreenState();
}

class _MyMenuScreenState extends State<MyMenuScreen> {
  late ResCategoriesCubit resCatCubit;
  late ProductCubit pCubit;

  @override
  void initState() {
    super.initState();
    resCatCubit = context.read<ResCategoriesCubit>();
    pCubit = context.read<ProductCubit>();
    pCubit.getProduct();
    resCatCubit.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Food Menu',
        visibleLeading: false,
      ),
      body: PageRefresh(
        onRefresh: () async {
          pCubit.getProduct();
        },
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              if (pCubit.productModel != null) {
                return LoadFoodMenuData(productModel: pCubit.productModel!);
              }
              return const LoadingWidget();
            } else if (state is ProductLoaded) {
              return LoadFoodMenuData(productModel: state.productModel);
            } else if (state is ProductError) {
              if (pCubit.productModel != null) {
                return LoadFoodMenuData(productModel: pCubit.productModel!);
              }
              return FetchErrorText(text: state.message);
            } else {
              if (pCubit.productModel != null) {
                return LoadFoodMenuData(productModel: pCubit.productModel!);
              }
              return const FetchErrorText(text: "Something went wrong");
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<StoreProductCubit>().clear();
          Navigator.pushNamed(context, RouteNames.editFoodScreen,
              arguments: '');
        },
        backgroundColor: redColor,
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}

class LoadFoodMenuData extends StatefulWidget {
  const LoadFoodMenuData({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<LoadFoodMenuData> createState() => _LoadFoodMenuDataState();
}

class _LoadFoodMenuDataState extends State<LoadFoodMenuData> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: borderColor,
                ),
              ),
            ),
            child: BlocBuilder<ResCategoriesCubit, ResCategoriesState>(
              builder: (context, state) {
                if (state is ResCategoriesLoading) {
                  return const LoadingWidget();
                } else if (state is ResCategoriesLoaded) {
                  final categories = state.categoryModel.resCategories;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        categories!.length,
                        (index) {
                          final active = _currentIndex == index;
                          return GestureDetector(
                            onTap: () => setState(() => _currentIndex = index),
                            child: AnimatedContainer(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: active
                                          ? const Color(0xFFE94222)
                                          : Colors.transparent,
                                      width: 2),
                                ),
                              ),
                              duration: const Duration(seconds: 0),
                              padding: Utils.symmetric(v: 8.0, h: 12.0),
                              child: CustomText(
                                text: categories[index].name,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                fontFamily: regular400,
                                color: active ? redColor : blackColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (state is ResCategoriesError) {
                  return Center(
                    child: CustomText(text: 'Error: ${state.message}'),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
        Expanded(
          child: Container(
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
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const LoadingWidget();
                } else if (state is ProductLoaded) {
                  final categories = context.read<ResCategoriesCubit>().state;
                  String selectedCategoryId = '';
                  if (categories is ResCategoriesLoaded) {
                    selectedCategoryId = categories
                        .categoryModel.resCategories![_currentIndex].id
                        .toString();
                  }
                  final products = context
                      .read<ProductCubit>()
                      .filterByCategory(selectedCategoryId);
                  if (products.isEmpty) {
                    return const Center(
                        child: CustomText(text: "No products found"));
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.80,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      crossAxisCount: 2,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, int index) {
                      final product = products[index];
                      return MyMenuCart(productList: product, index: index);
                    },
                  );
                } else if (state is ProductError) {
                  return Center(
                      child: CustomText(text: "Error: ${state.message}"));
                }
                return const SizedBox();
              },
            ),
          ),
        )
      ],
    );
  }
}
