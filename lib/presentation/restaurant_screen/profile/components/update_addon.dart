import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/restaurant_features/Addons/cubit/res_addons_cubit.dart';
import 'package:foodigo/features/restaurant_features/Addons/cubit/res_addons_state.dart';
import 'package:foodigo/features/restaurant_features/Addons/model/res_addon_state_model.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/utils/utils.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/fetch_error_text.dart';
import 'package:foodigo/widget/loading_widget.dart';
import 'package:foodigo/widget/primary_button.dart';

class UpdateAddon extends StatefulWidget {
  const UpdateAddon({super.key, required this.addonId});
  final String addonId;

  @override
  State<UpdateAddon> createState() => _UpdateAddonState();
}

class _UpdateAddonState extends State<UpdateAddon> {
  late ResAddonsCubit rAddonCubit;
  @override
  void initState() {
    super.initState();
    rAddonCubit = context.read<ResAddonsCubit>();
    rAddonCubit.editAddon(widget.addonId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Update Addon'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ResAddonsCubit, ResAddonStateModel>(
            listener: (context, state) {
              final updateAddon = state.resAddonsState;
              if (updateAddon is EditAddonsError) {
                if (updateAddon.statusCode == 503) {
                  FetchErrorText(text: updateAddon.message);
                }
              }
            },
          ),
          BlocListener<ResAddonsCubit, ResAddonStateModel>(
            listener: (context, state) {
              final updateAddon = state.resAddonsState;
              if (updateAddon is UpdateAddonsError) {
                if (updateAddon.statusCode == 503) {
                  FetchErrorText(text: updateAddon.message);
                }
              }
            },
          ),
        ],
        child: BlocBuilder<ResAddonsCubit, ResAddonStateModel>(
          // listener: (context, state) {
          //   final updateAddon = state.resAddonsState;
          //   if (updateAddon is EditAddonsError) {
          //     if (updateAddon.statusCode == 503) {
          //       FetchErrorText(text: updateAddon.message);
          //     }
          //   }
          // },
          builder: (context, state) {
            final updateAddon = state.resAddonsState;
            if (updateAddon is EditAddonsLoading) {
              return const LoadingWidget();
            } else if (updateAddon is EditAddonsError) {
              if (updateAddon.statusCode == 503 ||
                  rAddonCubit.editAddons != null) {
                return const LoadUpdateAddonForm();
              } else {
                return FetchErrorText(text: updateAddon.message);
              }
            } else if (updateAddon is EditAddonsLoaded) {
              return const LoadUpdateAddonForm();
            }
            if (rAddonCubit.editAddons != null) {
              return const LoadUpdateAddonForm();
            } else {
              return const FetchErrorText(text: 'Something went wrong!');
            }
          },
        ),
      ),
    );
  }
}

class LoadUpdateAddonForm extends StatefulWidget {
  const LoadUpdateAddonForm({super.key});

  @override
  State<LoadUpdateAddonForm> createState() => _LoadUpdateAddonFormState();
}

class _LoadUpdateAddonFormState extends State<LoadUpdateAddonForm> {
  late ResAddonsCubit rAddonCubit;
  @override
  void initState() {
    rAddonCubit = context.read<ResAddonsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Utils.symmetric(h: 20),
      child: Column(
        children: [
          CustomFormWidget(
            label: 'Price',
            child: BlocBuilder<ResAddonsCubit, ResAddonStateModel>(
              builder: (context, state) {
                return TextFormField(
                  initialValue: rAddonCubit.editAddons!.addon!.price.toString(),
                  onChanged: rAddonCubit.price,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Enter Price'),
                );
              },
            ),
          ),
          Utils.verticalSpace(20),
          CustomFormWidget(
            label: 'Name',
            child: BlocBuilder<ResAddonsCubit, ResAddonStateModel>(
              builder: (context, state) {
                return TextFormField(
                  initialValue: rAddonCubit.editAddons!.addon!.name.toString(),
                  onChanged: rAddonCubit.name,
                  decoration: const InputDecoration(hintText: 'Enter Name'),
                );
              },
            ),
          ),
          Utils.verticalSpace(20),
          PrimaryButton(
            text: 'Update',
            onPressed: () async {
              rAddonCubit.updateAddon(
                rAddonCubit.editAddons!.addon!.id.toString(),
              );
              Navigator.pushNamed(
                context,
                RouteNames.addonMangeScreen,
              );
              // await Future.delayed(const Duration(seconds: 2));
              // rAddonCubit.getAddon();
            },
          ),
        ],
      ),
    );
  }
}
