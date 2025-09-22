import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/Addons/model/res_addon_state_model.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../features/restaurant_features/Addons/cubit/res_addons_cubit.dart';
import '../../../features/restaurant_features/Addons/cubit/res_addons_state.dart';

class AddonManageScreen extends StatefulWidget {
  const AddonManageScreen({super.key});

  @override
  State<AddonManageScreen> createState() => _AddonManageScreenState();
}

class _AddonManageScreenState extends State<AddonManageScreen> {
  late ResAddonsCubit resAddonsCubit;

  @override
  void initState() {
    super.initState();
    resAddonsCubit = context.read<ResAddonsCubit>();
    resAddonsCubit.getAddon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Addon Manage',
        visibleLeading: true,
        action: [
          Padding(
            padding: EdgeInsets.only(right: 18.w),
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(height: 10.h),
                            const CustomText(
                              text: 'Add Addon',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            BlocBuilder<ResAddonsCubit, ResAddonStateModel>(
                              builder: (context, state) {
                                return CustomFormWidget(
                                  label: 'Name',
                                  child: TextFormField(
                                      initialValue: state.name,
                                      onChanged: resAddonsCubit.name),
                                );
                              },
                            ),
                            SizedBox(height: 10.h),
                            BlocBuilder<ResAddonsCubit, ResAddonStateModel>(
                              builder: (context, state) {
                                return CustomFormWidget(
                                  label: 'Price',
                                  child: TextFormField(
                                    initialValue: state.price.toString(),
                                    keyboardType: TextInputType.number,
                                    onChanged: resAddonsCubit.price,
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 20.h),
                            PrimaryButton(
                                text: 'Add',
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await resAddonsCubit.storeAddon();
                                  resAddonsCubit.getAddon();
                                }),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: greenColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Icon(Icons.add)),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ResAddonsCubit, ResAddonStateModel>(
        builder: (context, state) {
          final resState = state.resAddonsState;
          if (resState is ResAddonsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (resState is ResAddonsLoaded) {
            final addons = resState.resAddonModel.resAddons;
            if (addons == null || addons.isEmpty) {
              return const Center(child: Text("No addons available"));
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: DataTable(
                columnSpacing: 55.w,
                border: TableBorder.all(color: Colors.grey.shade300),
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => Colors.grey.shade200),
                columns: const [
                  DataColumn(label: Text("Name")),
                  DataColumn(label: Text("Price")),
                  DataColumn(label: Text("Action")),
                ],
                rows: addons.map((addon) {
                  final translate = addon.addonTranslate;
                  return DataRow(cells: [
                    DataCell(Text(addon.name ?? "Unnamed")),
                    DataCell(Text(addon.price)),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // ===== EDIT BUTTON =====
                          GestureDetector(
                            onTap: () {
                              resAddonsCubit.editAddon(
                                addon.id.toString(),
                              );
                              print('Edit Addon ID: ${addon.id}');
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.w),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 10.h),
                                          const CustomText(
                                            text: 'Edit Addon',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          BlocBuilder<ResAddonsCubit,
                                              ResAddonStateModel>(
                                            builder: (context, state) {
                                              return CustomFormWidget(
                                                label: 'Name',
                                                child: TextFormField(
                                                    initialValue: state.name,
                                                    onChanged:
                                                        resAddonsCubit.name),
                                              );
                                            },
                                          ),
                                          SizedBox(height: 10.h),
                                          BlocBuilder<ResAddonsCubit,
                                              ResAddonStateModel>(
                                            builder: (context, state) {
                                              return CustomFormWidget(
                                                label: 'Price',
                                                child: TextFormField(
                                                  initialValue:
                                                      state.price.toString(),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged:
                                                      resAddonsCubit.price,
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(height: 20.h),
                                          PrimaryButton(
                                              text: 'Update',
                                              onPressed: () {
                                                resAddonsCubit.updateAddon(
                                                    addon.id.toString(),
                                                    translate!.id.toString(),
                                                    translate.langCode
                                                        .toString());
                                                Navigator.pop(context);
                                              }),
                                          SizedBox(height: 20.h),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: greenColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: const CustomImage(
                                path: KImages.editIcon,
                                color: greenColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          // ===== DELETE BUTTON =====
                          GestureDetector(
                            onTap: () {
                              resAddonsCubit.deleteAddon(addon.id.toString());
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: redColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: const CustomImage(
                                path: KImages.deleteIcon,
                                color: redColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            );
          } else if (resState is ResAddonsError) {
            return Center(child: Text(resState.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
