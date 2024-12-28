import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend2/view/home/widgets/movie_text_field.dart';
import 'package:frontend2/viewmodel/authentication_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../model/movies.dart' as model;
import 'enum_dropdown.dart';

class PersonEditDialog extends StatefulWidget {
  final model.Person person;
  final void Function(model.Person person) onSave;

  const PersonEditDialog({
    required this.person,
    required this.onSave,
    super.key,
  });

  @override
  State<PersonEditDialog> createState() => _PersonEditDialogState();
}

class _PersonEditDialogState extends State<PersonEditDialog> {
  late model.Person person;
  final _nameController = TextEditingController();
  late model.Color eyeColor;
  late model.Color hairColor;
  late model.Location? location;
  final _xController = TextEditingController();
  final _yController = TextEditingController();
  final _zController = TextEditingController();
  late bool isLocation;
  late model.Country nationality;
  late bool isEditable;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  model.Person _generatePersonByParams() {
    return model.Person(
      name: _nameController.text,
      eyeColor: eyeColor,
      hairColor: hairColor,
      location: isLocation
          ? model.Location(
              int.parse(_xController.text),
              int.parse(_yController.text),
              double.parse(_zController.text),
            )
          : null,
      nationality: nationality,
      passportID: person.passportID,
      isEditable: isEditable,
    );
  }

  @override
  void initState() {
    person = widget.person;
    _nameController.text = person.name;
    eyeColor = person.eyeColor;
    hairColor = person.hairColor;
    location = person.location;
    isLocation = location != null;
    if (isLocation) {
      _xController.text = location!.x.toString();
      _yController.text = location!.y.toString();
      _zController.text = location!.z.toString();
    }
    nationality = person.nationality;
    isEditable = person.isEditable!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user =
        Provider.of<AuthenticationViewModel>(context, listen: false).user!;
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(44, 43, 48, 1),
      title: const Text(
        'Редактировать персонажа',
        style: TextStyle(color: Color.fromRGBO(214, 214, 214, 1)),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Passport Id'),
            Text(
              person.passportID,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),
            StyledTextField(
              controller: _nameController,
              labelText: 'Имя',
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Поле не может быть пустым';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            EnumDropdown<model.Color>(
              value: eyeColor,
              onChanged: (value) {
                setState(() {
                  eyeColor = value;
                });
              },
              values: model.Color.values,
              labelText: 'Цвет глаз',
            ),
            const SizedBox(height: 20),
            EnumDropdown<model.Color>(
              value: hairColor,
              onChanged: (value) {
                setState(() {
                  hairColor = value;
                });
              },
              values: model.Color.values,
              labelText: 'Цвет волос',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Местоположение',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromRGBO(214, 214, 214, 1),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Switch(
                      // This bool value toggles the switch.
                      value: isLocation,
                      activeColor: const Color.fromRGBO(242, 196, 206, 1),
                      inactiveThumbColor: const Color.fromRGBO(79, 79, 81, 1),
                      inactiveTrackColor: const Color.fromRGBO(44, 43, 48, 1),
                      onChanged: (value) {
                        setState(() {
                          isLocation = value;
                        });
                      },
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
            if (isLocation) const SizedBox(height: 20),
            if (isLocation)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    child: StyledTextField(
                      controller: _xController,
                      labelText: 'X',
                      inputType: InputType.typeInt,
                      allowNegative: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не может быть пустым';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: StyledTextField(
                      controller: _yController,
                      labelText: 'Y',
                      inputType: InputType.typeInt,
                      allowNegative: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не может быть пустым';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: StyledTextField(
                      controller: _zController,
                      labelText: 'Z',
                      inputType: InputType.typeDouble,
                      allowNegative: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Поле не может быть пустым';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            if (isLocation) const SizedBox(height: 15),
            const SizedBox(height: 20),
            EnumDropdown<model.Country>(
              value: nationality,
              onChanged: (value) {
                setState(() {
                  nationality = value;
                });
              },
              values: model.Country.values,
              labelText: 'Национальность',
            ),
            if (user.username == person.creatorName) const SizedBox(height: 15),
            if (user.username == person.creatorName)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                    value: isEditable,
                    activeColor: const Color.fromRGBO(242, 196, 206, 1),
                    checkColor: const Color.fromRGBO(44, 43, 48, 1),
                    onChanged: (value) {
                      setState(() {
                        isEditable = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 5),
                  const Text('Разрешить редактировать администраторам'),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Отмена',
            style: TextStyle(color: Color.fromRGBO(242, 196, 206, 1)),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final updatedPerson = _generatePersonByParams();
              widget.onSave(updatedPerson);
              Navigator.pop(context);
            }
          },
          child: const Text(
            'Сохранить',
            style: TextStyle(color: Color.fromRGBO(242, 196, 206, 1)),
          ),
        ),
      ],
    );
  }
}
