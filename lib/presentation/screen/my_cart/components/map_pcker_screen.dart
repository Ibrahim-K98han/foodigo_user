
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    selectedPosition = widget.initialPosition;
    super.initState();
  }

  Future<String?> getAddress(LatLng position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
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
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition:
            CameraPosition(target: widget.initialPosition, zoom: 8),
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
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () async {
                String? address = await getAddress(selectedPosition);
                String? landmark = await getAddress(selectedPosition);
                Navigator.pop(context, {
                  'lat': selectedPosition.latitude,
                  'lng': selectedPosition.longitude,
                  'address': address ?? '',
                  'landmark': landmark ?? '',
                });
              },
              child: const Text('Select This Location'),
            ),
          ),
        ],
      ),
    );
  }
}
