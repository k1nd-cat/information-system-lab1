import 'package:flutter/material.dart';
import 'package:frontend2/model/movies.dart' as model;
import 'package:frontend2/view/home/widgets/enum_dropdown.dart';
import 'package:frontend2/view/home/widgets/movie_text_field.dart';
import 'package:frontend2/view/home/widgets/person_dropdown.dart';
import 'package:frontend2/viewmodel/authentication_viewmodel.dart';
import 'package:frontend2/viewmodel/movie_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddUpdateMovieScreen extends StatefulWidget {
  const AddUpdateMovieScreen({super.key});

  @override
  State<AddUpdateMovieScreen> createState() => _AddUpdateMovieScreenState();
}

class _AddUpdateMovieScreenState extends State<AddUpdateMovieScreen> {
  late final TextEditingController _movieNameController;
  late final TextEditingController _xCoordController;
  late final TextEditingController _yCoordController;
  late final TextEditingController _oscarCountController;
  late final TextEditingController _budgetController;
  late final TextEditingController _totalBoxOfficeController;
  late final TextEditingController _lengthController;
  late final TextEditingController _goldenPalmCountController;
  late final TextEditingController _usaBoxOfficeController;
  late PersonController _directorController;
  late PersonController _screenwriterController;
  late PersonController _operatorController;
  late model.MovieGenre _selectedMovieGenre;
  late model.MpaaRating _selectedMpaaRating;
  bool _isUsaBoxOffice = false;
  late bool _isScreenwriter;
  dynamic _selectedDirector = 'new';
  dynamic _selectedScreenwriter = 'new';
  dynamic _selectedOperator = 'new';
  bool isEditable = false;
  String? errorMessage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  model.Movie createMovie(model.Movie? movie) {
    return model.Movie(
      id: movie?.id,
      name: _movieNameController.text,
      coordinates: model.Coordinates(
        double.parse(_xCoordController.text),
        int.parse(_yCoordController.text),
      ),
      creationDate: movie?.creationDate,
      oscarCount: int.parse(_oscarCountController.text),
      budget: double.parse(_budgetController.text),
      totalBoxOffice: double.parse(_totalBoxOfficeController.text),
      mpaaRating: _selectedMpaaRating,
      director: _directorController.generatePerson(),
      screenwriter:
      _isScreenwriter ? _screenwriterController.generatePerson() : null,
      operator: _operatorController.generatePerson(),
      length: int.parse(_lengthController.text),
      goldenPalmCount: int.parse(_goldenPalmCountController.text),
      usaBoxOffice:
      _isUsaBoxOffice ? int.parse(_usaBoxOfficeController.text) : null,
      genre: _selectedMovieGenre,
      creatorName: movie?.creatorName,
      isEditable: movie?.isEditable ?? isEditable,
    );
  }

  void initParams(model.Movie? movie) {
    _movieNameController.text = movie?.name ?? '';
    _selectedMovieGenre = movie?.genre ?? model.MovieGenre.WESTERN;
    _selectedMpaaRating = movie?.mpaaRating ?? model.MpaaRating.G;
    _xCoordController.text = movie?.coordinates.x.toString() ?? '';
    _yCoordController.text = movie?.coordinates.y.toString() ?? '';
    _oscarCountController.text = movie?.oscarCount.toString() ?? '';
    _budgetController.text = movie?.budget.toString() ?? '';
    _totalBoxOfficeController.text = movie?.totalBoxOffice.toString() ?? '';
    _lengthController.text = movie?.length.toString() ?? '';
    _goldenPalmCountController.text = movie?.goldenPalmCount.toString() ?? '';
    _usaBoxOfficeController.text = movie?.usaBoxOffice?.toString() ?? '';
    if (movie != null) {
      _isUsaBoxOffice = movie.usaBoxOffice != null;
      _isScreenwriter = movie.screenwriter != null;
      if (_isScreenwriter) {
        _screenwriterController =
            PersonController.fromPerson(movie.screenwriter!);
      }
      _directorController = PersonController.fromPerson(movie.director);
      _operatorController = PersonController.fromPerson(movie.operator);
    } else {
      _isUsaBoxOffice = false;
      _isScreenwriter = false;
      _directorController = PersonController();
      _operatorController = PersonController();
      _screenwriterController = PersonController();
      _isScreenwriter = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _movieNameController = TextEditingController();
    _xCoordController = TextEditingController();
    _yCoordController = TextEditingController();
    _oscarCountController = TextEditingController();
    _budgetController = TextEditingController();
    _totalBoxOfficeController = TextEditingController();
    _lengthController = TextEditingController();
    _goldenPalmCountController = TextEditingController();
    _usaBoxOfficeController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final movieViewModel = Provider.of<MovieViewModel>(context);
    var movie = movieViewModel.editableMovie;
    initParams(movie);
  }

  @override
  void dispose() {
    _movieNameController.dispose();
    _xCoordController.dispose();
    _yCoordController.dispose();
    _oscarCountController.dispose();
    _budgetController.dispose();
    _totalBoxOfficeController.dispose();
    _lengthController.dispose();
    _goldenPalmCountController.dispose();
    _usaBoxOfficeController.dispose();
    _directorController.dispose();
    _screenwriterController.dispose();
    _operatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(44, 43, 48, 1),
      title: Text(
        context.watch<MovieViewModel>().editableMovie == null
            ? 'Создание фильма'
            : 'Редактирование фильма',
        style: const TextStyle(color: Color.fromRGBO(214, 214, 214, 1)),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 670),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                StyledTextField(
                  controller: _movieNameController,
                  labelText: 'Название фильма',
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Поле не может быть пустым';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                EnumDropdown<model.MovieGenre>(
                  value: _selectedMovieGenre,
                  onChanged: (model.MovieGenre newValue) {
                    setState(() {
                      _selectedMovieGenre = newValue;
                    });
                  },
                  values: model.MovieGenre.values,
                  labelText: 'Жанр',
                ),
                const SizedBox(height: 20),
                EnumDropdown<model.MpaaRating>(
                  value: _selectedMpaaRating,
                  onChanged: (model.MpaaRating newValue) {
                    setState(() {
                      _selectedMpaaRating = newValue;
                    });
                  },
                  values: model.MpaaRating.values,
                  labelText: 'Рейтинг',
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Color.fromRGBO(242, 196, 206, 0.2),
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Координаты',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(214, 214, 214, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100,
                      child: StyledTextField(
                        controller: _xCoordController,
                        labelText: 'X',
                        inputType: InputType.typeInt,
                        allowNegative: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Поле не может быть пустым';
                          }
                          final x = double.tryParse(value);
                          if (x == null || x <= -946) {
                            return 'Значение поля должно быть больше -946';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: StyledTextField(
                        controller: _yCoordController,
                        labelText: 'Y',
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
                const SizedBox(height: 10),
                const Divider(
                  color: Color.fromRGBO(242, 196, 206, 0.2),
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(height: 10),
                StyledTextField(
                  controller: _oscarCountController,
                  labelText: 'Число оскаров',
                  inputType: InputType.typeInt,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Поле не может быть пустым';
                    }
                    final oscarCount = int.tryParse(value);
                    if (oscarCount == null || oscarCount <= 0) {
                      return 'Значение поля должно быть больше 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                StyledTextField(
                  controller: _budgetController,
                  labelText: 'Бюджет, \$',
                  inputType: InputType.typeInt,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Поле не может быть пустым';
                    }
                    final budget = double.tryParse(value);
                    if (budget == null || budget <= 0) {
                      return 'Значение поля должно быть больше 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                StyledTextField(
                  controller: _totalBoxOfficeController,
                  labelText: 'Кассовые сборы, \$',
                  inputType: InputType.typeDouble,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Поле не может быть пустым';
                    }
                    final totalBoxOffice = double.tryParse(value);
                    if (totalBoxOffice == null || totalBoxOffice <= 0) {
                      return 'Значение поля должно быть больше 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                StyledTextField(
                  controller: _lengthController,
                  labelText: 'Продолжительность, минуты',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Поле не может быть пустым';
                    }
                    final length = int.tryParse(value);
                    if (length == null || length <= 0) {
                      return 'Значение поля должно быть больше 0';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                StyledTextField(
                  controller: _goldenPalmCountController,
                  labelText: 'Количество золотых пальм',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Поле не может быть пустым';
                    }
                    final goldenPalmCount = int.tryParse(value);
                    if (goldenPalmCount == null || goldenPalmCount <= 0) {
                      return 'Значение поля должно быть больше 0';
                    }
                    return null;
                  },
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
                          'Кассовые сборы в США',
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
                          value: _isUsaBoxOffice,
                          activeColor: const Color.fromRGBO(242, 196, 206, 1),
                          inactiveThumbColor: const Color.fromRGBO(79, 79, 81, 1),
                          inactiveTrackColor: const Color.fromRGBO(44, 43, 48, 1),
                          onChanged: (value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              _isUsaBoxOffice = value;
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
                if (_isUsaBoxOffice) const SizedBox(height: 10),
                if (_isUsaBoxOffice)
                  StyledTextField(
                    controller: _usaBoxOfficeController,
                    labelText: 'Кассовые сборы в США, \$',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Поле не может быть пустым';
                      }
                      final usaBoxOffice = int.tryParse(value);
                      if (usaBoxOffice == null || usaBoxOffice <= 0) {
                        return 'Значение поля должно быть больше 0';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 10),
                const Divider(
                  color: Color.fromRGBO(242, 196, 206, 0.2),
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Режиссёр',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(214, 214, 214, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                PersonDropdown(
                  onChanged: (dynamic newValue) {
                    setState(() {
                      _selectedDirector = newValue;
                      if (_selectedDirector == 'new') {
                        _directorController.withoutPerson();
                      } else {
                        _directorController.fromPerson(_selectedDirector);
                      }
                    });
                  },
                  labelText: 'Выбрать из списка',
                ),
                const SizedBox(height: 20),
                AddUpdatePerson(
                    controller: _directorController,
                    selectedPerson: _selectedDirector),
                const SizedBox(height: 10),
                const Divider(
                  color: Color.fromRGBO(242, 196, 206, 0.2),
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Text(
                          'Автор сценария',
                          style: TextStyle(
                            fontSize: 20,
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
                          value: _isScreenwriter,
                          activeColor: const Color.fromRGBO(242, 196, 206, 1),
                          inactiveThumbColor: const Color.fromRGBO(79, 79, 81, 1),
                          inactiveTrackColor: const Color.fromRGBO(44, 43, 48, 1),
                          onChanged: (value) {
                            // This is called when the user toggles the switch.
                            setState(() {
                              _isScreenwriter = value;
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ],
                ),
                if (_isScreenwriter) const SizedBox(height: 20),
                if (_isScreenwriter)
                  PersonDropdown(
                    onChanged: (dynamic newValue) {
                      setState(() {
                        _selectedScreenwriter = newValue;
                        if (_selectedScreenwriter == 'new') {
                          _screenwriterController.withoutPerson();
                        } else {
                          _screenwriterController
                              .fromPerson(_selectedScreenwriter);
                        }
                      });
                    },
                    labelText: 'Выбрать из списка',
                  ),
                if (_isScreenwriter) const SizedBox(height: 20),
                if (_isScreenwriter)
                  AddUpdatePerson(
                    controller: _screenwriterController,
                    selectedPerson: _selectedScreenwriter,
                  ),
                const SizedBox(height: 10),
                const Divider(
                  color: Color.fromRGBO(242, 196, 206, 0.2),
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Оператор',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(214, 214, 214, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                PersonDropdown(
                  onChanged: (dynamic newValue) {
                    setState(() {
                      _selectedOperator = newValue;
                      if (_selectedOperator == 'new') {
                        _operatorController.withoutPerson();
                      } else {
                        _operatorController.fromPerson(_selectedOperator);
                      }
                    });
                  },
                  labelText: 'Выбрать из списка',
                ),
                const SizedBox(height: 20),
                AddUpdatePerson(
                    controller: _operatorController,
                    selectedPerson: _selectedOperator),
                const SizedBox(height: 10),
                const Divider(
                  color: Color.fromRGBO(242, 196, 206, 0.2),
                  thickness: 1,
                  indent: 10,
                  endIndent: 10,
                ),
                const SizedBox(height: 10),
                if (context.watch<MovieViewModel>().editableMovie != null)
                  Text(
                      'Дата добавления: ${DateFormat('dd MMMM yyyy').format(context.watch<MovieViewModel>().editableMovie!.creationDate!)}'),
                if (context.watch<MovieViewModel>().editableMovie == null)
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
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            final movieViewModel = Provider.of<MovieViewModel>(context, listen: false);
            movieViewModel.editableMovie = null;
            Navigator.pop(context);
          },
          child: const Text(
            'Отмена',
            style: TextStyle(color: Color.fromRGBO(242, 196, 206, 1)),
          ),
        ),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                final movieViewModel = Provider.of<MovieViewModel>(context, listen: false);
                final editableMovie = movieViewModel.editableMovie;
                final movie = createMovie(editableMovie);
                final token = Provider.of<AuthenticationViewModel>(context, listen: false).user!.token;
                if (editableMovie == null) {
                  await movieViewModel.createMovie(token, movie);
                } else {
                  await movieViewModel.updateMovie(token, movie);
                }
                movieViewModel.editableMovie = null;
                if (mounted) {
                  Navigator.pop(context);
                }
              } catch (e) {
                print(e.toString());
              }
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

class AddUpdatePerson extends StatefulWidget {
  final PersonController controller;
  final dynamic selectedPerson;

  const AddUpdatePerson({
    super.key,
    required this.controller,
    required this.selectedPerson,
  });

  @override
  State<AddUpdatePerson> createState() => _AddUpdatePersonState();
}

class _AddUpdatePersonState extends State<AddUpdatePerson> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StyledTextField(
          controller: widget.controller.passportIDController,
          labelText: 'ID паспорта',
          readOnly: widget.selectedPerson != 'new',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Значение поля не может быть пустым';
            }
            if (value.length >= 34) {
              return 'Длина поля должна быть не больше 34';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        StyledTextField(
          controller: widget.controller.nameController,
          labelText: 'Имя',
          readOnly: widget.selectedPerson != 'new',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Поле не может быть пустым';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        EnumDropdown<model.Color>(
          value: widget.controller.eyeColor,
          readOnly: widget.selectedPerson != 'new',
          onChanged: (value) {
            setState(() {
              widget.controller.eyeColor = value;
            });
          },
          values: model.Color.values,
          labelText: 'Цвет глаз',
        ),
        const SizedBox(height: 20),
        EnumDropdown<model.Color>(
          value: widget.controller.hairColor,
          readOnly: widget.selectedPerson != 'new',
          onChanged: (value) {
            setState(() {
              widget.controller.hairColor = value;
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
                  value: widget.controller.isLocation,
                  activeColor: const Color.fromRGBO(242, 196, 206, 1),
                  inactiveThumbColor: const Color.fromRGBO(79, 79, 81, 1),
                  inactiveTrackColor: const Color.fromRGBO(44, 43, 48, 1),
                  onChanged: widget.selectedPerson != 'new'
                      ? null
                      : (value) {
                    setState(() {
                      widget.controller.isLocation = value;
                    });
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
        if (widget.controller.isLocation) const SizedBox(height: 20),
        if (widget.controller.isLocation)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 100,
                child: StyledTextField(
                  controller: widget.controller.xController,
                  labelText: 'X',
                  inputType: InputType.typeInt,
                  allowNegative: true,
                  readOnly: widget.selectedPerson != 'new',
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
                  controller: widget.controller.yController,
                  labelText: 'Y',
                  inputType: InputType.typeInt,
                  allowNegative: true,
                  readOnly: widget.selectedPerson != 'new',
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
                  controller: widget.controller.zController,
                  labelText: 'Z',
                  inputType: InputType.typeDouble,
                  allowNegative: true,
                  readOnly: widget.selectedPerson != 'new',
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
        if (widget.controller.isLocation) const SizedBox(height: 15),
        const SizedBox(height: 20),
        EnumDropdown<model.Country>(
          value: widget.controller.nationality,
          readOnly: widget.selectedPerson != 'new',
          onChanged: (value) {
            setState(() {
              widget.controller.nationality = value;
            });
          },
          values: model.Country.values,
          labelText: 'Национальность',
        ),
      ],
    );
  }
}

class PersonController {
  final passportIDController = TextEditingController();
  final nameController = TextEditingController();
  final xController = TextEditingController();
  final yController = TextEditingController();
  final zController = TextEditingController();
  model.Color eyeColor = model.Color.BLACK;
  model.Color hairColor = model.Color.BLACK;
  model.Country nationality = model.Country.RUSSIA;
  bool isLocation = false;

  PersonController();

  PersonController.fromPerson(model.Person person) {
    passportIDController.text = person.passportID;
    nameController.text = person.name;
    eyeColor = person.eyeColor;
    hairColor = person.hairColor;
    nationality = person.nationality;
    if (person.location != null) {
      isLocation = true;
      xController.text = person.location!.x.toString();
      yController.text = person.location!.y.toString();
      zController.text = person.location!.z.toString();
    } else {
      isLocation = false;
    }
  }

  void fromPerson(model.Person person) {
    passportIDController.text = person.passportID;
    nameController.text = person.name;
    eyeColor = person.eyeColor;
    hairColor = person.hairColor;
    nationality = person.nationality;
    if (person.location != null) {
      isLocation = true;
      xController.text = person.location!.x.toString();
      yController.text = person.location!.y.toString();
      zController.text = person.location!.z.toString();
    } else {
      isLocation = false;
    }
  }

  void withoutPerson() {
    passportIDController.text = '';
    nameController.text = '';
    eyeColor = model.Color.BLACK;
    hairColor = model.Color.BLACK;
    nationality = model.Country.RUSSIA;
    isLocation = false;
    xController.text = '';
    yController.text = '';
    zController.text = '';
  }

  model.Person generatePerson() {
    return model.Person(
      name: nameController.text,
      eyeColor: eyeColor,
      hairColor: hairColor,
      location: isLocation
          ? model.Location(
        int.parse(xController.text),
        int.parse(yController.text),
        double.parse(zController.text),
      )
          : null,
      nationality: nationality,
      passportID: passportIDController.text,
    );
  }

  void dispose() {
    passportIDController.dispose();
    nameController.dispose();
    xController.text = '';
    yController.text = '';
    zController.text = '';
  }
}