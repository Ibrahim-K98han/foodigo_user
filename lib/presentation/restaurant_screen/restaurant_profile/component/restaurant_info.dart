import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_cubit.dart';
import '../../../../features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_state.dart';
import '../../../../features/restaurant_features/RestaurantProfile/model/restaurant_profile_state_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_form.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../screen/my_cart/components/map_pcker_screen.dart';
import '../../my_menu/components/edit_food_screen.dart';

class RestaurantInfo extends StatefulWidget {
  const RestaurantInfo({super.key});

  @override
  State<RestaurantInfo> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  String? selectedCityValue;
  String? selectedCuisineValue;
  late RestaurantProfileCubit resProCubit;

  @override
  void initState() {
    super.initState();
    resProCubit = context.read<RestaurantProfileCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return UpdateProductTile(
      title: 'Restaurant Info',
      widget: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: BlocBuilder<RestaurantProfileCubit,
                    RestaurantProfileStateModel>(
                  builder: (context, state) {
                    return CustomFormWidget(
                      label: 'Restaurant Name',
                      child: TextFormField(
                        initialValue: state.restaurantName,
                        onChanged: resProCubit.restaurantName,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: 'Chefs place',
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
                      label: 'Slug',
                      child: TextFormField(
                        initialValue: state.slug,
                        onChanged: resProCubit.slug,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: 'slug',
                        ),
                      ),
                    );
                  },
                ),
              )
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
                      label: 'Email',
                      child: TextFormField(
                        initialValue: state.ownerEmail,
                        onChanged: resProCubit.ownerEmail,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: 'chef@gmail.com',
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
                      label: 'Phone Number',
                      child: TextFormField(
                        initialValue: state.whatsappNumber,
                        onChanged: resProCubit.whatsapp,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: '+725415454',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'City',
                      color: labelColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    BlocBuilder<RestaurantProfileCubit,
                        RestaurantProfileStateModel>(
                      builder: (context, state) {
                        return DropdownButtonFormField<String>(
                          value: selectedCityValue,
                          hint: const CustomText(
                            text: "City",
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            resProCubit.cityId(value!);
                          },
                          items:
                              (resProCubit.restaurantProfileModel?.cities ?? [])
                                  .map((city) {
                            return DropdownMenuItem<String>(
                              value: city.id.toString(),
                              // or just `city` if it's String
                              child: CustomText(text: city.name),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Utils.horizontalSpace(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      text: 'Cuisine',
                      color: labelColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    BlocBuilder<RestaurantProfileCubit,
                        RestaurantProfileStateModel>(
                      builder: (context, state) {
                        return DropdownButtonFormField<String>(
                          value: selectedCuisineValue,
                          hint: const CustomText(
                            text: "Cuisine",
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                          isExpanded: true,
                          onChanged: (value) {
                            if (value != null) {
                              resProCubit.cuisines([value]); // wrap in list
                            }
                          },
                          items:
                              (resProCubit.restaurantProfileModel?.cuisines ??
                                      [])
                                  .map((cuisineId) {
                            return DropdownMenuItem<String>(
                              value: cuisineId.id.toString(),
                              child: CustomText(
                                  text: cuisineId.name), // or map ID to name
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Utils.verticalSpace(12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: BlocBuilder<RestaurantProfileCubit,
                    RestaurantProfileStateModel>(
                  builder: (context, state) {
                    return CustomFormWidget(
                      label: 'Address',
                      child: TextFormField(
                        key: ValueKey(state.address),
                        initialValue: state.address,
                        onChanged: resProCubit.address,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF8FAFC),
                          hintText: 'Bangladesh',
                        ),
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                  onPressed: () async {
                    final lat =
                        double.tryParse(resProCubit.state.latitude) ?? 0.0;
                    final lng =
                        double.tryParse(resProCubit.state.longitude) ?? 0.0;

                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MapPickerScreen(
                          initialPosition: LatLng(lat, lng),
                        ),
                      ),
                    );

                    if (result != null) {
                      resProCubit.latitude(result['lat'].toString());
                      resProCubit.longitude(result['lng'].toString());
                      resProCubit.address(result['address']);
                    }
                  },
                  icon: const Icon(Icons.location_on)),
            ],
          ),
          Utils.verticalSpace(12),
          BlocBuilder<RestaurantProfileCubit, RestaurantProfileStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Latitude ',
                child: TextFormField(
                  key: ValueKey(state.latitude),
                  readOnly: true,
                  initialValue: state.latitude,
                  onChanged: resProCubit.latitude,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF8FAFC),
                  ),
                ),
              );
            },
          ),
          BlocBuilder<RestaurantProfileCubit, RestaurantProfileStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Longitude ',
                child: TextFormField(
                  key: ValueKey(state.longitude),
                  readOnly: true,
                  initialValue: state.longitude,
                  onChanged: resProCubit.longitude,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF8FAFC),
                  ),
                ),
              );
            },
          ),
          BlocBuilder<RestaurantProfileCubit, RestaurantProfileStateModel>(
            builder: (context, state) {
              return CustomFormWidget(
                label: 'Maximum Delivery Distance (km)',
                child: TextFormField(
                  initialValue: state.maxDeliveryDistance,
                  onChanged: resProCubit.maxDeliveryDistance,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF8FAFC),
                    hintText: 'Maximum Delivery Distance',
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
