import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_cubit.dart';
import '../../../../features/restaurant_features/RestaurantProfile/cubit/restaurant_profile_state.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_form.dart';
import '../../../../widget/custom_text_style.dart';
import '../../my_menu/components/edit_food_screen.dart';

class RestaurantInfo extends StatefulWidget {
  const RestaurantInfo({super.key});

  @override
  State<RestaurantInfo> createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();


  String? selectedCountryValue;
  String? selectedCityValue;
  String? selectedStateValue;

  final List<String> countryItems = ['Bangladesh', 'Afghanistan', 'Pakistan'];
  final List<String> cityItems = ['Dhaka', 'Kabul'];
  final List<String> stateItems = ['Dhaka', 'Kabul'];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantProfileCubit, RestaurantProfileState>(
      builder: (context, state) {
        if (state is RestaurantProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is RestaurantProfileLoaded) {
          final profile = state.restaurantProfileModel.restaurantProfile;
          if (_nameController.text.isEmpty) {
            _nameController.text = profile?.restaurantName ?? '';
          }
          if (_emailController.text.isEmpty) {
            _emailController.text = profile?.email ?? '';
          }
          if (_phoneController.text.isEmpty) {
            _phoneController.text = profile?.ownerPhone ?? '';
          }
          if (_addressController.text.isEmpty) {
            _addressController.text = profile?.address ?? '';
          }
          if (_bioController.text.isEmpty) {
            _bioController.text = profile?.cityId ?? '';
          }

          // Dropdowns – only assign if exists in list
          final country = profile?.cityId ?? '';
          if (countryItems.contains(country)) {
            selectedCountryValue = country;
          }

          final city = profile?.cityId ?? '';
          if (cityItems.contains(city)) {
            selectedCityValue = city;
          }

          final stateName = profile?.slug ?? '';
          if (stateItems.contains(stateName)) {
            selectedStateValue = stateName;
          }
        }


        return UpdateProductTile(
          title: 'Restaurant Info',
          widget: Column(
            children: [
              CustomFormWidget(
                label: 'Restaurant Name',
                child: TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF8FAFC),
                    hintText: 'Chefs place',
                  ),
                ),
              ),
              Utils.verticalSpace(12),
              CustomFormWidget(
                label: 'Email',
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF8FAFC),
                    hintText: 'chef@gmail.com',
                  ),
                ),
              ),
              Utils.verticalSpace(12),
              CustomFormWidget(
                label: 'Phone Number',
                child: TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF8FAFC),
                    hintText: '+725415454',
                  ),
                ),
              ),
              Utils.verticalSpace(12),

              // Country
              // const Align(
              //   alignment: Alignment.centerLeft,
              //   child: CustomText(
              //     text: 'Country',
              //     fontWeight: FontWeight.w500,
              //     color: textColor,
              //   ),
              // ),
              Utils.verticalSpace(4),
              // DropdownButtonFormField<String>(
              //   value: selectedCountryValue,
              //   hint: const CustomText(
              //     text: "Country",
              //     fontWeight: FontWeight.w500,
              //     color: textColor,
              //   ),
              //   isExpanded: true,
              //   dropdownColor: whiteColor,
              //   icon: const Icon(Icons.keyboard_arrow_down),
              //   decoration: const InputDecoration(
              //     fillColor: Color(0xffF8FAFC),
              //     filled: true,
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(10),
              //       ),
              //     ),
              //   ),
              //   onChanged: (value) {
              //     setState(() => selectedCountryValue = value);
              //   },
              //   items: countryItems.map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: CustomText(text: value),
              //     );
              //   }).toList(),
              // ),
              // Utils.verticalSpace(12),

              // City & State
              // Row(
              //   children: [
              //     Expanded(
              //       child: DropdownButtonFormField<String>(
              //         value: selectedCityValue,
              //         hint: const CustomText(
              //           text: "City",
              //           fontWeight: FontWeight.w500,
              //           color: textColor,
              //         ),
              //         isExpanded: true,
              //         onChanged: (value) {
              //           setState(() => selectedCityValue = value);
              //         },
              //         items: cityItems.map((String value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: CustomText(text: value),
              //           );
              //         }).toList(),
              //       ),
              //     ),
              //     Utils.horizontalSpace(8),
              //     Expanded(
              //       child: DropdownButtonFormField<String>(
              //         value: selectedStateValue,
              //         hint: const CustomText(
              //           text: "State",
              //           fontWeight: FontWeight.w500,
              //           color: textColor,
              //         ),
              //         isExpanded: true,
              //         onChanged: (value) {
              //           setState(() => selectedStateValue = value);
              //         },
              //         items: stateItems.map((String value) {
              //           return DropdownMenuItem<String>(
              //             value: value,
              //             child: CustomText(text: value),
              //           );
              //         }).toList(),
              //       ),
              //     ),
              //   ],
              // ),

              // Utils.verticalSpace(12),
              CustomFormWidget(
                label: 'Address',
                child: TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF8FAFC),
                    hintText: 'Bangladesh',
                  ),
                ),
              ),
              Utils.verticalSpace(12),
              // CustomFormWidget(
              //   label: 'Bio',
              //   child: TextFormField(
              //     controller: _bioController,
              //     maxLines: 4,
              //     decoration: const InputDecoration(
              //       filled: true,
              //       fillColor: Color(0xffF8FAFC),
              //       hintText: 'Mirpur - 10, Dhaka',
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
