import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import '../../services/location_service.dart';

class PickLocationScreen extends StatefulWidget {
  const PickLocationScreen({super.key});

  @override
  State<PickLocationScreen> createState() => _PickLocationScreenState();
}

class _PickLocationScreenState extends State<PickLocationScreen> {
  LatLng? selectedPoint;
  String? selectedAddress;

  @override
  void initState() {
    super.initState();
    _initCurrentLocation();
  }

  /// جلب موقع المستخدم الحالي باستخدام الـ LocationService
  Future<void> _initCurrentLocation() async {
    final position = await LocationService.getCurrentPosition();
    if (position != null && mounted) {
      setState(() {
        selectedPoint = LatLng(position.latitude, position.longitude);
      });
      _getAddress(selectedPoint!);
    }
  }

  Future<void> _getAddress(LatLng point) async {
    final placemarks = await placemarkFromCoordinates(
      point.latitude,
      point.longitude,
    );
    if (placemarks.isNotEmpty && mounted) {
      final p = placemarks.first;
      setState(() {
        selectedAddress =
            '${p.street ?? ''}, ${p.locality ?? ''}, ${p.country ?? ''}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Location')),
      body: FlutterMap(
        options: MapOptions(
          // لو مفيش نقطة مختارة، نبدأ من القاهرة كافتراضي
          initialCenter: selectedPoint ?? const LatLng(30.0444, 31.2357),
          initialZoom: 13,
          onTap: (tapPosition, point) {
            setState(() => selectedPoint = point);
            _getAddress(point);
          },
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
          ),
          if (selectedPoint != null)
            MarkerLayer(
              markers: [
                Marker(
                  point: selectedPoint!,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.location_on, color: Colors.red),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedPoint != null) {
            Navigator.pop(context, {
              'lat': selectedPoint!.latitude,
              'lng': selectedPoint!.longitude,
              'address': selectedAddress ?? '',
            });
          } else {
            Navigator.pop(context, null);
          }
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
