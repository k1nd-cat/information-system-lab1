import 'package:flutter/material.dart';

class EnumDropdown<T> extends StatefulWidget {
  final T value; // Используем value вместо initialValue
  final ValueChanged<T> onChanged;
  final List<T> values;
  final String labelText;
  final Color textColor;
  final Color borderColor;
  final Color fillColor;
  final Color dropdownColor;
  final bool readOnly;

  const EnumDropdown({
    required this.value, // Передаем текущее значение
    required this.onChanged,
    required this.values,
    required this.labelText,
    this.textColor = const Color.fromRGBO(214, 214, 214, 1),
    this.borderColor = const Color.fromRGBO(242, 196, 206, 1),
    this.fillColor = const Color.fromRGBO(44, 43, 48, 1),
    this.dropdownColor = const Color.fromRGBO(44, 43, 48, 1),
    this.readOnly = false,
    super.key,
  });

  @override
  State<EnumDropdown<T>> createState() => _EnumDropdownState<T>();
}

class _EnumDropdownState<T> extends State<EnumDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: widget.readOnly
              ? widget.textColor.withOpacity(0.5)
              : widget.textColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.readOnly
                ? widget.borderColor.withOpacity(0.5)
                : widget.borderColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.readOnly
                ? widget.borderColor.withOpacity(0.5)
                : widget.borderColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: widget.readOnly
            ? widget.fillColor.withOpacity(0.5)
            : widget.fillColor,
      ),
      value: widget.value, // Используем текущее значение из пропса
      onChanged: widget.readOnly
          ? null
          : (T? newValue) {
        if (newValue != null) {
          widget.onChanged(newValue);
        }
      },
      items: widget.values.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            value.toString().split('.').last,
            style: TextStyle(
              color: widget.readOnly
                  ? widget.textColor.withOpacity(0.5)
                  : widget.textColor,
            ),
          ),
        );
      }).toList(),
      dropdownColor: widget.dropdownColor,
      style: TextStyle(
        color: widget.readOnly
            ? widget.textColor.withOpacity(0.5)
            : widget.textColor,
      ),
    );
  }
}
