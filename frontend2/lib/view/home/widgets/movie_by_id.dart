import 'package:flutter/material.dart';
import 'package:frontend2/view/home/widgets/movie_details.dart';
import 'package:frontend2/view/home/widgets/movie_text_field.dart';
import 'package:frontend2/view/widgets/styled_loading.dart';
import 'package:frontend2/viewmodel/authentication_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../viewmodel/movie_viewmodel.dart';

class IdEnter extends StatefulWidget {
  const IdEnter({super.key});

  @override
  State<IdEnter> createState() => _IdEnterState();
}

class _IdEnterState extends State<IdEnter> {
  late final TextEditingController _idController;
  var state = MovieByIdState.entering;

  @override
  void initState() {
    _idController = TextEditingController();
    _idController.addListener(_onIdChanged);
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose;
    super.dispose();
  }

  void _onIdChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(44, 43, 48, 1),
      title: const Text(
        'Найти фильм по id',
        style: TextStyle(color: Color.fromRGBO(214, 214, 214, 1)),
      ),
      content: state == MovieByIdState.entering
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 300,
                  child: StyledTextField(
                    controller: _idController,
                    labelText: 'ID фильма',
                    inputType: InputType.typeInt,
                    allowNegative: false,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _idController.text.isNotEmpty
                      ? () async {
                          setState(() {
                            state = MovieByIdState.waiting;
                          });
                          final repository = Provider.of<MovieViewModel>(
                                  context,
                                  listen: false)
                              .repository;
                          try {
                            final movie = await repository
                                .getById(int.parse(_idController.text));
                            if (mounted) {
                              var user =
                                  Provider.of<AuthenticationViewModel>(context, listen: false)
                                      .user;
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      MovieDetailsDialog(
                                        movie: movie,
                                        user: user!,
                                      ));
                            }
                          } catch (ignore) {
                            if (mounted) {
                              setState(() {
                                state = MovieByIdState.hasError;
                              });
                            }
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(242, 196, 206, 1),
                    minimumSize: const Size(57, 57),
                    backgroundColor: const Color.fromRGBO(242, 196, 206, 1),
                    disabledBackgroundColor:
                        const Color.fromRGBO(242, 196, 206, 0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Icon(
                    Icons.navigate_next,
                    size: 25,
                    color: Color.fromRGBO(44, 43, 48, 1),
                  ),
                )
              ],
            )
          : ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 250, maxHeight: 200),
              child: Center(
                child: state == MovieByIdState.waiting
                    ? const StyledLoading()
                    : const Text('Не удалось найти фильм'),
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена',
              style: TextStyle(color: Color.fromRGBO(242, 196, 206, 1))),
        ),
      ],
    );
  }
}

enum MovieByIdState {
  entering,
  waiting,
  hasError,
}
