import 'package:flutter/material.dart';
import 'package:frontend2/view/widgets/styled_loading.dart';
import 'package:frontend2/viewmodel/movie_viewmodel.dart';
import 'package:provider/provider.dart';

class FileHistoryDialog extends StatefulWidget {
  const FileHistoryDialog({super.key});

  @override
  State<FileHistoryDialog> createState() => _FileHistoryDialogState();
}

class _FileHistoryDialogState extends State<FileHistoryDialog> {
  @override
  Widget build(BuildContext context) {
    final movieViewModel = Provider.of<MovieViewModel>(context);
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(44, 43, 48, 1),
      title: const Text(
        'История загрузок',
        style: TextStyle(
          color: Color.fromRGBO(214, 214, 214, 1),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 700),
          child: FutureBuilder(
              future: movieViewModel.getFileHistory(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const StyledLoading();
                } else if (snapshot.hasError) {
                  return const Text('Не удалось загрузить историю');
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Text('Загрузки файлов пока не производилось');
                } else if (snapshot.hasData) {
                  final fileHistoryList = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: double.infinity),
                          child: DataTable(
                            columns: const [
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Статус')),
                              DataColumn(label: Text('Создатель')),
                              DataColumn(label: Text('Имя файла')),
                              DataColumn(label: Text('Количество добавленных фильмов')),
                              DataColumn(label: Text('')),
                            ],
                            rows: fileHistoryList.map((fileHistory) {
                              return DataRow(cells: [
                                DataCell(Text(fileHistory.id.toString())),
                                DataCell(Text(fileHistory.status)),
                                DataCell(Text(fileHistory.creatorName)),
                                DataCell(
                                  Row(
                                    children: [
                                      Text(_goodFilenameFormat(fileHistory.fileName)),
                                      if (fileHistory.status == 'PASS')
                                        IconButton(
                                          icon: const Icon(Icons.download),
                                          onPressed: () {
                                            movieViewModel.downloadFile(fileHistory.fileName);
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                                DataCell(Text(fileHistory.addedMoviesCount.toString())),
                                DataCell(Container()),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text('Данные отсутствуют');
                }
              }),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: const Color.fromRGBO(242, 196, 206, 1),
          ),
          child: const Text('Ок'),
        ),
      ],
    );
  }

  String _goodFilenameFormat(String fileName) {
    int lastUnderscoreIndex = fileName.lastIndexOf('_');
    if (lastUnderscoreIndex != -1) {
      int extensionIndex = fileName.lastIndexOf('.');
      if (extensionIndex != -1 && extensionIndex > lastUnderscoreIndex) {
        return fileName.substring(0, lastUnderscoreIndex) +
            fileName.substring(extensionIndex);
      }
    }
    return fileName;
  }
}
