import 'package:flutter/material.dart';
import 'package:frontend2/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

import 'person_details.dart';

class PersonList extends StatelessWidget {
  const PersonList({super.key});

  @override
  Widget build(BuildContext context) {
    var movieViewModel = Provider.of<MovieViewModel>(context);
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(44, 43, 48, 1),
      title: const Text('Список персонажей'),
      content: ConstrainedBox(
        constraints:
        const BoxConstraints(maxHeight: 800, maxWidth: 400),
        child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var person in movieViewModel.persons)
                  PersonDetails(person: person)
              ],
            )),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('ok',
            style: TextStyle(
              color: Color.fromRGBO(242, 196, 206, 1),
            ),
          ),
        ),
      ],
    );
  }

}