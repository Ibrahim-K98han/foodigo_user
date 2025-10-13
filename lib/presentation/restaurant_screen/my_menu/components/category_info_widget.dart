import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../features/restaurant_features/Addons/cubit/res_addons_cubit.dart';
import '../../../../features/restaurant_features/Addons/cubit/res_addons_state.dart';
import '../../../../features/restaurant_features/Addons/model/res_addon_state_model.dart';
import '../../../../features/restaurant_features/Category/cubit/res_categories_cubit.dart';
import '../../../../features/restaurant_features/Category/cubit/res_categories_state.dart';
import '../../../../features/restaurant_features/StoreProduct/cubit/store_product_cubit.dart';
import '../../../../utils/utils.dart';
import '../../restaurant_profile/component/update_product_tile.dart';

class CategoryInfoWidget extends StatefulWidget {
  const CategoryInfoWidget({super.key});

  @override
  State<CategoryInfoWidget> createState() => _CategoryInfoWidgetState();
}

class _CategoryInfoWidgetState extends State<CategoryInfoWidget> {
  String? selectedCategoryValue;
  late StoreProductCubit stCubit;

  @override
  void initState() {
    super.initState();
    stCubit = context.read<StoreProductCubit>();
    selectedCategoryValue = stCubit.state.categoryId;
  }

  @override
  Widget build(BuildContext context) {
    return UpdateProductTile(
      title: 'Addon And Category Info',
      widget: Column(
        children: [
          BlocBuilder<ResCategoriesCubit, ResCategoriesState>(
            builder: (context, catState) {
              if (catState is ResCategoriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (catState is ResCategoriesLoaded) {
                final categories = catState.categoryModel.resCategories;
                return DropdownButtonFormField<String>(
                  hint: const Text('Select Category'),
                  value:
                      selectedCategoryValue != null &&
                              categories!.any(
                                (cat) =>
                                    cat.id.toString() == selectedCategoryValue,
                              )
                          ? selectedCategoryValue
                          : null,
                  isExpanded: true,
                  onChanged: (value) {
                    setState(() {
                      selectedCategoryValue = value!;
                    });
                    stCubit.category(value!);
                  },
                  items:
                      categories?.map<DropdownMenuItem<String>>((cat) {
                        return DropdownMenuItem(
                          value: cat.id.toString(),
                          child: Text(cat.name),
                        );
                      }).toList(),
                );
              } else if (catState is ResCategoriesError) {
                return Text(
                  catState.message,
                  style: const TextStyle(color: Colors.red),
                );
              }
              return const SizedBox();
            },
          ),

          Utils.verticalSpace(12),

          BlocBuilder<ResAddonsCubit, ResAddonStateModel>(
            builder: (context, addonState) {
              if (addonState.resAddonsState is ResAddonsLoaded) {
                final loaded = addonState.resAddonsState as ResAddonsLoaded;
                final addons = loaded.resAddonModel.resAddons;
                return MultiSelectDialogField<String>(
                  dialogHeight: 400.h,
                  dialogWidth: 350.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(color: borderColor),
                  ),
                  items:
                      addons
                          .map(
                            (addon) => MultiSelectItem(
                              addon.id.toString(),
                              addon.name,
                            ),
                          )
                          .toList(),
                  title: const CustomText(text: "Select Addons", fontSize: 18),
                  buttonText: const Text(
                    "Select Addons",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  cancelText: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  confirmText: const Text(
                    "OK",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  buttonIcon: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.black,
                    size: 25,
                  ),
                  initialValue:
                      context.read<StoreProductCubit>().state.addonItems,
                  onConfirm: (values) {
                    context.read<StoreProductCubit>().addon(values);
                  },
                );
              }
              return const SizedBox();
            },
          ),
          Utils.verticalSpace(12),
        ],
      ),
    );
  }
}
