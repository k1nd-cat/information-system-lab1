import 'package:flutter/material.dart';
import 'package:frontend2/view/home/widgets/add_oscar_dialog.dart';
import 'package:frontend2/view/home/widgets/file_history_dialog.dart';
import 'package:frontend2/view/home/widgets/person_list.dart';
import 'package:frontend2/view/home/widgets/person_list_dialog.dart';
import 'package:frontend2/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

import 'movie_by_id.dart';

class MovieMenuDialog extends StatelessWidget {
  const MovieMenuDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var movieViewModel = Provider.of<MovieViewModel>(context);
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(44, 43, 48, 1),
      title: const Text(
        'Меню',
        style: TextStyle(
          color: Color.fromRGBO(214, 214, 214, 1),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            // onPressed: onGetOperatorsWithoutOscars,
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const PersonAlertDialog());
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color.fromRGBO(214, 214, 214, 1),
              minimumSize: const Size(450, 80),
              side: const BorderSide(
                  color: Color.fromRGBO(242, 196, 206, 1), width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Получить список операторов,\nфильмы которых получили только один Оскар',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            // onPressed: onAddOscarsToMovies,
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const AddOscarDialog());
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color.fromRGBO(214, 214, 214, 1),
              minimumSize: const Size(450, 80),
              side: const BorderSide(
                  color: Color.fromRGBO(242, 196, 206, 1), width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Прибавить всем объектам\nзаданное число Оскаров',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            // onPressed: onGetMovieById,
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) => const IdEnter());
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color.fromRGBO(214, 214, 214, 1),
              minimumSize: const Size(450, 80),
              side: const BorderSide(
                  color: Color.fromRGBO(242, 196, 206, 1), width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Получить фильм по ID',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () async {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const PersonList();
                  });
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color.fromRGBO(214, 214, 214, 1),
              minimumSize: const Size(450, 80),
              side: const BorderSide(
                  color: Color.fromRGBO(242, 196, 206, 1), width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Получить список персонажей',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () async {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const FileHistoryDialog();
                  });
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color.fromRGBO(214, 214, 214, 1),
              minimumSize: const Size(450, 80),
              side: const BorderSide(
                  color: Color.fromRGBO(242, 196, 206, 1), width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'История загруженных файлов',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromRGBO(242, 196, 206, 1),
          ),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
