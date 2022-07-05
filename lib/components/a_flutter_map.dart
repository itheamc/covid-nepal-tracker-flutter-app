import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AFlutterMap extends StatelessWidget {
  final LatLng center;
  final double zoom;
  final double rotation;
  final MapController? mapController;
  final void Function(MapController controller)? onMapCreated;
  final List<Marker> markers;

  const AFlutterMap({
    Key? key,
    required this.center,
    this.zoom = 13.0,
    this.rotation = 0.0,
    this.mapController,
    this.onMapCreated,
    this.markers = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        onMapCreated: onMapCreated,
        center: center,
        zoom: zoom,
        rotation: rotation,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
          tileProvider: const NonCachingNetworkTileProvider(),
        ),
        MarkerLayerOptions(markers: markers)
      ],
      nonRotatedChildren: [
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            "@amit",
            style: theme.textTheme.labelSmall,
          ),
        )
      ],
    );
  }
}
