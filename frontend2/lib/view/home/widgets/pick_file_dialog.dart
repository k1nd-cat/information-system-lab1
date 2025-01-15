import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PickFileDialog extends StatefulWidget {
  final void Function(Uint8List file, String fileName) sendFile;

  const PickFileDialog({
    required this.sendFile,
    super.key,
  });

  @override
  State<PickFileDialog> createState() => _PickFileDialogState();
}

class _PickFileDialogState extends State<PickFileDialog> {
  String _fileName = '';
  Uint8List? _fileBytes;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json', 'yaml'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _fileBytes = file.bytes!;
        _fileName = file.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(44, 43, 48, 1),
      title: const Text(
        'Выбор файла',
        style: TextStyle(
          color: Color.fromRGBO(214, 214, 214, 1),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: _pickFile,
          child: Center(
            child: Text(
              _fileName.isEmpty
                  ? 'Нажмите, чтобы выбрать файл'
                  : 'Файл: $_fileName',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromRGBO(242, 196, 206, 1),
          ),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: _fileBytes != null
              ? () {
                  widget.sendFile(_fileBytes!, _fileName);
                  Navigator.pop(context);
                }
              : null,
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromRGBO(242, 196, 206, 1),
          ),
          child: const Text('Ок'),
        ),
      ],
    );
  }
}
