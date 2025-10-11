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

class AddAddon extends StatefulWidget {
  const AddAddon({super.key});

  @override
  State<AddAddon> createState() => _AddAddonState();
}

class _AddAddonState extends State<AddAddon> {
  late ResAddonsCubit rAddonCubit;
  @override
  void initState() {
    super.initState();
    rAddonCubit = context.read<ResAddonsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return
    // Scaffold(
    //   appBar: const CustomAppBar(title: 'Add Addon'),
    //   body: BlocConsumer<ResAddonsCubit, ResAddonStateModel>(
    //     listener: (context, state) {
    //       final addAddon = state.resAddonsState;
    //       if (addAddon is AddAddonsLoaded) {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           const SnackBar(
    //             content: Text('Addon added successfully'),
    //             backgroundColor: Colors.green,
    //           ),
    //         );
    //         Navigator.pushReplacementNamed(
    //           context,
    //           RouteNames.addonMangeScreen,
    //         );
    //       }
    //       if (addAddon is AddAddonsError) {
    //         FetchErrorText(text: addAddon.message);
    //       }
    //     },
    //     builder: (context, state) {
    //       final addAddon = state.resAddonsState;
    //       if (addAddon is AddAddonsLoading) {
    //         return const LoadingWidget();
    //       } else if (addAddon is AddAddonsError) {
    //         if (addAddon.statusCode == 503 || rAddonCubit.editAddons != null) {
    //           return const LoadAddAddonForm();
    //         } else {
    //           return FetchErrorText(text: addAddon.message);
    //         }
    //       } else if (addAddon is AddAddonsLoaded) {
    //         return const LoadAddAddonForm();
    //       }
    //       if (rAddonCubit.editAddons != null) {
    //         return const LoadAddAddonForm();
    //       } else {
    //         return const FetchErrorText(text: 'Something went wrong!');
    //       }
    //     },
    //   ),
    // );
    Scaffold(
      appBar: const CustomAppBar(title: 'Add Addon'),
      body: BlocConsumer<ResAddonsCubit, ResAddonStateModel>(
        listener: (context, state) {
          final addAddon = state.resAddonsState;

          // Add Success Message
          if (addAddon is AddAddonsLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Addon added successfully'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacementNamed(
              context,
              RouteNames.addonMangeScreen,
            );
          }

          if (addAddon is AddAddonsError) {
            FetchErrorText(text: addAddon.message);
          }
        },
        builder: (context, state) {
          final addAddon = state.resAddonsState;

          if (addAddon is AddAddonsLoading) {
            return const LoadingWidget();
          } else if (addAddon is AddAddonsError) {
            return const Column(children: [LoadAddAddonForm()]);
          }

          return const LoadAddAddonForm();
        },
      ),
    );
  }
}

class LoadAddAddonForm extends StatefulWidget {
  const LoadAddAddonForm({super.key});

  @override
  State<LoadAddAddonForm> createState() => _LoadAddAddonFormState();
}

class _LoadAddAddonFormState extends State<LoadAddAddonForm> {
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
                  initialValue: state.price,
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
                  initialValue: state.name,
                  onChanged: rAddonCubit.name,
                  decoration: const InputDecoration(hintText: 'Enter Name'),
                );
              },
            ),
          ),
          Utils.verticalSpace(20),
          PrimaryButton(
            text: 'Add',
            onPressed: () async {
              rAddonCubit.storeAddon();
              Navigator.pushNamed(context, RouteNames.addonMangeScreen);
              // await Future.delayed(const Duration(seconds: 1));
              // rAddonCubit.getAddon();
            },
          ),
        ],
      ),
    );
  }
}
