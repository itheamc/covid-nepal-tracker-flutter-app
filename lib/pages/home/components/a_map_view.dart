import 'package:covid_nepal_tracker/components/a_flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AMapView extends StatefulWidget {
  const AMapView({Key? key}) : super(key: key);

  @override
  State<AMapView> createState() => _AMapViewState();
}

class _AMapViewState extends State<AMapView> {
  // Map controller to play with the map
  MapController? _mapController;

  // Center Lat long position to load the map
  final _center = LatLng(28.39, 84.12);

  // Method to handle the setting map controller whenever map is loaded
  void _onMapLoaded(MapController controller) => _mapController ??= controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AFlutterMap(
      mapController: _mapController,
      center: _center,
      onMapCreated: _onMapLoaded,
      zoom: 6.0,
      markers: [
        LatLng(28.407784, 81.574720),
        LatLng(28.274037, 84.354908),
        LatLng(27.027043, 85.923840)
      ]
          .map(
            (e) => Marker(
              width: 48.0,
              height: 48.0,
              point: e,
              builder: (_) => Stack(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    size: 48.0,
                    color: Colors.red.shade700,
                  ),
                  Center(
                    child: Text(
                      "5000",
                      style: theme.textTheme.caption
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
