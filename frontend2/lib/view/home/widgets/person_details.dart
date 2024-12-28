import 'package:flutter/material.dart';
import 'package:frontend2/view/home/widgets/person_edit_dialog.dart';
import 'package:frontend2/viewmodel/authentication_viewmodel.dart';
import 'package:frontend2/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../model/movies.dart' as model;
import '../../../model/user.dart';

class PersonDetails extends StatelessWidget {
  final model.Person person;

  const PersonDetails({
    super.key,
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    var movieViewModel = Provider.of<MovieViewModel>(context);
    var user =
        Provider.of<AuthenticationViewModel>(context, listen: false).user!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          person.name,
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
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          IconButton(
            onPressed: user.username == person.creatorName ||
                    (user.role == Role.ROLE_ADMIN && person.isEditable == true)
                ? () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => PersonEditDialog(
                        person: person,
                        onSave: movieViewModel.updatePerson,
                      ),
                    );
                  }
                : null,
            icon: const Icon(Icons.edit),
            color: Colors.green.withOpacity(0.2),
            disabledColor: Colors.black.withOpacity(0.0),
          ),
          IconButton(
            onPressed: user.username == person.creatorName ||
                    user.role == Role.ROLE_ADMIN
                ? () {
                    movieViewModel.deletePerson(person);
                  }
                : null,
            icon: const Icon(Icons.delete_outline),
            color: const Color.fromRGBO(154, 39, 39, 1.0),
            disabledColor: Colors.black.withOpacity(0.0),
          ),
        ])
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
}
