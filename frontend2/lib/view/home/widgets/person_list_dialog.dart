import 'package:flutter/material.dart';
import 'package:frontend2/view/home/widgets/person_details.dart';
import 'package:frontend2/view/widgets/styled_loading.dart';
import 'package:frontend2/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

class PersonAlertDialog extends StatelessWidget {
  const PersonAlertDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final movieViewModel = Provider.of<MovieViewModel>(context);
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(44, 43, 48, 1),
      title: const Text('Список людей',
          style: TextStyle(color: Color.fromRGBO(214, 214, 214, 1))),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 700, minHeight: 200),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: movieViewModel.showOperatorWithZeroOscar(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: StyledLoading());
              } else if (snapshot.hasData) {
                final persons = snapshot.data!;
                return persons.isNotEmpty
                    ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(persons.length, (index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PersonDetails(person: persons[index]),
                        if (index != persons.length - 1)
                          const SizedBox(
                            height: 14,
                          ),
                      ],
                    );
                  }),
                )
                    : const Center(
                    child:
                    Text('Операторов с фильмами без оскаров пока нет'));
              } else {
                return const Center(child: Text('Не удалось загрузить данные'));
              }
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('ok',
              style: TextStyle(color: Color.fromRGBO(242, 196, 206, 1))),
        ),
      ],
    );
  }
}
