import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:frontend2/model/user.dart';
import 'package:frontend2/view/home/widgets/add_movie.dart';
import 'package:frontend2/view/home/widgets/menu_dialog.dart';
import 'package:frontend2/view/home/widgets/movie_table.dart';
import 'package:frontend2/view/home/widgets/movie_text_field.dart';
import 'package:frontend2/view/home/widgets/movies_map.dart';
import 'package:frontend2/view/home/widgets/show_profile.dart';
import 'package:frontend2/view/home/widgets/show_waiting_admin.dart';
import 'package:frontend2/view/widgets/styled_loading.dart';
import 'package:frontend2/viewmodel/authentication_viewmodel.dart';
import 'package:frontend2/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final MovieViewModel movieViewModel;

  const HomeScreen({
    required this.movieViewModel,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User? user;
  bool uniqueUsaBoxOffice = false;
  final movieNamePrefix = TextEditingController();
  final minGoldenPalm = TextEditingController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (user == null) {
        Navigator.popAndPushNamed(context, '/');
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = widget.movieViewModel;

      final totalHeight = MediaQuery.of(context).size.height;
      const headerHeight = 300.0;
      const rowHeight = 56.0;
      final tableHeight = totalHeight -
          headerHeight -
          kToolbarHeight -
          MediaQuery.of(context).padding.top;

      viewModel.size = (tableHeight ~/ rowHeight);

      viewModel.getMoviesPage();
      viewModel.getPersons();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthenticationViewModel>(context);
    user = authViewModel.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies App'),
        automaticallyImplyLeading: false,
        actions: [
          if (authViewModel.user?.role == Role.ROLE_ADMIN)
            const ShowWaitingAdmin(),
          const ShowProfile(),
          const SizedBox(width: 15),
        ],
      ),
      body: Consumer<MovieViewModel>(builder: (context, movieViewModel, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: StyledTextField(
                            controller: movieNamePrefix,
                            labelText: 'Префикс названия фильма',
                          ),
                        ),
                        const SizedBox(height: 10),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: StyledTextField(
                            controller: minGoldenPalm,
                            labelText: 'Мин. Золотых пальм',
                            inputType: InputType.typeInt,
                            allowNegative: false,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: uniqueUsaBoxOffice,
                              activeColor:
                                  const Color.fromRGBO(242, 196, 206, 1),
                              checkColor: const Color.fromRGBO(44, 43, 48, 1),
                              onChanged: (value) {
                                setState(() {
                                  uniqueUsaBoxOffice = value!;
                                });
                              },
                            ),
                            const SizedBox(width: 5),
                            const Text('Уникальные кассовые сборы США'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 50),
                    ElevatedButton(
                      onPressed: () {
                        movieViewModel.applyFilters(
                          movieNamePrefix.text,
                          minGoldenPalm.text.isEmpty
                              ? -1
                              : int.parse(minGoldenPalm.text),
                          uniqueUsaBoxOffice,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color.fromRGBO(44, 43, 48, 1),
                        minimumSize: const Size(300, 150),
                        backgroundColor: const Color.fromRGBO(242, 196, 206, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Применить фильтры'),
                    )
                  ],
                ),
                const SizedBox(height: 60),
                if (movieViewModel.isLoading) const StyledLoading(),
                if (!movieViewModel.isLoading)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(79, 79, 81, 1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color.fromRGBO(242, 196, 206, 1),
                            width: 2,
                          ),
                        ),
                        child: movieViewModel.movies.isEmpty
                            ? const Text('Пока нет фильмов')
                            : ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 1200),
                                child: MovieTable(
                                  movies: movieViewModel.movies,
                                  authViewModel: authViewModel,
                                  changeSorting: () => movieViewModel.changeSorting(),
                                ),
                              ),
                      ),
                      const SizedBox(height: 10),
                      if (movieViewModel.movies.isNotEmpty)
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 800,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: Text(
                                  'Количество страниц: ${movieViewModel.pageCount.toString()}',
                                  style: const TextStyle(
                                    color: Color.fromRGBO(242, 196, 206, 1),
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: movieViewModel.page == 1
                                        ? null
                                        : () {
                                            movieViewModel.page -= 1;
                                          },
                                    icon: const Icon(Icons.arrow_back_ios),
                                    color:
                                        const Color.fromRGBO(242, 196, 206, 1),
                                  ),
                                  Center(
                                    child: Text(
                                      movieViewModel.page.toString(),
                                      style: const TextStyle(
                                        color: Color.fromRGBO(242, 196, 206, 1),
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4.5,
                                  ),
                                  IconButton(
                                    onPressed: movieViewModel.page ==
                                            movieViewModel.pageCount
                                        ? null
                                        : () {
                                            movieViewModel.page += 1;
                                          },
                                    icon: const Icon(Icons.arrow_forward_ios),
                                    color:
                                        const Color.fromRGBO(242, 196, 206, 1),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300,
                  width: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromRGBO(242, 196, 206, 1),
                      width: 2,
                    ),
                  ),
                  child: !movieViewModel.isLoading
                      ? movieViewModel.movies.isEmpty
                          ? const Center(child: Text('Пока нет фильмов'))
                          : MoviesMap(
                              movies: movieViewModel.movies,
                            )
                      : const Center(child: StyledLoading()),
                ),
                const SizedBox(height: 30),
                OutlinedButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            const MovieMenuDialog());
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(242, 196, 206, 1),
                    minimumSize: const Size(507, 54),
                    side: const BorderSide(
                        color: Color.fromRGBO(242, 196, 206, 1), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text('Меню'),
                ),
                const SizedBox(height: 30),
                const AddMovie(),
              ],
            ),
          ],
        );
      }),
    );
  }
}
