import 'package:flutter/material.dart';

class LabLoginRegisterButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const LabLoginRegisterButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(151, 181, 255, 1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: const Color.fromRGBO(61, 61, 61, 1),
            width: 1.0,
          ),
        ),
        child: SizedBox(
          width: 300,
          height: 36.0,
          child: TextButton(
            onPressed: () => onPressed?.call(),
            child: const Text(
              'Войти',
              style: TextStyle(
                color: Color.fromRGBO(61, 61, 61, 1),
              ),
            ),
          ),
        ),
      );
}

class LabArentRegisterButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const LabArentRegisterButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: () => onPressed?.call(),
        child: Text(
          text,
          style: const TextStyle(
            color: Color.fromRGBO(61, 61, 61, 1),
          ),
        ),
      );
}
