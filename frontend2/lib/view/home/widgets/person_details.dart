import 'package:flutter/cupertino.dart';

import '../../../model/movies.dart' as model;

class PersonDetails extends StatelessWidget {
  final model.Person person;

  const PersonDetails({
    super.key,
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
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
