import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

import '../../../domain/entities/movie.dart';

class MoviesMap extends StatefulWidget {
  // TODO: передавать фильмы для отображения кооррдинат и нажатия
  // final List<Movie> movies;

  const MoviesMap({
    super.key,
    // required this.movies,
  });

  @override
  State<StatefulWidget> createState() => _MoviesMapState();
}

class _MoviesMapState extends State<MoviesMap> {
  @override
  Widget build(BuildContext context) {
    final bounds = LatLngBounds(LatLng(-90.0, -180.0), LatLng(90.0, 180.0));
    return Container(
      height: 300,
      width: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FlutterMap(
          // TODO: попробовать инициировать карту в зависимости от средних координат фильмов на текущей странице (убрать const)
          options: MapOptions(
              initialCenter: const LatLng(0.0, 0.0),
              initialZoom: 3.0,
              cameraConstraint: CameraConstraint.contain(bounds: bounds)
          ),
/*
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(
              source: 'OpenStreetMap contributors',
              onSourceTapped: null,
            ),
          ],
*/
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'itmo.is.lab1',
              tileProvider: CancellableNetworkTileProvider(),
            ),
            // TODO: Добавить координаты фильмов
/*
            MarkerLayer(
              markers: [
                Marker(
                  width: 50,
                  height: 50,
                  point: LatLng(latitude, longitude),
                  builder: (ctx) => Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              ],
            ),
*/
          ],
        ),
      ),
    );
  }
}
