import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/restaurant_features/StoreProduct/cubit/store_product_cubit.dart';
import '../../../../features/restaurant_features/StoreProduct/model/store_product_state_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_form.dart';
import '../../restaurant_profile/component/update_product_tile.dart';

class PriceInfoWidget extends StatefulWidget {
  const PriceInfoWidget({super.key});

  @override
  State<PriceInfoWidget> createState() => _PriceInfoWidgetState();
}

class _PriceInfoWidgetState extends State<PriceInfoWidget> {
  late StoreProductCubit stCubit;

  @override
  void initState() {
    super.initState();
    stCubit = context.read<StoreProductCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return UpdateProductTile(
      title: 'Price Info',
      widget: Column(
        children: [
          BlocBuilder<StoreProductCubit, StoreProductStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Product Price',
                child: TextFormField(
                  initialValue: state.productPrice,
                  onChanged: stCubit.productPrice,
                  decoration: const InputDecoration(
                    hintText: 'Enter product price',
                  ),
                ),
              );
            },
          ),
          BlocBuilder<StoreProductCubit, StoreProductStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Offer Price',
                child: TextFormField(
                  initialValue: state.offerPrice,
                  onChanged: stCubit.offerPrice,
                  decoration: const InputDecoration(
                    hintText: 'Enter offer price',
                  ),
                ),
              );
            },
          ),
          Utils.verticalSpace(12),
        ],
      ),
    );
  }
}
