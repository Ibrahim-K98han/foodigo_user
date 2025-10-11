import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/restaurant_features/StoreProduct/cubit/store_product_cubit.dart';
import '../../../../features/restaurant_features/StoreProduct/model/store_product_state_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_form.dart';
import '../../restaurant_profile/component/update_product_tile.dart';

class ProductInfoWidget extends StatefulWidget {
  const ProductInfoWidget({super.key});

  @override
  State<ProductInfoWidget> createState() => _ProductInfoWidgetState();
}

class _ProductInfoWidgetState extends State<ProductInfoWidget> {
  late StoreProductCubit stCubit;
  @override
  void initState() {
    super.initState();
    stCubit = context.read<StoreProductCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return UpdateProductTile(
      title: 'Product Info',
      widget: Column(
        children: [
          BlocBuilder<StoreProductCubit, StoreProductStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Food Name',
                child: TextFormField(
                  initialValue: state.name,
                  onChanged: stCubit.productName,
                  decoration: const InputDecoration(
                    hintText: 'Enter food name',
                  ),
                ),
              );
            },
          ),
          Utils.verticalSpace(12),
          BlocBuilder<StoreProductCubit, StoreProductStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Slug',
                child: TextFormField(
                  initialValue: state.slug,
                  onChanged: stCubit.productSlug,
                  decoration: const InputDecoration(
                    hintText: 'Enter food Slug',
                  ),
                ),
              );
            },
          ),
          Utils.verticalSpace(12),
          BlocBuilder<StoreProductCubit, StoreProductStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Description',
                child: TextFormField(
                  initialValue: state.shortDescription,
                  onChanged: stCubit.description,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Enter Description',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
