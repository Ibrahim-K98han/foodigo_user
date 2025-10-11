import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/restaurant_features/Addons/cubit/res_addons_state.dart';
import 'package:foodigo/features/restaurant_features/Addons/model/res_addon_model.dart';
import 'package:foodigo/features/restaurant_features/Addons/model/res_addon_state_model.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/utils/constraints.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/page_refresh.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../features/restaurant_features/Addons/cubit/res_addons_cubit.dart';

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
      appBar: const CustomAppBar(title: 'Addon Manage', visibleLeading: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          resAddonsCubit.clear();
          Navigator.pushNamed(context, RouteNames.addAddonScreen);
        },
        backgroundColor: textColor,
        child: const Icon(Icons.add, color: whiteColor),
      ),
      body: PageRefresh(
        onRefresh: () async {
          resAddonsCubit.getAddon();
        },
        child: BlocConsumer<ResAddonsCubit, ResAddonStateModel>(
          listener: (context, state) {
            final addon = state.resAddonsState;
            if (addon is DeleteAddonSuccess) {
              Utils.successSnackBar(context, addon.message);
              resAddonsCubit.getAddon();
            }
            if (addon is DeleteAddonError) {
              Utils.errorSnackBar(context, addon.message);
            }
            if (addon is ResAddonsError) {
              if (addon.statusCode == 503) {
                FetchErrorText(text: addon.message);
              }
            }
          },
          builder: (context, state) {
            final addon = state.resAddonsState;
            if (addon is ResAddonsLoading) {
              return const LoadingWidget();
            } else if (addon is ResAddonsError) {
              if (addon.statusCode == 503 ||
                  resAddonsCubit.resAddonModel != null) {
                return LoadedAdon(
                  addons: resAddonsCubit.resAddonModel!.resAddons,
                );
              } else {
                return FetchErrorText(text: addon.message);
              }
            } else if (addon is ResAddonsLoaded) {
              return LoadedAdon(
                addons: resAddonsCubit.resAddonModel!.resAddons,
              );
            }
            if (resAddonsCubit.resAddonModel != null) {
              return LoadedAdon(
                addons: resAddonsCubit.resAddonModel!.resAddons,
              );
            } else {
              return const FetchErrorText(text: 'Something went wrong!');
            }
          },
        ),
      ),
    );
  }
}

class LoadedAdon extends StatelessWidget {
  const LoadedAdon({super.key, required this.addons});

  final List<ResAddons> addons;

  @override
  Widget build(BuildContext context) {
    final resAddonsCubit = context.read<ResAddonsCubit>();
    return addons.isEmpty
        ? Center(child: CustomText(text: 'No Addon Found', fontSize: 18.sp))
        : ListView.builder(
          itemCount: addons.length,
          itemBuilder: (context, index) {
            final addon = addons[index];
            return ListTile(
              title: Text(addon.name),
              subtitle: Text('Price: ${addon.price}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Edit Button
                  IconButton(
                    icon: const Icon(Icons.edit, color: greenColor),
                    onPressed: () {
                      resAddonsCubit.editAddon(addon.id.toString());
                      Navigator.pushNamed(
                        context,
                        RouteNames.updateAddonScreen,
                        arguments: addon.id.toString(),
                      );
                    },
                  ),
                  // Delete Button
                  IconButton(
                    icon: const Icon(Icons.delete, color: redColor),
                    onPressed: () {
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
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: PrimaryButton(
                                      text: 'Delete',
                                      onPressed: () {
                                        resAddonsCubit.deleteAddon(
                                          addon.id.toString(),
                                        );
                                        // resAddonsCubit.getAddon();
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
  }
}
