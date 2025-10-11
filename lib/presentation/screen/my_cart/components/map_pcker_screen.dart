import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodigo/features/address/cubit/get_address_cubit.dart';
import 'package:foodigo/features/address/model/address_state_model.dart';
import 'package:foodigo/widget/custom_text_style.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPickerScreen extends StatefulWidget {
  final LatLng initialPosition;

  const MapPickerScreen({super.key, required this.initialPosition});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late LatLng selectedPosition;
  late GetAddressCubit getCubit;

  @override
  void initState() {
    selectedPosition = widget.initialPosition;
    getCubit = context.read<GetAddressCubit>();
    super.initState();
  }

  Future<String?> getAddress(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        return '${place.street}, ${place.locality}, ${place.country}';
      }
      return null;
    } catch (e) {
      print('Error getting address: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick Location')),
      body: BlocBuilder<GetAddressCubit, AddressStateModel>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: widget.initialPosition,
                  zoom: 8,
                ),
                onTap: (position) {
                  setState(() {
                    selectedPosition = position;
                  });
                },
                markers: {
                  Marker(
                    markerId: const MarkerId('selected'),
                    position: selectedPosition,
                  ),
                },
              ),
              Positioned(
                top: 20.h,
                right: 20.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150.w, 40.h),
                    textStyle: const TextStyle(fontSize: 16),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () async {
                    String? address = await getAddress(selectedPosition);
                    String? landmark = await getAddress(selectedPosition);

                    getCubit.latitude(selectedPosition.latitude.toString());
                    getCubit.longitude(selectedPosition.longitude.toString());
                    getCubit.address(address ?? '');

                    Navigator.pop(context, {
                      'lat': selectedPosition.latitude,
                      'lng': selectedPosition.longitude,
                      'address': address ?? '',
                      'landmark': landmark ?? '',
                    });
                  },
                  child: const CustomText(
                    text: 'Select Location',
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
