import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/restaurant_features/StoreProduct/cubit/store_product_cubit.dart';
import '../../../../features/restaurant_features/StoreProduct/model/store_product_state_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_form.dart';
import '../../restaurant_profile/component/update_product_tile.dart';

class SpecificationInfoWidget extends StatefulWidget {
  const SpecificationInfoWidget({super.key});

  @override
  State<SpecificationInfoWidget> createState() => _SpecificationInfoWidgetState();
}

class _SpecificationInfoWidgetState extends State<SpecificationInfoWidget> {
  late StoreProductCubit stCubit;

  @override
  void initState() {
    super.initState();
    stCubit = context.read<StoreProductCubit>();
  }
  @override
  Widget build(BuildContext context) {
    return  UpdateProductTile(
      title: 'Specification',
      widget: Column(
        children: [
          BlocBuilder<StoreProductCubit, StoreProductStateModel>(
            builder: (context, state) {
              final specifications = state.specification.isEmpty
                  ? [''] // at least 1 always
                  : state.specification;

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: specifications.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomFormWidget(
                          label: 'Specification Name',
                          child: TextFormField(
                            initialValue: specifications[index],
                            onChanged: (val) {
                              final updatedSpecification = [
                                ...specifications
                              ];
                              updatedSpecification[index] = val;
                              stCubit
                                  .specification(updatedSpecification);
                            },
                          ),
                        ),
                      ),
                      IconButton(
                        icon:
                        const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          final updatedSpecification = [
                            ...specifications
                          ];
                          updatedSpecification.removeAt(index);

                          if (updatedSpecification.isEmpty) {
                            updatedSpecification.add('');
                          }

                          stCubit.specification(updatedSpecification);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              stCubit
                  .specification([...stCubit.state.specification, '']);
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
                  Text('Add New',
                      style: TextStyle(color: Colors.orange)),
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
