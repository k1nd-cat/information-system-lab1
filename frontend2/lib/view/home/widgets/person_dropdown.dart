import 'package:flutter/material.dart';
import 'package:frontend2/view/widgets/styled_loading.dart';
import 'package:frontend2/viewmodel/authentication_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../model/movies.dart' as model;
import '../../../viewmodel/movie_viewmodel.dart';

class PersonDropdown extends StatefulWidget {
  final ValueChanged<dynamic> onChanged;
  final String labelText;
  final Color textColor;
  final Color borderColor;
  final Color fillColor;
  final Color dropdownColor;
  final bool canBeNone;

  const PersonDropdown({
    required this.onChanged,
    required this.labelText,
    this.textColor = const Color.fromRGBO(214, 214, 214, 1),
    this.borderColor = const Color.fromRGBO(242, 196, 206, 1),
    this.fillColor = const Color.fromRGBO(44, 43, 48, 1),
    this.dropdownColor = const Color.fromRGBO(44, 43, 48, 1),
    this.canBeNone = false,
    super.key,
  });

  @override
  State<PersonDropdown> createState() => _PersonDropdownState();
}

class _PersonDropdownState extends State<PersonDropdown> {
  String? _selectedValue = 'new';
  bool _hasError = false;
  String _errorMessage = '';
  List<model.Person>? persons;

  @override
  void initState() {
    super.initState();
  }

  Future<List<DropdownMenuItem<String>>> _loadPersons() async {
    try {
      // Получение данных через ViewModel
      var movieViewModel = Provider.of<MovieViewModel>(context, listen: false);
      var token = Provider.of<AuthenticationViewModel>(context, listen: false)
          .user!
          .token;
      persons = await movieViewModel.getPersons(token);

      // Преобразование в DropdownMenuItem
      var personItems = persons!
          .map(
            (person) => DropdownMenuItem<String>(
              value: person.passportID,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(person.name, style: TextStyle(color: widget.textColor)),
                  const SizedBox(width: 8),
                  Text(
                    person.passportID,
                    style: TextStyle(
                      color: widget.textColor.withOpacity(0.5),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList();

      // Возвращаем полный список с предустановленными значениями
      return [
        DropdownMenuItem<String>(
          value: 'new',
          child:
              Text('Новый персонаж', style: TextStyle(color: widget.textColor)),
        ),
        if (widget.canBeNone)
          DropdownMenuItem<String>(
            value: 'none',
            child:
                Text('Не создавать', style: TextStyle(color: widget.textColor)),
          ),
        ...personItems,
      ];
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
      });
      _showErrorToast();
      return [
        DropdownMenuItem<String>(
          value: 'new',
          child:
              Text('Новый персонаж', style: TextStyle(color: widget.textColor)),
        ),
        if (widget.canBeNone)
          DropdownMenuItem<String>(
            value: 'none',
            child:
                Text('Не создавать', style: TextStyle(color: widget.textColor)),
          ),
      ];
    }
  }

  void _showErrorToast() {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[800]!.withOpacity(0.8),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              _errorMessage,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DropdownMenuItem<String>>>(
      future: _loadPersons(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const StyledLoading();
        } else if (snapshot.hasError) {
          return const Text('Ошибка загрузки данных');
        } else if (snapshot.hasData) {
          var dropdownItems = snapshot.data!;
          if (!dropdownItems.any((item) => item.value == _selectedValue)) {
            _selectedValue = 'new';
          }
          return DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: TextStyle(color: widget.textColor),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: widget.borderColor),
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor: widget.fillColor,
            ),
            value: _selectedValue,
            onChanged: (String? newValue) {
              setState(() {
                _selectedValue = newValue;
              });
              if (newValue == 'none' || newValue == 'new') {
                widget.onChanged(newValue);
              } else {
                widget.onChanged(persons!.firstWhere((item) => item.passportID == newValue));
              }
            },
            items: dropdownItems,
            dropdownColor: widget.dropdownColor,
            style: TextStyle(color: widget.textColor),
          );
        } else {
          return const Text('Данные отсутствуют');
        }
      },
    );
  }
}
