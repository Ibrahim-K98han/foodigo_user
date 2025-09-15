import 'package:flutter/material.dart';

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
  String? selectedCountryValue;
  String? selectedCityValue;
  String? selectedStateValue;
  final List<String> countryItems = ['Bangladesh', 'Afghanistan', 'Pakistan'];
  final List<String> cityItems = ['Dhaka', 'Kabul'];
  final List<String> stateItems = ['Dhaka', 'Kabul'];
  @override
  Widget build(BuildContext context) {
    return  UpdateProductTile(
      title: 'Restaurant Info',
      widget: Column(
        children: [
          CustomFormWidget(
            label: 'Restaurant Name',
            child: TextFormField(
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
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xffF8FAFC),
                hintText: '+725415454',
              ),
            ),
          ),
          Utils.verticalSpace(12),
          const Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: 'Country',
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          Utils.verticalSpace(4),
          DropdownButtonFormField<String>(
            hint: const CustomText(
              text: "Country",
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
            isDense: true,
            isExpanded: true,
            dropdownColor: whiteColor,
            value: selectedCountryValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            decoration: InputDecoration(
              fillColor: const Color(0xffF8FAFC),
              filled: true,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(Utils.radius(10.0)),
                ),
              ),
              contentPadding: const EdgeInsets.fromLTRB(
                16.0,
                24.0,
                20.0,
                10.0,
              ),
            ),
            onTap: () => Utils.closeKeyBoard(context),
            onChanged: (value) {
              setState(() {
                selectedCountryValue = value;
              });
            },
            items: countryItems.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: CustomText(text: value),
              );
            }).toList(),
          ),
          Utils.verticalSpace(12),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: 'City',
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    Utils.verticalSpace(4),
                    DropdownButtonFormField<String>(
                      hint: const CustomText(
                        text: "City",
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                      isDense: true,
                      isExpanded: true,
                      dropdownColor: whiteColor,
                      value: selectedStateValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                        fillColor: const Color(0xffF8FAFC),
                        filled: true,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Utils.radius(10.0)),
                          ),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(
                          16.0,
                          24.0,
                          20.0,
                          10.0,
                        ),
                      ),
                      onTap: () => Utils.closeKeyBoard(context),
                      onChanged: (value) {
                        setState(() {
                          selectedStateValue = value;
                        });
                      },
                      items: stateItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: CustomText(text: value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Utils.horizontalSpace(8),
              Expanded(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: 'State',
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    Utils.verticalSpace(4),
                    DropdownButtonFormField<String>(
                      hint: const CustomText(
                        text: "State",
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                      isDense: true,
                      isExpanded: true,
                      dropdownColor: whiteColor,
                      value: selectedCityValue,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      decoration: InputDecoration(
                        fillColor: const Color(0xffF8FAFC),
                        filled: true,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(Utils.radius(10.0)),
                          ),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(
                          16.0,
                          24.0,
                          20.0,
                          10.0,
                        ),
                      ),
                      onTap: () => Utils.closeKeyBoard(context),
                      onChanged: (value) {
                        setState(() {
                          selectedCityValue = value;
                        });
                      },
                      items: cityItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: CustomText(text: value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Utils.verticalSpace(12),
          CustomFormWidget(
            label: 'Address',
            child: TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xffF8FAFC),
                hintText: 'Bangladesh',
              ),
            ),
          ),
          Utils.verticalSpace(12),
          CustomFormWidget(
            label: 'Bio',
            child: TextFormField(
              maxLines: 4,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color(0xffF8FAFC),
                hintText: 'Mirpur - 10, Dhaka',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
