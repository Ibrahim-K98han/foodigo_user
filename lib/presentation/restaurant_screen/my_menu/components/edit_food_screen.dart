import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/cubit/store_product_cubit.dart';
import 'package:foodigo/features/restaurant_features/StoreProduct/model/store_product_state_model.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/primary_button.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../features/restaurant_features/Category/cubit/res_categories_cubit.dart';
import '../../../../features/restaurant_features/Category/cubit/res_categories_state.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class EditFoodScreen extends StatefulWidget {
  const EditFoodScreen({super.key});

  @override
  State<EditFoodScreen> createState() => _EditFoodScreenState();
}

class _EditFoodScreenState extends State<EditFoodScreen> {
  String? selectedCategoryValue;
  late ResCategoriesCubit resCatCubit;
  late StoreProductCubit stCubit;

  @override
  void initState() {
    super.initState();
    resCatCubit = context.read<ResCategoriesCubit>();
    stCubit = context.read<StoreProductCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Upload Food'),
      body: Padding(
        padding: Utils.symmetric(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// ----------------- Product Info -----------------
              UpdateProductTile(
                title: 'Product Info',
                widget: BlocBuilder<StoreProductCubit, StoreProductStateModel>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        CustomFormWidget(
                          label: 'Food Name',
                          child: TextFormField(
                            initialValue: state.name,
                            onChanged: stCubit.productName,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF8FAFC),
                              hintText: 'Food name',
                            ),
                            validator: FormBuilderValidators.required(
                                errorText: 'Enter Food Name'),
                          ),
                        ),
                        Utils.verticalSpace(12),
                        CustomFormWidget(
                          label: 'Slug',
                          child: TextFormField(
                            initialValue: state.slug,
                            onChanged: stCubit.productSlug,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF8FAFC),
                              hintText: 'slug',
                            ),
                          ),
                        ),
                        Utils.verticalSpace(12),
                        CustomFormWidget(
                          label: 'Description',
                          child: TextFormField(
                            initialValue: state.shortDescription,
                            onChanged: stCubit.description,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF8FAFC),
                              hintText: 'description',
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Utils.verticalSpace(12),

              /// ----------------- Category Info -----------------
              UpdateProductTile(
                title: 'Category Info',
                widget: BlocBuilder<ResCategoriesCubit, ResCategoriesState>(
                  builder: (context, state) {
                    if (state is ResCategoriesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ResCategoriesLoaded) {
                      final categories = state.categoryModel.resCategories;
                      return DropdownButtonFormField<String>(
                        hint: const CustomText(
                          text: "Category",
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                        value: selectedCategoryValue,
                        isExpanded: true,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        decoration: InputDecoration(
                          fillColor: const Color(0xffF8FAFC),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(Utils.radius(10))),
                          ),
                          contentPadding:
                          const EdgeInsets.fromLTRB(16, 24, 20, 10),
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedCategoryValue = value;
                            stCubit.category(value!);
                          });
                        },
                        items: categories
                            ?.map<DropdownMenuItem<String>>((category) {
                          return DropdownMenuItem<String>(
                            value: category.id.toString(),
                            child: CustomText(text: category.name),
                          );
                        }).toList(),
                      );
                    } else if (state is ResCategoriesError) {
                      return CustomText(
                        text: state.message,
                        color: Colors.red,
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),

              Utils.verticalSpace(12),

              /// ----------------- Price Info -----------------
              UpdateProductTile(
                title: 'Price Info',
                widget: BlocBuilder<StoreProductCubit, StoreProductStateModel>(
                  builder: (context, state) {
                    return CustomFormWidget(
                      label: 'Product Price',
                      child: TextFormField(
                        initialValue: state.productPrice.toString(),
                        onChanged: stCubit.productPrice,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: '\$23.00',
                        ),
                      ),
                    );
                  },
                ),
              ),

              Utils.verticalSpace(12),

              /// ----------------- Variations -----------------
              UpdateProductTile(
                title: 'Food Variations',
                widget: BlocBuilder<StoreProductCubit, StoreProductStateModel>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        ListView.builder(
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
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffF8FAFC),
                                        hintText: 'Small',
                                      ),
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
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Color(0xffF8FAFC),
                                        hintText: '\$23.00',
                                      ),
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
                    );
                  },
                ),
              ),

              Utils.verticalSpace(12),

              /// ----------------- Photo Attachment -----------------
              UpdateProductTile(
                title: 'Photo Attachment',
                widget: BlocBuilder<StoreProductCubit, StoreProductStateModel>(
                  builder: (context, state) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: state.image.isNotEmpty
                              ? Image.file(
                            File(state.image),
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.camera_alt, color: Colors.white),
                                SizedBox(height: 4),
                                Text('Upload', style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: PrimaryButton(
          text: 'Upload',
          onPressed: () {
            stCubit.storeProduct();
            stCubit.clear();
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
          title: CustomText(
            text: title ?? '',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          children: [
            Padding(padding: Utils.symmetric(v: 10.0), child: widget),
          ],
        ),
      ),
    );
  }
}
