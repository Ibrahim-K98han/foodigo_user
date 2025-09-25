import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/restaurant_features/Addons/cubit/res_addons_cubit.dart';
import 'package:foodigo/features/restaurant_features/Category/cubit/res_categories_cubit.dart';
import 'package:foodigo/features/restaurant_features/Products/cubit/product_state.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/cubit/store_product_cubit.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/cubit/store_product_state.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/model/store_product_state_model.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/presentation/restaurant_screen/my_menu/components/category_info_widget.dart';
import 'package:foodigo/presentation/restaurant_screen/my_menu/components/photo_info_widget.dart';
import 'package:foodigo/presentation/restaurant_screen/my_menu/components/price_info_widget.dart';
import 'package:foodigo/presentation/restaurant_screen/my_menu/components/product_info_widget.dart';
import 'package:foodigo/presentation/restaurant_screen/my_menu/components/specification_info_widget.dart';
import 'package:foodigo/presentation/restaurant_screen/my_menu/components/variation_info_widget.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/primary_button.dart';

class EditFoodScreen extends StatefulWidget {
  const EditFoodScreen({super.key, required this.id});

  final String id;

  @override
  State<EditFoodScreen> createState() => _EditFoodScreenState();
}

class _EditFoodScreenState extends State<EditFoodScreen> {
  late StoreProductCubit stCubit;

  @override
  void initState() {
    super.initState();
    stCubit = context.read<StoreProductCubit>();
    if (widget.id.isNotEmpty) {
      stCubit.getEditProduct(widget.id.toString());
    }
    // else {
    //   stCubit.clear();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: widget.id.isNotEmpty ? 'Edit Food' : 'Upload Food'),
      body: BlocConsumer<StoreProductCubit, StoreProductStateModel>(
        listener: (context, state) {
          final edit = state.storeProductState;
          if (edit is EditProductError) {
            if (edit.statusCode == 503 || stCubit.products != null) {
              stCubit.getEditProduct(widget.id);
            }
          }
        },
        builder: (context, state) {
          final edit = state.storeProductState;
          if (edit is EditProductLoading) {
            return const LoadingWidget();
          } else if (edit is EditProductError) {
            if (edit.statusCode == 503 || stCubit.products != null) {
              return LoadEditData(
                id: widget.id,
              );
            } else {
              return FetchErrorText(text: edit.message);
            }
          } else if (edit is EditProductLoaded) {
            return LoadEditData(
              id: widget.id,
            );
          }
          if (stCubit.products != null) {
            return LoadEditData(
              id: widget.id,
            );
          } else {
            return LoadEditData(
              id: widget.id,
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: BlocConsumer<StoreProductCubit, StoreProductStateModel>(
          listener: (context, state) {
            final update = state.storeProductState;
            if (update is StoreProductLoading) {
              Utils.loadingDialog(context);
            } else {
              Future.delayed(const Duration(seconds: 1), () {
                if (mounted) {
                  // Check if the widget is still mounted
                  Utils.closeDialog(context); // Close the dialog after 2 seconds
                }
              }
              );
              if(update is StoreProductError){
                Utils.errorSnackBar(context, update.message);
              }else if(update is StoreProductSuccess){
                Utils.showSnackBar(context, update.response.message);
                Future.delayed(const Duration(seconds: 1),(){
                  Navigator.of(context).pop(true);
                });
              }
            }
          },
          builder: (context, state) {
            return PrimaryButton(
              text: widget.id.isNotEmpty ? 'Update' : 'Upload',
              onPressed: () {
                if (widget.id.isNotEmpty) {
                  stCubit.updateProduct(widget.id.toString());
                  Navigator.pushNamed(context, RouteNames.myMenuScreen);
                } else {
                  stCubit.storeProduct();
                  Navigator.pushNamed(context, RouteNames.myMenuScreen);
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class LoadEditData extends StatefulWidget {
  const LoadEditData({super.key, required this.id});

  final String id;

  @override
  State<LoadEditData> createState() => _LoadEditDataState();
}

class _LoadEditDataState extends State<LoadEditData> {
  String? selectedAddonValue;
  late ResCategoriesCubit resCatCubit;
  late ResAddonsCubit resAddonCubit;
  late StoreProductCubit stCubit;

  @override
  void initState() {
    super.initState();
    resCatCubit = context.read<ResCategoriesCubit>();
    resCatCubit.getCategories();
    resAddonCubit = context.read<ResAddonsCubit>();
    resAddonCubit.getAddon();
    stCubit = context.read<StoreProductCubit>();
    // stCubit.getEditProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.id.isNotEmpty) {
    //   stCubit.translateId(stCubit.translateProduct!.id.toString());
    // }
    return Padding(
      padding: Utils.symmetric(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// Product Info
            const ProductInfoWidget(),
            Utils.verticalSpace(12),

            /// Category Info
            const CategoryInfoWidget(),
            Utils.verticalSpace(12),

            /// Price Info
            const PriceInfoWidget(),
            Utils.verticalSpace(12),

            /// Variations
            const VariationInfoWidget(),
            Utils.verticalSpace(12),

            /// Specification
            const SpecificationInfoWidget(),
            Utils.verticalSpace(12),

            /// Photo Attachment
            const PhotoInfoWidget(),
          ],
        ),
      ),
    );
  }
}
