import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/primary_button.dart';

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
  final List<String> categoryItems = ['Fast food', 'Fruits'];
  String? selectedSubCategoryValue;
  final List<String> subCategoryItems = ['BBQ', 'Fry'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Update Food'),
      body: Padding(
        padding: Utils.symmetric(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              UpdateProductTile(
                title: 'Product Info',
                widget: Column(
                  children: [
                    CustomFormWidget(
                      label: 'Food Name',
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: 'Food name',
                        ),
                      ),
                    ),
                    Utils.verticalSpace(12),
                    CustomFormWidget(
                      label: 'Description',
                      child: TextFormField(
                        maxLines: 4,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: 'description',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Utils.verticalSpace(12),
              UpdateProductTile(
                title: 'Category Info',
                widget: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      hint: const CustomText(
                        text: "Category",
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                      isDense: true,
                      isExpanded: true,
                      dropdownColor: whiteColor,
                      value: selectedCategoryValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                        fillColor: const Color(0xffF8FAFC),
                        filled: true,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Utils.radius(10.0)),
                          ),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(
                          16.0,
                          24.0,
                          20.0,
                          10.0,
                        ),
                      ),
                      onTap: () => Utils.closeKeyBoard(context),
                      onChanged: (value) {
                        setState(() {
                          selectedCategoryValue = value;
                        });
                      },
                      items: categoryItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: CustomText(text: value),
                        );
                      }).toList(),
                    ),
                    Utils.verticalSpace(12),
                    DropdownButtonFormField<String>(
                      hint: const CustomText(
                        text: "Sub-Category",
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                      isDense: true,
                      isExpanded: true,
                      dropdownColor: whiteColor,
                      value: selectedSubCategoryValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                        fillColor: const Color(0xffF8FAFC),
                        filled: true,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Utils.radius(10.0)),
                          ),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(
                          16.0,
                          24.0,
                          20.0,
                          10.0,
                        ),
                      ),
                      onTap: () => Utils.closeKeyBoard(context),
                      onChanged: (value) {
                        setState(() {
                          selectedSubCategoryValue = value;
                        });
                      },
                      items: subCategoryItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: CustomText(text: value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Utils.verticalSpace(12),
              UpdateProductTile(
                title: 'Price Info',
                widget: Column(
                  children: [
                    CustomFormWidget(
                      label: 'Price',
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: '\$23.00',
                        ),
                      ),
                    ),
                    Utils.verticalSpace(12),
                    CustomFormWidget(
                      label: 'Display Price',
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: '\$23.00',
                        ),
                      ),
                    ),
                    Utils.verticalSpace(12),
                    CustomFormWidget(
                      label: 'Stock',
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: '23',
                        ),
                      ),
                    ),
                    Utils.verticalSpace(12),
                    CustomFormWidget(
                      label: 'Order Quantity',
                      child: TextFormField(
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: '4',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Utils.verticalSpace(12),
              UpdateProductTile(
                title: 'Food Variations',
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomFormWidget(
                            label: 'Option Name',
                            child: TextFormField(
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xffF8FAFC),
                                hintText: 'Small',
                              ),
                            ),
                          ),
                        ),
                        Utils.horizontalSpace(8),
                        Expanded(
                          child: CustomFormWidget(
                            label: 'Price',
                            child: TextFormField(
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xffF8FAFC),
                                hintText: '\$23.00',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Utils.verticalSpace(12),
                    Row(
                      children: [
                        Expanded(
                          child: CustomFormWidget(
                            label: 'Option Name',
                            child: TextFormField(
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xffF8FAFC),
                                hintText: 'Medium',
                              ),
                            ),
                          ),
                        ),
                        Utils.horizontalSpace(8),
                        Expanded(
                          child: CustomFormWidget(
                            label: 'Price',
                            child: TextFormField(
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xffF8FAFC),
                                hintText: '\$23.00',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Utils.verticalSpace(12),
                    Row(
                      children: [
                        Expanded(
                          child: CustomFormWidget(
                            label: 'Option Name',
                            child: TextFormField(
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xffF8FAFC),
                                hintText: 'Large',
                              ),
                            ),
                          ),
                        ),
                        Utils.horizontalSpace(8),
                        Expanded(
                          child: CustomFormWidget(
                            label: 'Price',
                            child: TextFormField(
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color(0xffF8FAFC),
                                hintText: '\$23.00',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Utils.verticalSpace(12),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 105.w,
                        height: 40.h,
                        padding: Utils.symmetric(h: 4),
                        decoration: BoxDecoration(
                            border: Border.all(color: smallContainerColor),
                            borderRadius: BorderRadius.circular(4.r)),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.add,
                              color: smallContainerColor,
                              size: 25,
                            ),
                            Utils.horizontalSpace(5),
                            const CustomText(
                              text: 'Add New',
                              color: smallContainerColor,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Utils.verticalSpace(12),
              UpdateProductTile(
                title: 'Food Tag',
                widget: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: CustomFormWidget(
                        label: 'Keyword',
                        child: TextFormField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF8FAFC),
                            hintText: 'Burger, pizza, food',
                          ),
                        ),
                      ),
                    ),
                    Utils.horizontalSpace(8),
                    Padding(
                      padding: const EdgeInsets.only(top: 22),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          width: 60.w,
                          height: 52.h,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: const CustomText(
                            text: 'Add',
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Utils.verticalSpace(12),
              UpdateProductTile(
                title: 'Photo Attachment',
                widget: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Thumbnail Image Preview',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                    const CustomText(
                      text: 'Cover of at least Size1170x990. Max 5MB',
                      fontSize: 13,
                      color: primaryColor,
                    ),
                    Utils.verticalSpace(12),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: CustomImage(
                            path: KImages.rImage1,
                            width: 190.w,
                            height: 110.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: 190.w,
                          height: 110.h,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomImage(
                                path: KImages.camera,
                                width: 24.w,
                                height: 24.h,
                                fit: BoxFit.cover,
                              ),
                              Utils.verticalSpace(4),
                              const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    text: 'Upload or',
                                    color: whiteColor,
                                    fontSize: 12,
                                  ),
                                  CustomText(
                                    text: 'Upload or',
                                    color: primaryColor,
                                    fontSize: 12,
                                    decoration: TextDecoration.underline,
                                    // decorationColor: primaryColor,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: PrimaryButton(text: 'Update Now', onPressed: () {}),
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
        data: Theme.of(context).copyWith(dividerColor: transparent),
        child: ExpansionTile(
          initiallyExpanded: false,
          iconColor: blackColor,
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
