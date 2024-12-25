import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend2/view/home/widgets/movie_details.dart';
import 'package:frontend2/viewmodel/authentication_viewmodel.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:provider/provider.dart';

import '../../../model/movies.dart' as model;

class MoviesMap extends StatefulWidget {
  final List<model.Movie> movies;

  const MoviesMap({
    required this.movies,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _MoviesMapState();
}

class _MoviesMapState extends State<MoviesMap> {
  late final Map<String, Color> markerColors;
  late final LatLng initialCenter;

  @override
  initState() {
    markerColors = _generateColors(widget.movies);
    initialCenter = _initCenter();
    super.initState();
  }

  LatLng _initCenter() {
    var maxX = widget.movies
        .reduce((currentMax, movie) =>
            currentMax.coordinates.x > movie.coordinates.x ? currentMax : movie)
        .coordinates
        .x;
    var minX = widget.movies
        .reduce((currentMax, movie) =>
            currentMax.coordinates.x < movie.coordinates.x ? currentMax : movie)
        .coordinates
        .x;
    var maxY = widget.movies
        .reduce((currentMax, movie) =>
            currentMax.coordinates.y > movie.coordinates.y ? currentMax : movie)
        .coordinates
        .y;
    var minY = widget.movies
        .reduce((currentMax, movie) =>
            currentMax.coordinates.y < movie.coordinates.y ? currentMax : movie)
        .coordinates
        .y;

    var x = (maxX + minX) / 2;
    var y = (maxY + minY) / 2;
    return LatLng(x, y);
  }

  List<Marker> _createMarkers(BuildContext context) {
    var user = Provider.of<AuthenticationViewModel>(context, listen: false).user;
    return widget.movies.map((movie) {
      final color = markerColors[movie.creatorName ?? "Unknown"];
      return Marker(
          width: 70,
          height: 70,
          point: LatLng(movie.coordinates.x, movie.coordinates.y as double),
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      MovieDetailsDialog(movie: movie, user: user!));
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.movie,
                  color: color,
                ),
                Text(
                  movie.name,
                  style: const TextStyle(fontSize: 10),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ));
    }).toList();
  }

  Map<String, Color> _generateColors(List<model.Movie> movies) {
    final uniqueCreators = movies.map((movie) => movie.creatorName).toSet();
    final colors = <String, Color>{};

    int index = 0;
    for (final creator in uniqueCreators) {
      colors[creator ?? "Unknown"] = _generateColor(index);
      index++;
    }

    return colors;
  }

  Color _generateColor(int index) {
    const saturation = 0.7;
    const lightness = 0.6;
    final hue = (index * 137.508) % 360;
    return HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
  }

  @override
  Widget build(BuildContext context) {
    final bounds =
        LatLngBounds(const LatLng(-90.0, -180.0), const LatLng(90.0, 180.0));
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FlutterMap(
        options: MapOptions(
            initialCenter: initialCenter,
            initialZoom: 2.0,
            cameraConstraint: CameraConstraint.contain(bounds: bounds)),
        children: [
          TileLayer(
            urlTemplate:
                "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png",
            userAgentPackageName: 'itmo.is.lab1',
            tileProvider: CancellableNetworkTileProvider(),
          ),
          MarkerLayer(
            markers: _createMarkers(context),
          ),
        ],
      ),
    );
  }
}

class MovieMarker extends Marker {
  const MovieMarker({required super.point, required super.child});
}
