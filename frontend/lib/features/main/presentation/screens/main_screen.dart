import 'package:flutter/material.dart';
import 'package:frontend/features/main/presentation/screens/widgets/map_view.dart';
import 'package:frontend/features/main/presentation/screens/widgets/movie_list.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Screen")),
      body: const Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MovieListPage(),
            MoviesMap(),
          ],
        ),
      ),
    );
  }
}
