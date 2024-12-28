import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum InputType {
  typeString,
  typeInt,
  typeDouble,
}

class StyledTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Color textColor;
  final Color borderColor;
  final Color fillColor;
  final InputType inputType;
  final bool allowNegative;
  final bool readOnly;
  final FormFieldValidator<String>? validator;

  const StyledTextField({
    required this.controller,
    required this.labelText,
    this.textColor = const Color.fromRGBO(214, 214, 214, 1),
    this.borderColor = const Color.fromRGBO(242, 196, 206, 1),
    this.fillColor = const Color.fromRGBO(44, 43, 48, 1),
    this.inputType = InputType.typeString,
    this.allowNegative = false,
    this.readOnly = false,
    this.validator,
    super.key,
  });

  @override
  State<StyledTextField> createState() => _StyledTextFieldState();
}

class _StyledTextFieldState extends State<StyledTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isEmpty = widget.controller.text.isEmpty;
    final isFocused = _focusNode.hasFocus;

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      readOnly: widget.readOnly,
      validator: widget.validator,
      style: TextStyle(
        color: widget.readOnly ? widget.textColor.withOpacity(0.5) : widget.textColor,
      ),
      keyboardType: _getKeyboardType(widget.inputType),
      inputFormatters: _getInputFormatters(widget.inputType, widget.allowNegative),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: isEmpty && !isFocused
              ? widget.textColor.withOpacity(0.5)
              : widget.textColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: widget.readOnly ? widget.fillColor.withOpacity(0.5) : widget.fillColor,
      ),
    );
  }

  TextInputType _getKeyboardType(InputType inputType) {
    switch (inputType) {
      case InputType.typeInt:
        return TextInputType.number;
      case InputType.typeDouble:
        return const TextInputType.numberWithOptions(decimal: true);
      case InputType.typeString:
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> _getInputFormatters(InputType inputType, bool allowNegative) {
    switch (inputType) {
      case InputType.typeInt:
        return [
          FilteringTextInputFormatter.allow(RegExp(allowNegative ? r'^-?\d*' : r'^\d*')),
        ];
      case InputType.typeDouble:
        return [
          FilteringTextInputFormatter.allow(RegExp(allowNegative ? r'^-?\d*\.?\d*' : r'^\d*\.?\d*')),
        ];
      case InputType.typeString:
      default:
        return [];
    }
  }
}