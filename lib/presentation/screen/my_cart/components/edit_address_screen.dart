import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/address/cubit/get_address_cubit.dart';
import 'package:foodigo/features/address/cubit/get_address_state.dart';
import 'package:foodigo/features/address/model/address_state_model.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/primary_button.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../utils/utils.dart';
import '../../../../widget/fetch_error_text.dart';
import 'map_pcker_screen.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late GetAddressCubit addAddressCubit;

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
        builder: (_) => MapPickerScreen(
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final isEdit = args?["isEdit"] ?? true;
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
                    children: [
                      CustomFormWidget(
                        label: 'Delivery Type',
                        bottomSpace: 14.0,
                        child: TextFormField(
                          initialValue: state.type,
                          onChanged: addAddressCubit.addressType,
                          decoration: const InputDecoration(
                            fillColor: Color(0xffF8FAFC),
                            filled: true,
                            hintText: 'delivery type',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                              errorText: 'Enter Valid type',
                            )
                          ]),
                        ),
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
                                controller:
                                    TextEditingController(text: state.address),
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
                        if (validate.errors.phone.isNotEmpty)
                          FetchErrorText(text: validate.errors.phone.first),
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
            addAddressCubit.addAddress();
            // addAddressCubit.updateAddress(addAddressCubit.addr!.id.toString());
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
