import 'package:flutter/material.dart';
import 'package:frontend2/view/home/widgets/movie_details.dart';
import 'package:frontend2/viewmodel/authentication_viewmodel.dart';
import 'package:frontend2/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../model/movies.dart' as model;
import '../../../model/user.dart';
import '../add_update_movie_screen.dart';

class MovieTable extends StatefulWidget {
  final AuthenticationViewModel authViewModel;
  final List<model.Movie> movies;
  final void Function() changeSorting;

  const MovieTable({
    required this.movies,
    required this.authViewModel,
    required this.changeSorting,
    super.key,
  });

  @override
  State<MovieTable> createState() => _MovieTableState();
}

class _MovieTableState extends State<MovieTable> {
  int rowsPerPage = 1;
  late User user;

  @override
  initState() {
    super.initState();
    user = widget.authViewModel.user!;
  }

  List<DataRow> _dataRowFromMovies(BuildContext context) {
    List<DataRow> moviesRow = [];
    var movieViewModel = Provider.of<MovieViewModel>(context);
    for (var movie in widget.movies) {
      moviesRow.add(DataRow(cells: [
        DataCell(Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  showDialog(context: context,
                      builder: (BuildContext context) =>
                      MovieDetailsDialog(movie: movie, user: user));
                },
                icon: const Icon(Icons.info_outline),
                color: const Color.fromRGBO(242, 196, 206, 0.3)),
            IconButton(
              onPressed: (user.role == Role.ROLE_ADMIN && movie.isEditable!) ||
                  user.username == movie.creatorName
                  ? () {
                movieViewModel.editableMovie = movie;
                showDialog(
                    context: context,
                    builder: (
                        BuildContext context) => const AddUpdateMovieScreen());
              }
                  : null,
              icon: const Icon(Icons.edit),
              color: Colors.green.withOpacity(0.2),
              disabledColor: Colors.black.withOpacity(0.0),
            ),
            IconButton(
              onPressed: (user.role == Role.ROLE_ADMIN ||
                  user.username == movie.creatorName)
                  ? () {
                movieViewModel.deleteMovie(movie);
              }
                  : null,
              icon: const Icon(Icons.delete_outline),
              color: const Color.fromRGBO(100, 23, 23, 0.3),
              disabledColor: Colors.black.withOpacity(0.0),
            ),
          ],
        )),
        DataCell(Text(movie.name)),
        DataCell(Text(movie.id.toString())),
        DataCell(Text(movie.oscarCount.toString())),
        DataCell(Text(movie.budget.toString())),
        DataCell(Text(movie.totalBoxOffice.toString())),
        DataCell(Text(movie.mpaaRating.name)),
        DataCell(Text(movie.length.toString())),
        DataCell(Text(movie.goldenPalmCount.toString())),
        DataCell(Text(movie.usaBoxOffice?.toString() ?? '')),
        DataCell(Text(movie.genre.name)),
        DataCell(Text(movie.director.name)),
        DataCell(Text(movie.screenwriter?.name ?? '')),
        DataCell(Text(movie.operator.name)),
      ]));
    }

    return moviesRow;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          // header: const Text('Фильмы'),
          columns: [
            const DataColumn(label: Text('')),
            DataColumn(label: TextButton(onPressed: () => widget.changeSorting(), child: Text('Название'))),
            const DataColumn(label: Text('id')),
            const DataColumn(label: Text('Оскаров')),
            const DataColumn(label: Text('Бюджет, \$')),
            const DataColumn(label: Text('Сборы, \$')),
            const DataColumn(label: Text('Mpaa рейтинг')),
            const DataColumn(label: Text('Длина, мин')),
            const DataColumn(label: Text('Золотые пальмы')),
            const DataColumn(label: Text('Сборы в США, \$')),
            const DataColumn(label: Text('Жанр')),
            const DataColumn(label: Text('Режиссёр')),
            const DataColumn(label: Text('Автор сценария')),
            const DataColumn(label: Text('Оператор')),
          ],
          rows: _dataRowFromMovies(context),

          // source: MovieDataSource(widget.movies),
          // rowsPerPage: rowsPerPage,
        ),
      ),
    );
    // });
  }
}

class MovieDataSource extends DataTableSource {
  final List<model.Movie> movies;

  MovieDataSource(this.movies);

  @override
  DataRow? getRow(int index) {
    if (index >= movies.length) return null;
    final movie = movies[index];
    return DataRow(cells: [
      DataCell(Text(movie.name)),
      DataCell(Text(movie.oscarCount.toString())),
      DataCell(Text(movie.budget.toString())),
      DataCell(Text(movie.totalBoxOffice.toString())),
      DataCell(Text(movie.mpaaRating.name)),
      DataCell(Text(movie.length.toString())),
      DataCell(Text(movie.goldenPalmCount.toString())),
      DataCell(Text(movie.usaBoxOffice?.toString() ?? '')),
      DataCell(Text(movie.genre.name)),
      DataCell(Text(movie.director.name)),
      DataCell(Text(movie.screenwriter?.name ?? '')),
      DataCell(Text(movie.operator.name)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => movies.length;

  @override
  int get selectedRowCount => 0;
}
