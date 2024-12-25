import 'package:flutter/material.dart';

class StyledLoading extends StatelessWidget {
  const StyledLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFF2C4CE)),
        strokeWidth: 7.0,
      ),
    );
  }
}
