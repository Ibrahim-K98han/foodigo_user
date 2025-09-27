import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/restaurant_features/StoreProduct/cubit/store_product_cubit.dart';
import '../../../../features/restaurant_features/StoreProduct/model/store_product_state_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_form.dart';
import '../../restaurant_profile/component/update_product_tile.dart';

class VariationInfoWidget extends StatefulWidget {
  const VariationInfoWidget({super.key});

  @override
  State<VariationInfoWidget> createState() => _VariationInfoWidgetState();
}

class _VariationInfoWidgetState extends State<VariationInfoWidget> {
  late StoreProductCubit stCubit;

  @override
  void initState() {
    super.initState();
    stCubit = context.read<StoreProductCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return UpdateProductTile(
      title: 'Food Variations',
      widget: Column(
        children: [
          BlocBuilder<StoreProductCubit, StoreProductStateModel>(
            builder: (context, state) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.size.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomFormWidget(
                          label: 'Option Name',
                          child: TextFormField(
                            initialValue: state.size[index],
                            onChanged: (val) {
                              final updatedSizes = [...state.size];
                              updatedSizes[index] = val;
                              stCubit.size(updatedSizes);
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: CustomFormWidget(
                          label: 'Price',
                          child: TextFormField(
                            initialValue: state.price[index],
                            onChanged: (val) {
                              final updatedPrices = [...state.price];
                              updatedPrices[index] = val;
                              stCubit.sizePrice(updatedPrices);
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          final updatedSizes = [...state.size];
                          final updatedPrices = [...state.price];
                          updatedSizes.removeAt(index);
                          updatedPrices.removeAt(index);
                          stCubit.size(updatedSizes);
                          stCubit.sizePrice(updatedPrices);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Utils.verticalSpace(8),
          GestureDetector(
            onTap: () {
              stCubit.size([...stCubit.state.size, '']);
              stCubit.sizePrice([...stCubit.state.price, '']);
            },
            child: Container(
              width: 105,
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Row(
                children: [
                  Icon(Icons.add, color: Colors.orange, size: 20),
                  SizedBox(width: 5),
                  Text('Add New', style: TextStyle(color: Colors.orange)),
                ],
              ),
            ),
          ),
          Utils.verticalSpace(12),
        ],
      ),
    );
  }
}
