import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewmodel/movie_viewmodel.dart';
import '../../widgets/styled_loading.dart';
import 'movie_text_field.dart';

class AddOscarDialog extends StatefulWidget {
  const AddOscarDialog({super.key});

  @override
  State<AddOscarDialog> createState() => _AddOscarDialogState();
}

class _AddOscarDialogState extends State<AddOscarDialog> {
  late final TextEditingController _oscarCountController;
  var state = MovieByIdState.entering;

  @override
  void initState() {
    _oscarCountController = TextEditingController();
    _oscarCountController.addListener(_onIdChanged);
    super.initState();
  }

  @override
  void dispose() {
    _oscarCountController.dispose;
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
        'Добавить оскары',
        style: TextStyle(color: Color.fromRGBO(214, 214, 214, 1)),
      ),
      content: state == MovieByIdState.entering
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 300,
                  child: StyledTextField(
                    controller: _oscarCountController,
                    labelText: 'Количество оскаров',
                    inputType: InputType.typeInt,
                    allowNegative: false,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _oscarCountController.text.isNotEmpty
                      ? () async {
                          setState(() {
                            state = MovieByIdState.waiting;
                          });
                          final repository = Provider.of<MovieViewModel>(
                                  context,
                                  listen: false)
                              .repository;
                          try {
                            repository.updateOscars(
                                int.parse(_oscarCountController.text));
                            if (mounted) {
                              setState(() {
                                state = MovieByIdState.hasMessage;
                              });
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
                    : state == MovieByIdState.hasError
                        ? const Text('Не удалось добавить оскары')
                        : const Text('Оскары добавлены'),
              ),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(state == MovieByIdState.hasMessage ? 'ОК' : 'Отмена',
              style: const TextStyle(color: Color.fromRGBO(242, 196, 206, 1))),
        ),
      ],
    );
  }
}

enum MovieByIdState {
  entering,
  waiting,
  hasError,
  hasMessage,
}
