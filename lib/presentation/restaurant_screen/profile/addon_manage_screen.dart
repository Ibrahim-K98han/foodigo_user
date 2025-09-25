import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/Addons/model/res_addon_model.dart';
import 'package:foodigo/features/restaurant_features/Addons/model/res_addon_state_model.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/utils/k_images.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/custom_image.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/page_refresh.dart';
import 'package:foodigo/widget/primary_button.dart';
import '../../../utils/utils.dart';
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
                            Utils.verticalSpace(10),
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
                            Utils.verticalSpace(20),
                            BlocListener<ResAddonsCubit, ResAddonStateModel>(
                              listener: (context, state) {
                                final addAddon = state.resAddonsState;
                                if (addAddon is ResAddonsError) {
                                  Utils.failureSnackBar(
                                      context, addAddon.message);
                                } else if (addAddon is ResAddonsSuccess) {
                                  Utils.successSnackBar(
                                      context, addAddon.message);
                                }
                              },
                              child: PrimaryButton(
                                text: 'Add',
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await resAddonsCubit.storeAddon();
                                  resAddonsCubit.getAddon();
                                },
                              ),
                            ),
                            Utils.verticalSpace(20),
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
      body: PageRefresh(
        onRefresh: () async {
          resAddonsCubit.getAddon();
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<ResAddonsCubit, ResAddonStateModel>(
              listenWhen: (current, previous) {
                print("edit current state $current");
                print("edit previous state $previous");
                return true;
              },
              listener: (context, state) {
                final edit = state.resAddonsState;
                if (edit is EditAddonsLoading) {
                  Utils.loadingDialog(context);
                } else {
                  Utils.closeDialog(context);
                  if (edit is EditAddonsError) {
                    Utils.showSnackBar(context, edit.message);
                  } else if (edit is EditAddonsLoaded) {
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
                                  text: 'Edit Addon',
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
                                BlocBuilder<ResAddonsCubit, ResAddonStateModel>(
                                  builder: (context, state) {
                                    final update = state.resAddonsState;
                                    if (update is UpdateAddonsLoading) {
                                      return const LoadingWidget();
                                    }
                                    return PrimaryButton(
                                        text: 'Update',
                                        onPressed: () {
                                          resAddonsCubit.translateId(edit
                                              .editAddon.addonTranslate!.id
                                              .toString());
                                          resAddonsCubit.updateAddon(edit
                                              .editAddon.addon!.id
                                              .toString());
                                          Navigator.pop(context);
                                        });
                                  },
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ],
          child: BlocBuilder<ResAddonsCubit, ResAddonStateModel>(
            builder: (context, state) {
              final resState = state.resAddonsState;
              if (resState is ResAddonsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (resState is ResAddonsLoaded) {
                return LoadedAdon(
                    addons: resAddonsCubit.resAddonModel!.resAddons);
              } else if (resState is ResAddonsError) {
                Utils.errorSnackBar(context, resState.message);
              }
              if (resAddonsCubit.resAddonModel != null &&
                  resAddonsCubit.resAddonModel!.resAddons.isNotEmpty) {
                return LoadedAdon(
                    addons: resAddonsCubit.resAddonModel!.resAddons);
              } else {
                return const FetchErrorText(text: "SomeThing went wrong");
              }
            },
          ),
        ),
      ),
    );
  }
}

class LoadedAdon extends StatelessWidget {
  const LoadedAdon({
    super.key,
    required this.addons,
  });

  final List<ResAddons> addons;

  @override
  Widget build(BuildContext context) {
    final resAddonsCubit = context.read<ResAddonsCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: DataTable(
        columnSpacing: 55.w,
        border: TableBorder.all(color: Colors.grey.shade300),
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.grey.shade200),
        columns: const [
          DataColumn(label: Text("Name")),
          DataColumn(label: Text("Price")),
          DataColumn(label: Text("Action")),
        ],
        rows: addons.map((addon) {
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
                      resAddonsCubit.editAddon(addon.id.toString());
                      print('Edit Addon ID: ${addon.id}');
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
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const CustomText(
                              text: 'Confirm Delete Addon',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            content: const CustomText(
                              text:
                                  'Are you sure you want to delete this Addon?',
                              fontSize: 14,
                            ),
                            actions: [
                              Row(
                                children: [
                                  Expanded(
                                    child: PrimaryButton(
                                        text: 'Cancel',
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        }),
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Expanded(
                                    child: PrimaryButton(
                                        text: 'Delete',
                                        onPressed: () {
                                          resAddonsCubit
                                              .deleteAddon(addon.id.toString());
                                          resAddonsCubit.getAddon();
                                          Navigator.of(context).pop();
                                        }),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      );
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
  }
}
