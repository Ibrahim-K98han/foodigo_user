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
  final List<TextEditingController> _sizeControllers = [];
  final List<TextEditingController> _priceControllers = [];

  @override
  void initState() {
    super.initState();
    stCubit = context.read<StoreProductCubit>();

    // Initial load: add one empty variation if none exist
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (stCubit.state.size.isEmpty) {
        stCubit.size(['']);
        stCubit.sizePrice(['']);
      }
      _initializeControllers();
    });
  }

  void _initializeControllers() {
    // Clear existing controllers
    for (var controller in _sizeControllers) {
      controller.dispose();
    }
    for (var controller in _priceControllers) {
      controller.dispose();
    }
    _sizeControllers.clear();
    _priceControllers.clear();

    // Create new controllers based on current state
    final state = stCubit.state;
    final size = state.size.isEmpty ? [''] : state.size;
    final prices = state.price.isEmpty ? [''] : state.price;

    for (int i = 0; i < size.length; i++) {
      _sizeControllers.add(TextEditingController(text: size[i]));
      _priceControllers.add(
        TextEditingController(text: i < prices.length ? prices[i] : ''),
      );
    }
  }

  @override
  void dispose() {
    for (var controller in _sizeControllers) {
      controller.dispose();
    }
    for (var controller in _priceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UpdateProductTile(
      title: 'Food Variations',
      widget: Column(
        children: [
          BlocBuilder<StoreProductCubit, StoreProductStateModel>(
            builder: (context, state) {
              final size = state.size.isEmpty ? [''] : state.size;
              final prices = state.price.isEmpty ? [''] : state.price;

              // Update controllers if list length changed
              if (_sizeControllers.length != size.length) {
                _initializeControllers();
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: size.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomFormWidget(
                            label: 'Option Name',
                            child: TextFormField(
                              controller: _sizeControllers[index],
                              decoration: const InputDecoration(
                                hintText: 'e.g., Small, Medium, Large',
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (val) {
                                final updatedSizes = List<String>.from(size);
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
                              controller: _priceControllers[index],
                              decoration: const InputDecoration(
                                hintText: 'e.g., 100',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                final updatedPrices = List<String>.from(prices);
                                if (index < updatedPrices.length) {
                                  updatedPrices[index] = val;
                                } else {
                                  while (updatedPrices.length < index) {
                                    updatedPrices.add('');
                                  }
                                  updatedPrices.add(val);
                                }
                                stCubit.sizePrice(updatedPrices);
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: size.length > 1
                              ? () => _deleteVariation(index, size, prices)
                              : null,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          Utils.verticalSpace(8),
          GestureDetector(
            onTap: _addNewVariation,
            child: Container(
              width: 105,
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
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

  void _deleteVariation(int index, List<String> sizes, List<String> prices) {
    if (sizes.length <= 1) {
      Utils.showSnackBar(context, 'At least one variation is required');
      return;
    }

    final updatedSizes = List<String>.from(sizes);
    final updatedPrices = List<String>.from(prices);

    updatedSizes.removeAt(index);
    if (index < updatedPrices.length) {
      updatedPrices.removeAt(index);
    }

    stCubit.size(updatedSizes);
    stCubit.sizePrice(updatedPrices);
  }

  void _addNewVariation() {
    stCubit.size([...stCubit.state.size, '']);
    stCubit.sizePrice([...stCubit.state.price, '']);
  }
}