import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_cubit.dart';
import '../../../../features/restaurant_features/RestaurantProfile/model/restaurant_profile_state_model.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_form.dart';
import '../../my_menu/components/edit_food_screen.dart';

class OtherInfo extends StatefulWidget {
  const OtherInfo({super.key});

  @override
  State<OtherInfo> createState() => _OtherInfoState();
}

class _OtherInfoState extends State<OtherInfo> {
  late RestaurantProfileCubit resProCubit;

  @override
  void initState() {
    super.initState();
    resProCubit = context.read<RestaurantProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return UpdateProductTile(
      title: 'Others Info',
      widget: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: BlocBuilder<RestaurantProfileCubit,
                    RestaurantProfileStateModel>(
                  builder: (context, state) {
                    return CustomFormWidget(
                      label: 'Opening Hour',
                      child: TextFormField(
                        initialValue: state.openingHours,
                        onChanged: resProCubit.openingHour,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: 'Opening Hour',
                        ),
                      ),
                    );
                  },
                ),
              ),
              Utils.horizontalSpace(12),
              Expanded(
                child: BlocBuilder<RestaurantProfileCubit,
                    RestaurantProfileStateModel>(
                  builder: (context, state) {
                    return CustomFormWidget(
                      label: 'Closing Hour',
                      child: TextFormField(
                        initialValue: state.closingHours,
                        onChanged: resProCubit.closingHour,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: 'Closing Hour',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Utils.verticalSpace(12),
          Row(
            children: [
              Expanded(
                child: BlocBuilder<RestaurantProfileCubit,
                    RestaurantProfileStateModel>(
                  builder: (context, state) {
                    return CustomFormWidget(
                      label: 'Min time(minute)',
                      child: TextFormField(
                        initialValue: state.minProcessingTime,
                        onChanged: resProCubit.minProcessingTime,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: 'Minimum food processing time',
                        ),
                      ),
                    );
                  },
                ),
              ),
              Utils.horizontalSpace(12),
              Expanded(
                child: BlocBuilder<RestaurantProfileCubit,
                    RestaurantProfileStateModel>(
                  builder: (context, state) {
                    return CustomFormWidget(
                      label: 'Max time(minute)',
                      child: TextFormField(
                        initialValue: state.maxProcessingTime,
                        onChanged: resProCubit.maxProcessingTime,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: 'Maximum food processing time',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Utils.verticalSpace(12),
          Row(
            children: [
              Expanded(
                child: BlocBuilder<RestaurantProfileCubit,
                    RestaurantProfileStateModel>(
                  builder: (context, state) {
                    return CustomFormWidget(
                      label: 'Time slot (minute)',
                      child: TextFormField(
                        initialValue: state.timeSlotSeparator,
                        onChanged: resProCubit.timeSlot,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: '20',
                        ),
                      ),
                    );
                  },
                ),
              ),
              Utils.horizontalSpace(12),
              Expanded(
                child: BlocBuilder<RestaurantProfileCubit,
                    RestaurantProfileStateModel>(
                  builder: (context, state) {
                    return CustomFormWidget(
                      label: 'Tags',
                      child: TextFormField(
                        initialValue: state.tags,
                        onChanged: resProCubit.tags,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
