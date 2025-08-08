import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  final MapController controller = MapController(
    initPosition: GeoPoint(latitude: 30.025341, longitude: 31.201789),
    areaLimit: const BoundingBox(
      east: 10.4922941,
      north: 47.8084648,
      south: 45.817995,
      west: 5.9559113,
    ),
  );

  final TextEditingController searchController = TextEditingController();

  Future<void> searchLocation() async {
    final text = searchController.text.trim();
    if (text.isNotEmpty) {
      final suggestions = await addressSuggestion(text);
      if (suggestions.isNotEmpty) {
        // خليك على أول نتيجة
        final first = suggestions.first;
        await controller.goToLocation(
          GeoPoint(
            latitude: first.point!.latitude,
            longitude: first.point!.longitude,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('اختر الموقع'), centerTitle: true),
      body: Stack(
        children: [
          OSMFlutter(
            controller: controller,
            osmOption: OSMOption(
              userTrackingOption: const UserTrackingOption(
                enableTracking: true,
                unFollowUser: false,
              ),
              zoomOption: const ZoomOption(
                initZoom: 13,
                minZoomLevel: 3,
                maxZoomLevel: 19,
                stepZoom: 1.0,
              ),
              userLocationMarker: UserLocationMaker(
                personMarker: const MarkerIcon(
                  icon: Icon(
                    Icons.location_history_rounded,
                    color: Colors.red,
                    size: 48,
                  ),
                ),
                directionArrowMarker: const MarkerIcon(
                  icon: Icon(Icons.double_arrow, size: 48),
                ),
              ),
              roadConfiguration: const RoadOption(
                roadColor: Colors.yellowAccent,
              ),
            ),
          ),

          // مربع البحث
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: const InputDecoration(
                        hintText: 'ابحث عن مكان...',
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => searchLocation(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: searchLocation,
                  ),
                ],
              ),
            ),
          ),

          // زر اختيار الموقع
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.check),
              label: const Text("تأكيد اختيار الموقع"),
              onPressed: () async {
                final location = await controller.myLocation();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'تم اختيار: ${location.latitude}, ${location.longitude}',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
