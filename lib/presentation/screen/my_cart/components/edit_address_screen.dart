import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/address/cubit/get_address_cubit.dart';
import 'package:foodigo/features/address/cubit/get_address_state.dart';
import 'package:foodigo/features/address/model/address_state_model.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/primary_button.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:foodigo/features/address/model/address_model.dart';
import '../../../../utils/constraints.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/custom_text_style.dart';
import '../../../../widget/fetch_error_text.dart';
import 'map_pcker_screen.dart';


class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late GetAddressCubit addAddressCubit;
  String? selectDeliveryType;
  final List<String> deliveryValue = ['home', 'office'];

  Future<void> pickLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Location permissions are permanently denied. Please enable them in settings.')),
      );
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            MapPickerScreen(
              initialPosition: LatLng(position.latitude, position.longitude),
            ),
      ),
    );
    if (result != null) {
      addAddressCubit.latitude(result['lat'].toString());
      addAddressCubit.longitude(result['lng'].toString());
      addAddressCubit.address(result['address']);
      addAddressCubit.landMark(result['landmark']);
    }
  }

  @override
  void initState() {
    addAddressCubit = context.read<GetAddressCubit>();
    addAddressCubit.getAllAddressData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
    ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>?;
    final isEdit = args?["isEdit"] ?? true;
    final Address? editAddress = args?["address"];
    if (isEdit && editAddress != null) {
      addAddressCubit.addressType(editAddress.deliveryType);
      addAddressCubit.fullName(editAddress.name);
      addAddressCubit.email(editAddress.email);
      addAddressCubit.phone(editAddress.phone);
      addAddressCubit.address(editAddress.address);
      addAddressCubit.latitude(editAddress.lat);
      addAddressCubit.longitude(editAddress.lon);

    }
    return Scaffold(
      appBar: CustomAppBar(title: isEdit ? 'Edit Address' : 'Add Address'),
      body: Padding(
          padding: Utils.symmetric(),
          child: ListView(
            children: [
              BlocBuilder<GetAddressCubit, AddressStateModel>(
                builder: (context, state) {
                  final validate = state.addressState;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Delivery Type',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      Utils.verticalSpace(4),
                      DropdownButtonFormField<String>(
                        dropdownColor: whiteColor,
                        value: selectDeliveryType,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 14,
                          ),
                        ),
                        hint: const CustomText(
                            text: 'Delivery Type', color: lightGrayColor),
                        items: deliveryValue.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: CustomText(text: value, fontSize: 14),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          addAddressCubit.addressType(newValue!);
                        },
                        validator: (value) =>
                        value == null ? 'Please select an option' : null,
                      ),
                      if (validate is UpdateAddressFormValidate) ...[
                        if (validate.errors.addressType.isNotEmpty)
                          FetchErrorText(
                              text: validate.errors.addressType.first),
                      ]
                    ],
                  );
                },
              ),
              Utils.verticalSpace(14),
              BlocBuilder<GetAddressCubit, AddressStateModel>(
                builder: (context, state) {
                  final validate = state.addressState;
                  return Column(
                    children: [
                      CustomFormWidget(
                        label: 'Full Name',
                        bottomSpace: 14.0,
                        child: TextFormField(
                          initialValue: state.name,
                          onChanged: addAddressCubit.fullName,
                          decoration: const InputDecoration(
                            fillColor: Color(0xffF8FAFC),
                            filled: true,
                            hintText: 'full name',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Enter Name',
                            )
                          ]),
                        ),
                      ),
                      if (validate is UpdateAddressFormValidate) ...[
                        if (validate.errors.name.isNotEmpty)
                          FetchErrorText(text: validate.errors.name.first),
                      ]
                    ],
                  );
                },
              ),
              BlocBuilder<GetAddressCubit, AddressStateModel>(
                builder: (context, state) {
                  final validate = state.addressState;
                  return Column(
                    children: [
                      CustomFormWidget(
                        label: 'Email',
                        bottomSpace: 14.0,
                        child: TextFormField(
                          initialValue: state.email,
                          onChanged: addAddressCubit.email,
                          decoration: const InputDecoration(
                            fillColor: Color(0xffF8FAFC),
                            filled: true,
                            hintText: 'email',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Enter Email',
                            )
                          ]),
                        ),
                      ),
                      if (validate is UpdateAddressFormValidate) ...[
                        if (validate.errors.email.isNotEmpty)
                          FetchErrorText(text: validate.errors.email.first),
                      ]
                    ],
                  );
                },
              ),
              BlocBuilder<GetAddressCubit, AddressStateModel>(
                builder: (context, state) {
                  final validate = state.addressState;
                  return Column(
                    children: [
                      CustomFormWidget(
                        label: 'Phone',
                        bottomSpace: 14.0,
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          initialValue: state.phone,
                          onChanged: addAddressCubit.phone,
                          decoration: const InputDecoration(
                            fillColor: Color(0xffF8FAFC),
                            filled: true,
                            hintText: 'phone',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Enter Phone number',
                            )
                          ]),
                        ),
                      ),
                      if (validate is UpdateAddressFormValidate) ...[
                        if (validate.errors.phone.isNotEmpty)
                          FetchErrorText(text: validate.errors.phone.first),
                      ]
                    ],
                  );
                },
              ),
              BlocBuilder<GetAddressCubit, AddressStateModel>(
                builder: (context, state) {
                  final validate = state.addressState;
                  return Column(
                    children: [
                      CustomFormWidget(
                        label: 'Address',
                        bottomSpace: 14.0,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                key: ValueKey(state.address),
                                initialValue: state.address,
                                onChanged: addAddressCubit.address,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  fillColor: Color(0xffF8FAFC),
                                  filled: true,
                                  hintText: 'Select Address on Map',
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(
                                    errorText: 'Enter Address',
                                  )
                                ]),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await pickLocation();
                              },
                              icon: const Icon(Icons.location_on),
                            ),
                          ],
                        ),
                      ),
                      if (validate is UpdateAddressFormValidate) ...[
                        if (validate.errors.address.isNotEmpty)
                          FetchErrorText(text: validate.errors.address.first),
                      ]
                    ],
                  );
                },
              ),
            ],
          )),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: PrimaryButton(
          text: isEdit ? 'Update Now' : 'Save',
          onPressed: () {
            if (isEdit && editAddress != null) {
              addAddressCubit.updateAddress(editAddress.id.toString());
            } else {
              addAddressCubit.addAddress();
            }
            addAddressCubit.clearForm();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

