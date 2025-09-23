import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_cubit.dart';
import '../../../../features/restaurant_features/RestaurantProfile/model/restaurant_profile_state_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_form.dart';
import '../../my_menu/components/edit_food_screen.dart';

class RestaurantOwnerInfo extends StatefulWidget {
  const RestaurantOwnerInfo({super.key});

  @override
  State<RestaurantOwnerInfo> createState() => _RestaurantOwnerInfoState();
}

class _RestaurantOwnerInfoState extends State<RestaurantOwnerInfo> {
  late RestaurantProfileCubit resProCubit;

  @override
  void initState() {
    super.initState();
    resProCubit = context.read<RestaurantProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return UpdateProductTile(
      title: 'Restaurant Owner  Info',
      widget: Column(
        children: [
          BlocBuilder<RestaurantProfileCubit, RestaurantProfileStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Name',
                child: TextFormField(
                  initialValue: state.ownerName,
                  onChanged: resProCubit.ownerName,
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
                    hintText: 'email',
                  ),
                ),
              );
            },
          ),
          Utils.verticalSpace(8),
          BlocBuilder<RestaurantProfileCubit, RestaurantProfileStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Phone',
                child: TextFormField(
                  initialValue: state.ownerPhoneNumber,
                  onChanged: resProCubit.ownerPhone,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF8FAFC),
                    hintText: 'phone',
                  ),
                ),
              );
            },
          ),
          BlocBuilder<RestaurantProfileCubit, RestaurantProfileStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'WhatsApp',
                child: TextFormField(
                  initialValue: state.whatsappNumber,
                  onChanged: resProCubit.whatsapp,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF8FAFC),
                    hintText: 'WhatsApp',
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
