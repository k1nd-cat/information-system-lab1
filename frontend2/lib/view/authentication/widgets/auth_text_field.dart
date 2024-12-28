import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final AuthTextFieldType type;
  final String? errorMessage;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.type,
    this.errorMessage,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final _focusNode = FocusNode();
  late bool _isObscureText;
  // late String? _errorMessage;

  @override
  void initState() {
    if (widget.type == AuthTextFieldType.username) {
      _isObscureText = false;
    } else {
      _isObscureText = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 292),
      child: TextField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: _isObscureText,
        decoration: InputDecoration(
          labelText: _labelText(widget.type),
          // TODO: Изменить цвет labelText
          errorText: widget.errorMessage,
          errorStyle: const TextStyle(color: Color.fromRGBO(89, 49, 49, 1.0)),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(242, 196, 206, 1), width: 1.0),
            borderRadius: BorderRadius.circular(3.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(242, 196, 206, 1), width: 1.0),
            borderRadius: BorderRadius.circular(3.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(89, 49, 49, 1.0), width: 1.0),
            borderRadius: BorderRadius.circular(3.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Color.fromRGBO(89, 49, 49, 1.0), width: 1.0),
            borderRadius: BorderRadius.circular(3.0),
          ),
          suffixIcon: widget.type != AuthTextFieldType.username
              ? IconButton(
            icon: Icon(
              _isObscureText ? Icons.visibility_outlined : Icons
                  .visibility_off_outlined,
              color: const Color.fromRGBO(242, 196, 206, 1),
              size: 18,
            ),
            onPressed: () {
              setState(() {
                _isObscureText = !_isObscureText;
                // _labelStyle = _currentLabelStyle();
              });
            },
          )
              : null,
        ),
        cursorColor: const Color.fromRGBO(242, 196, 206, 1),
        // onChanged: (String input) {
        //   widget.errorMessage = null;
        // },
      ),
    );
  }

//   TextStyle? _currentLabelStyle() {
//     FontWeight fontWeight = FontWeight.normal;
//
//     if (widget.controller.text != '') fontWeight = FontWeight.bold;
//     if (_errorMessage != null) return TextStyle(color: const Color.fromRGBO(89, 49, 49, 1.0), fontWeight: fontWeight);
//     if (widget.controller.text == '') return TextStyle(color: const Color.fromRGBO(242, 196, 206, 0.5), fontWeight: fontWeight);
//     return TextStyle(color: const Color.fromRGBO(242, 196, 206, 1.0), fontWeight: fontWeight);
//   }
}

enum AuthTextFieldType {
  username,
  password,
  repeatPassword,
}

String _labelText(AuthTextFieldType type) =>
    switch (type) {
      AuthTextFieldType.username => 'Имя пользователя',
      AuthTextFieldType.password => 'Пароль',
      AuthTextFieldType.repeatPassword => 'Повторите пароль'
    };
