import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodigo/features/address/cubit/get_address_cubit.dart';
import 'package:foodigo/features/address/cubit/get_address_state.dart';
import 'package:foodigo/features/address/model/address_state_model.dart';
import 'package:foodigo/presentation/core/routes/route_names.dart';
import 'package:foodigo/widget/custom_appbar.dart';
import 'package:foodigo/widget/custom_form.dart';
import 'package:foodigo/widget/primary_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../utils/utils.dart';
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

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    // Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permission denied
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Location permissions are permanently denied. Please enable them in settings.')),
      );
      return;
    }

    // If permission granted, get location
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
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Address'),
      body: Padding(
        padding: Utils.symmetric(),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocConsumer<GetAddressCubit, AddressStateModel>(
            listener: (context, state) {
              if (state is AddAddressStateSuccess) {
                addAddressCubit.clearForm();
                Navigator.pushReplacementNamed(
                  context,
                  RouteNames.addressScreen,
                );
              }
            },
            builder: (context, state) {
              final cubit = context.read<GetAddressCubit>();
              return Column(
                children: [
                  CustomFormWidget(
                    label: 'Delivery Type',
                    bottomSpace: 14.0,
                    child: TextFormField(
                      initialValue: state.type,
                      onChanged: (value) => cubit.addressType(value),
                      decoration: const InputDecoration(
                        fillColor: Color(0xffF8FAFC),
                        filled: true,
                        hintText: 'delivery type',
                      ),
                    ),
                  ),
                  CustomFormWidget(
                    label: 'Full Name',
                    bottomSpace: 14.0,
                    child: TextFormField(
                      initialValue: state.name,
                      onChanged: (value) => cubit.fullName(value),
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
                      initialValue: state.email,
                      onChanged: (value) => cubit.email(value),
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
                      initialValue: state.phone,
                      onChanged: (value) => cubit.phone(value),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        fillColor: Color(0xffF8FAFC),
                        filled: true,
                        hintText: 'phone',
                      ),
                    ),
                  ),
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
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: Utils.symmetric(v: 20.0),
        child: PrimaryButton(
          text: 'Update Now',
          onPressed: () {
            addAddressCubit.addAddress();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
