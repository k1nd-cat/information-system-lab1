import 'package:flutter/material.dart';
import 'package:frontend2/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../model/movies.dart' as model;
import '../../../model/user.dart';
import '../add_update_movie_screen.dart';

class MovieDetailsDialog extends StatelessWidget {
  final model.Movie movie;
  final User user;

  const MovieDetailsDialog({
    super.key,
    required this.movie,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    var movieViewModel = Provider.of<MovieViewModel>(context);
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(44, 43, 48, 1),
      title: Text(
        movie.name,
        style: const TextStyle(
          color: Color.fromRGBO(214, 214, 214, 1),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildInfoRow('Количество Оскаров:', movie.oscarCount.toString()),
            _buildInfoRow('Бюджет:', '${movie.budget.toStringAsFixed(2)}\$'),
            _buildInfoRow('Общие кассовые сборы:',
                '${movie.totalBoxOffice.toStringAsFixed(2)}\$'),
            _buildInfoRow('Возрастной рейтинг:',
                movie.mpaaRating.toString().split('.').last),
            _buildInfoRow('Продолжительность:', '${movie.length} мин.'),
            _buildInfoRow(
                'Количество Золотых пальм:', movie.goldenPalmCount.toString()),
            _buildInfoRow(
                'Кассовые сборы в США:',
                movie.usaBoxOffice != null
                    ? '${movie.usaBoxOffice}\$'
                    : 'Нет данных'),
            _buildInfoRow('Жанр:', movie.genre.toString().split('.').last),
            const SizedBox(height: 8),
            _buildCoordinates('Координаты:', movie.coordinates),
            const SizedBox(height: 14),
            _buildPersonSection('Режиссер', movie.director),
            if (movie.screenwriter != null)
              const SizedBox(height: 14),
            if (movie.screenwriter != null)
              _buildPersonSection('Сценарист', movie.screenwriter!),
            const SizedBox(height: 14),
            _buildPersonSection('Оператор', movie.operator),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: (user.role == Role.ROLE_ADMIN && movie.isEditable!) ||
                      user.username == movie.creatorName
                  ? () {
                      movieViewModel.editableMovie = movie;
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            const AddUpdateMovieScreen(),
                      );
                    }
                  : null,
              icon: const Icon(Icons.edit),
              color: Colors.green.withOpacity(0.6),
              disabledColor: Colors.black.withOpacity(0.0),
            ),
            IconButton(
              onPressed: (user.role == Role.ROLE_ADMIN ||
                      user.username == movie.creatorName)
                  ? () {
                Navigator.pop(context);
                      movieViewModel.deleteMovie(movie);
                    }
                  : null,
              icon: const Icon(Icons.delete_outline),
              color: const Color.fromRGBO(100, 23, 23, 0.6),
              disabledColor: Colors.black.withOpacity(0.0),
            ),
          ],
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromRGBO(242, 196, 206, 1),
          ),
          child: const Text('Закрыть'),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: const TextStyle(
              color: Color.fromRGBO(214, 214, 214, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Color.fromRGBO(214, 214, 214, 1)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCoordinates(String label, model.Coordinates coordinates) {
    return Row(
      children: [
        Text(
          '$label ',
          style: const TextStyle(
            color: Color.fromRGBO(214, 214, 214, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '(${coordinates.x}, ${coordinates.y})',
          style: const TextStyle(color: Color.fromRGBO(214, 214, 214, 1)),
        ),
      ],
    );
  }

  Widget _buildPersonSection(String role, model.Person person) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$role: ${person.name}',
          style: const TextStyle(
            color: Color.fromRGBO(214, 214, 214, 1),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildInfoRow('Паспорт:', person.passportID),
        _buildInfoRow('Цвет глаз:', person.eyeColor.toString().split('.').last),
        _buildInfoRow(
            'Цвет волос:', person.hairColor.toString().split('.').last),
        _buildInfoRow(
            'Национальность:', person.nationality.toString().split('.').last),
        if (person.location != null)
          Row(
            children: [
              const Text(
                'Местоположение: ',
                style: TextStyle(
                  color: Color.fromRGBO(214, 214, 214, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '(${person.location!.x}, ${person.location!.y}, ${person.location!.z})',
                style: const TextStyle(color: Color.fromRGBO(214, 214, 214, 1)),
              ),
            ],
          ),
      ],
    );
  }
}
