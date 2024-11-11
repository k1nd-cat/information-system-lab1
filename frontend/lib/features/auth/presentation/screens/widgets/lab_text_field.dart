import 'package:flutter/material.dart';

class LabTextField extends StatefulWidget {
  final TextEditingController? controller;
  final LabTextFieldType type;
  final String title;
  final String errorText;

  const LabTextField({
    super.key,
    required this.controller,
    required this.type,
    required this.title,
    required this.errorText,
  });

  @override
  State<LabTextField> createState() => _LabTextFieldState();
}

class _LabTextFieldState extends State<LabTextField> {
  late bool isNotVisibility;

  @override
  void initState() {
    isNotVisibility = widget.type == LabTextFieldType.login ? false : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300, maxHeight: 36.0),
        child: TextField(
          controller: widget.controller,
          obscureText: isNotVisibility,
          decoration: InputDecoration(
            errorText: widget.errorText,
            filled: true,
            fillColor: const Color.fromRGBO(255, 255, 255, 1),
            isDense: true,
            contentPadding: const EdgeInsets.all(11.0),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(
                color: Color.fromRGBO(61, 61, 61, 1),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              borderSide: BorderSide(
                color: Color.fromRGBO(61, 61, 61, 1),
              ),
            ),
            enabled: true,
            hintText: widget.title,
            hintStyle: const TextStyle(
              color: Color.fromRGBO(150, 150, 150, 1),
            ),
            suffixIcon: widget.type == LabTextFieldType.password
                ? IconButton(
                    icon: Icon(
                      isNotVisibility ? Icons.visibility : Icons.visibility_off,
                      color: const Color.fromRGBO(150, 150, 150, 1),
                    ),
                    onPressed: () {
                      setState(() {
                        isNotVisibility = !isNotVisibility;
                      });
                    })
                : null,
          ),
        ),
      );
}

enum LabTextFieldType {
  login,
  password,
}
