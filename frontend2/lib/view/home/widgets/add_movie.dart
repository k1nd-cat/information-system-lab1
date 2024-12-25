import 'package:flutter/material.dart';
import 'package:frontend2/view/home/add_update_movie_screen.dart';

class AddMovie extends StatelessWidget {
  const AddMovie({super.key});

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog(
        context: context, builder: (BuildContext context) => const AddUpdateMovieScreen());
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _dialogBuilder(context),
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromRGBO(44, 43, 48, 1),
        minimumSize: const Size(507, 54),
        backgroundColor: const Color.fromRGBO(242, 196, 206, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: const Text('Добавить фильм'),
    );
  }
}
