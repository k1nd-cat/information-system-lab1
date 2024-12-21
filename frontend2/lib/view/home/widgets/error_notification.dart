import 'package:flutter/material.dart';

class ToastMessage extends StatefulWidget {
  final String message;
  final Duration duration;

  const ToastMessage({
    required this.message,
    this.duration = const Duration(seconds: 2),
    super.key,
  });

  @override
  State<ToastMessage> createState() => _ToastMessageState();
}

class _ToastMessageState extends State<ToastMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 20),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    Future.delayed(widget.duration, () {
      _controller.reverse().then((_) => {
            if (mounted) {Navigator.of(context).pop()},
          });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[800]!.withOpacity(0.8),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            widget.message,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}

void showToast(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ToastMessage(message: message);
    },
  );
}
