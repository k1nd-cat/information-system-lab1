import 'package:flutter/material.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/person.dart';

class MovieListView extends StatelessWidget {
  const MovieListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MovieView extends StatefulWidget {
  final Movie movie;

  const MovieView({super.key, required this.movie});

  @override
  State<StatefulWidget> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  late bool showFullView;

  @override
  void initState() {
    showFullView = false;
    super.initState();
  }

  Widget _shortView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        widget.movie.name,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _fullView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.movie.name,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Жанр: ${widget.movie.genreToString()}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Продолжительность: ${widget.movie.length}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Бюджет: ${widget.movie.budget}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Дата создания: ${widget.movie.creationDate.day}.${widget.movie.creationDate.month}.${widget.movie.creationDate.year}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Сборы: ${widget.movie.totalBoxOffice}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'MPAA рейтинг: ${widget.movie.mpaaRatingToString()}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Золотая пальма: ${widget.movie.goldenPalmCount}',
            style: TextStyle(fontSize: 16.0),
          ),
          Row(
            children: [
              Text(
                'Количество оскаров: ${widget.movie.oscarsCount}',
                style: TextStyle(fontSize: 16.0),
              ),
              IconButton(
                onPressed: () {
                  // TODO: обработать прибавление оскара
                },
                icon: Icon(Icons.add_box_rounded),
              ),
            ],
          ),
          Text(
            'Координаты: (${widget.movie.coordinates.x}, ${widget.movie.coordinates.y})',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Директор: ${widget.movie.director.name}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Сценарист: ${widget.movie.screenwriter.name}',
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 8.0),
          Text(
            'Оператор: ${widget.movie.operator.name}',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  void onChangeView() {
    setState(() {
      showFullView = !showFullView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChangeView,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 400,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (!showFullView) _shortView(),
                if (showFullView) _fullView(),
                // TODO: Добавить кнопки
                const Spacer(),
                const IconButton(
                  onPressed: null,
                  icon: Icon(Icons.delete_forever_rounded),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<StatefulWidget> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final List<Movie> movies = [
    Movie(
      id: 555,
      name: 'Хороший плохой злой',
      coordinates: Coordinates(x: 15, y: 26),
      creationDate: DateTime.now(),
      oscarsCount: 18,
      budget: 3000000,
      totalBoxOffice: 26000000,
      mpaaRating: MpaaRating.NC_17,
      director: Person(
        name: 'Гнида',
        eyeColor: Color.BLACK,
        hairColor: Color.RED,
        location: Location(x: 12, y: 48, z: 52),
        passportID: '12623547632',
        nationality: Country.JAPAN,
      ),
      screenwriter: Person(
        name: 'Гнида',
        eyeColor: Color.BLACK,
        hairColor: Color.RED,
        location: Location(x: 12, y: 48, z: 52),
        passportID: '12623547632',
        nationality: Country.JAPAN,
      ),
      operator: Person(
        name: 'Гнида',
        eyeColor: Color.BLACK,
        hairColor: Color.RED,
        location: Location(x: 12, y: 48, z: 52),
        passportID: '12623547632',
        nationality: Country.JAPAN,
      ),
      length: 48,
      goldenPalmCount: 18,
      usaBoxOffice: 16,
      genre: MovieGenre.WESTERN,
    ),
    Movie(
      id: 556,
      name: 'Хороший плохой злой',
      coordinates: Coordinates(x: 15, y: 26),
      creationDate: DateTime.now(),
      oscarsCount: 18,
      budget: 3000000,
      totalBoxOffice: 26000000,
      mpaaRating: MpaaRating.NC_17,
      director: Person(
        name: 'Гнида',
        eyeColor: Color.BLACK,
        hairColor: Color.RED,
        location: Location(x: 12, y: 48, z: 52),
        passportID: '12623547632',
        nationality: Country.JAPAN,
      ),
      screenwriter: Person(
        name: 'Гнида',
        eyeColor: Color.BLACK,
        hairColor: Color.RED,
        location: Location(x: 12, y: 48, z: 52),
        passportID: '12623547632',
        nationality: Country.JAPAN,
      ),
      operator: Person(
        name: 'Гнида',
        eyeColor: Color.BLACK,
        hairColor: Color.RED,
        location: Location(x: 12, y: 48, z: 52),
        passportID: '12623547632',
        nationality: Country.JAPAN,
      ),
      length: 48,
      goldenPalmCount: 18,
      usaBoxOffice: 16,
      genre: MovieGenre.WESTERN,
    ),
  ]; // Заполните своим списком фильмов
  final int pageSize = 10;
  int currentPage = 0;

  bool isTileExpanded(int index) => expandedIndex == index;

  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final paginatedMovies =
        movies.skip(currentPage * pageSize).take(pageSize).toList();

    return Container(
      width: 300,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: paginatedMovies.length,
              itemBuilder: (context, index) {
                final movie = paginatedMovies[index];
                final isExpanded = isTileExpanded(index);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      expandedIndex = isExpanded ? null : index;
                    });
                  },
                  child: Card(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  movie.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () {
                                  // Добавьте функционал редактирования
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // Добавьте функционал удаления
                                },
                              ),
                            ],
                          ),
                          if (isExpanded)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Genre: ${movie.genreToString()}'),
                                  Text('Budget: ${movie.budget}'),
                                  Text('Oscar Count: ${movie.oscarsCount}'),
                                  Text(
                                      'Director: ${movie.director.name}, ${movie.director.nationality}'),
                                  Text(
                                      'MPAA Rating: ${movie.mpaaRatingToString()}'),
                                  // Добавьте другие поля из класса Movie
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: currentPage > 0
                    ? () {
                        setState(() {
                          currentPage--;
                        });
                      }
                    : null,
              ),
              Text(
                'Page ${currentPage + 1}/${(movies.length / pageSize).ceil()}',
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: (currentPage + 1) * pageSize < movies.length
                    ? () {
                        setState(() {
                          currentPage++;
                        });
                      }
                    : null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
