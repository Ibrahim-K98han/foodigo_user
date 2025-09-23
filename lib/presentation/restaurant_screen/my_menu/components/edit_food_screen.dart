import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/data/remote_url.dart';
import 'package:foodigo/features/restaurant_features/Addons/cubit/res_addons_cubit.dart';
import 'package:foodigo/features/restaurant_features/Addons/cubit/res_addons_state.dart';
import 'package:foodigo/features/restaurant_features/Addons/model/res_addon_state_model.dart';
import 'package:foodigo/features/restaurant_features/Category/cubit/res_categories_cubit.dart';
import 'package:foodigo/features/restaurant_features/Category/cubit/res_categories_state.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/cubit/store_product_cubit.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/model/store_product_state_model.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/primary_button.dart';

class EditFoodScreen extends StatefulWidget {
  const EditFoodScreen({super.key, required this.prdId, required this.isEdit});

  final String prdId;
  final bool isEdit;

  @override
  State<EditFoodScreen> createState() => _EditFoodScreenState();
}

class _EditFoodScreenState extends State<EditFoodScreen> {
  String? selectedCategoryValue;
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
    if (widget.isEdit && widget.prdId != null) {
      stCubit.getEditProduct(widget.prdId);
    } else {
      stCubit.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.isEdit ? 'Edit Food' : 'Upload Food'),
      body: Padding(
        padding: Utils.symmetric(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Product Info
              UpdateProductTile(
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
                            maxLines: 4,
                            onChanged: stCubit.description,
                            decoration: const InputDecoration(
                              hintText: 'Enter Description',
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              Utils.verticalSpace(12),

              /// Category Info
              UpdateProductTile(
                title: 'Category Info',
                widget: BlocBuilder<ResCategoriesCubit, ResCategoriesState>(
                  builder: (context, catState) {
                    if (catState is ResCategoriesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (catState is ResCategoriesLoaded) {
                      final categories = catState.categoryModel.resCategories;
                      return DropdownButtonFormField<String>(
                        hint: const Text('Select Category'),
                        value: categories?.any((cat) =>
                                    cat.id.toString() ==
                                    selectedCategoryValue) ==
                                true
                            ? selectedCategoryValue
                            : null,
                        isExpanded: true,
                        onChanged: (value) {
                          stCubit.category(value!);
                        },
                        items: categories?.map<DropdownMenuItem<String>>((cat) {
                          return DropdownMenuItem(
                            value: cat.id.toString(),
                            child: Text(cat.name),
                          );
                        }).toList(),
                      );
                    } else if (catState is ResCategoriesError) {
                      return Text(catState.message,
                          style: const TextStyle(color: Colors.red));
                    }
                    return const SizedBox();
                  },
                ),
              ),

              Utils.verticalSpace(12),

              /// Addon Info

              UpdateProductTile(
                title: 'Addons Info',
                widget: BlocBuilder<ResAddonsCubit, ResAddonStateModel>(
                  builder: (context, addonState) {
                    final resState = addonState.resAddonsState;

                    if (resState is ResAddonsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (resState is ResAddonsLoaded) {
                      final addons = resState.resAddonModel.resAddons ?? [];

                      return DropdownButtonFormField<String>(
                        hint: const Text('Select Addon'),
                        value: addons.any((addon) =>
                                addon.id.toString() == selectedAddonValue)
                            ? selectedAddonValue
                            : null,
                        isExpanded: true,
                        onChanged: (value) {
                          if (value != null) {
                            stCubit.addon(value); // update your form Cubit
                          }
                        },
                        items: addons.map<DropdownMenuItem<String>>((addon) {
                          return DropdownMenuItem(
                            value: addon.id.toString(),
                            child: Text(addon.name ?? "Unnamed"),
                          );
                        }).toList(),
                      );
                    } else if (resState is ResAddonsError) {
                      return Text(resState.message,
                          style: const TextStyle(color: Colors.red));
                    }

                    return const SizedBox();
                  },
                ),
              ),

              Utils.verticalSpace(12),

              /// Price Info
              UpdateProductTile(
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
                    // BlocBuilder<StoreProductCubit, StoreProductStateModel>(
                    //   builder: (context, state) {
                    //     return CustomFormWidget(
                    //       label: 'Translate Id',
                    //       child: TextFormField(
                    //         initialValue: state.translateId,
                    //         onChanged: stCubit.translateId,
                    //         decoration: const InputDecoration(
                    //           hintText: 'Enter Translate Id',
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),

              Utils.verticalSpace(12),

              /// Variations
              UpdateProductTile(
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
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
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
                    const SizedBox(height: 8),
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
                            Text('Add New',
                                style: TextStyle(color: Colors.orange)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Utils.verticalSpace(12),

              /// Photo Attachment
              UpdateProductTile(
                title: 'Photo Attachment',
                widget: Stack(
                  alignment: Alignment.center,
                  children: [
                    BlocBuilder<StoreProductCubit, StoreProductStateModel>(
                      builder: (context, state) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: state.image.isNotEmpty
                              ? CustomImage(
                                  path: RemoteUrls.imageUrl(state.image),
                                  width: 250.w,
                                  height: 110.h,
                                  fit: BoxFit.cover,
                                )
                              : CustomImage(
                                  path: KImages.rImage1,
                                  width: 250.w,
                                  height: 110.h,
                                  fit: BoxFit.cover,
                                ),
                        );
                      },
                    ),
                    Container(
                      width: 250.w,
                      height: 110.h,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          final img = await Utils.pickSingleImage();
                          if (img != null && img.isNotEmpty) {
                            stCubit.image(img);
                          }
                        },
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.camera_alt, color: Colors.white),
                            SizedBox(height: 4),
                            Text('Upload',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: PrimaryButton(
          text: widget.isEdit ? 'Update' : 'Upload',
          onPressed: () {
            if (widget.isEdit) {
              stCubit.updateProduct(widget.prdId);
            } else {
              stCubit.storeProduct();
            }
          },
        ),
      ),
    );
  }
}

class UpdateProductTile extends StatelessWidget {
  const UpdateProductTile({super.key, this.title, this.widget});

  final String? title;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(color: borderColor),
        borderRadius: Utils.borderRadius(),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: false,
          iconColor: Colors.black,
          title: Text(title ?? '',
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
          children: [Padding(padding: Utils.symmetric(v: 10.0), child: widget)],
        ),
      ),
    );
  }
}
