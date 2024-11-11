import 'package:flutter/material.dart';

class LabCheckBox extends StatefulWidget {
  final void Function(bool value)? onChanged;
  final Color activeColor;
  final Color borderColor;
  final Color checkColor;
  final Color inactiveColor;
  final bool value;

  const LabCheckBox({
    super.key,
    required this.onChanged,
    required this.value,
    this.activeColor = Colors.white70,
    this.borderColor = const Color.fromRGBO(61, 61, 61, 1),
    this.checkColor = const Color.fromRGBO(61, 61, 61, 1),
    this.inactiveColor = Colors.white12,
  });

  @override
  State<StatefulWidget> createState() => _LabCheckBoxState();
}

class _LabCheckBoxState extends State<LabCheckBox> {
  late bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: () {
      setState(() {
        value = !value;
      });
      widget.onChanged?.call(value);
    },
    child: Container(
      decoration: BoxDecoration(
        color: value ? widget.activeColor : widget.inactiveColor,
        border: Border.all(
          color: widget.borderColor,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(6.5),
      ),
      child: Icon(
        Icons.done,
        size: 19,
        color: value ? widget.checkColor : Colors.transparent,
      ),
    ),
  );
}
