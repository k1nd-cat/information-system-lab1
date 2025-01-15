import 'dart:convert';

class FileHistory {
  int id;

  String status;

  String creatorName;

  String fileName;

  int addedMoviesCount;

  FileHistory({
    required this.id,
    required this.status,
    required this.creatorName,
    required this.fileName,
    required this.addedMoviesCount,
  });

  factory FileHistory.fromJson(Map<String, dynamic> json) {
    return FileHistory(
      id: json['id'],
      status: utf8.decode(latin1.encode(json['status'])),
      creatorName: utf8.decode(latin1.encode(json['creatorName'])),
      fileName: utf8.decode(latin1.encode(json['fileName'])),
      addedMoviesCount: json['addedMoviesCount'],
    );
  }
}
