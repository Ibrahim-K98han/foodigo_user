import 'package:flutter/material.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/primary_button.dart';

import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  String? selectedCountryValue;
  final List<String> countryItems = ['Bangladesh', 'Afghanistan'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Address'),
      body: Padding(
        padding: Utils.symmetric(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              CustomFormWidget(
                label: 'Full Name',
                bottomSpace: 14.0,
                child: TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Color(0xffF8FAFC),
                    filled: true,
                    hintText: 'full name',
                  ),
                ),
              ),
              CustomFormWidget(
                label: 'Email',
                bottomSpace: 14.0,
                child: TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Color(0xffF8FAFC),
                    filled: true,
                    hintText: 'email',
                  ),
                ),
              ),
              CustomFormWidget(
                label: 'Phone',
                bottomSpace: 14.0,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    fillColor: Color(0xffF8FAFC),
                    filled: true,
                    hintText: 'phone',
                  ),
                ),
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: 'Country',
                    fontWeight: FontWeight.w500,
                    color: settingsIconBgColor,
                  )),
              Utils.verticalSpace(6.0),
              DropdownButtonFormField<String>(
                hint: const CustomText(
                  text: "country",
                  fontWeight: FontWeight.w500,
                  color: settingsIconBgColor,
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
              Utils.verticalSpace(16),
              Row(
                children: [
                  Expanded(
                    child: CustomFormWidget(
                      label: 'State',
                      bottomSpace: 14.0,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          fillColor: Color(0xffF8FAFC),
                          filled: true,
                          hintText: 'state',
                        ),
                      ),
                    ),
                  ),
                  Utils.horizontalSpace(10.0),
                  Expanded(
                    child: CustomFormWidget(
                      label: 'City',
                      bottomSpace: 14.0,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          fillColor: Color(0xffF8FAFC),
                          filled: true,
                          hintText: 'city',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CustomFormWidget(
                label: 'Address',
                bottomSpace: 14.0,
                child: TextFormField(
                  decoration: const InputDecoration(
                    fillColor: Color(0xffF8FAFC),
                    filled: true,
                    hintText: 'mirpur-10',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: PrimaryButton(text: 'Update Now', onPressed: () {}),
      ),
    );
  }
}
