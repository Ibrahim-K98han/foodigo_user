import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_cubit.dart';
import 'package:foodigo/features/restaurant_features/RestaurantProfile/model/restaurant_profile_state_model.dart';

import '../../../../utils/utils.dart';
import '../../../../widget/custom_form.dart';
import '../../my_menu/edit_food_screen.dart';
import '../../my_menu/components/update_product_tile.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  late RestaurantProfileCubit resProCubit;

  @override
  void initState() {
    super.initState();
    resProCubit = context.read<RestaurantProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return UpdateProductTile(
      title: 'Account  Info',
      widget: Column(
        children: [
          BlocBuilder<RestaurantProfileCubit, RestaurantProfileStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Name',
                child: TextFormField(
                  initialValue: state.name,
                  onChanged: resProCubit.name,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF8FAFC),
                    hintText: 'Name',
                  ),
                ),
              );
            },
          ),
          Utils.verticalSpace(8),
          BlocBuilder<RestaurantProfileCubit, RestaurantProfileStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Email',
                child: TextFormField(
                  initialValue: state.ownerEmail,
                  onChanged: resProCubit.ownerEmail,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF8FAFC),
                    hintText: 'Name',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
