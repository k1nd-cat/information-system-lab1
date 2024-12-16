import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

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
    final bounds = LatLngBounds(const LatLng(-90.0, -180.0), const LatLng(90.0, 180.0));
    return Container(
      height: 300,
      width: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color.fromRGBO(242, 196, 206, 1), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FlutterMap(
          // TODO: попробовать инициировать карту в зависимости от средних координат фильмов на текущей странице (убрать const)
          options: MapOptions(
              initialCenter: const LatLng(0.0, 0.0),
              initialZoom: 2.0,
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
              // urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              urlTemplate: "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png",
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
