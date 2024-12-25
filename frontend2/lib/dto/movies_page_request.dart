class MoviesPageRequest {
  int size;
  int page;
  String namePrefix;
  int minGoldenPalmCount;
  bool isUsaBoxOfficeUnique;

  MoviesPageRequest({
    required this.size,
    required this.page,
    required this.namePrefix,
    required this.minGoldenPalmCount,
    required this.isUsaBoxOfficeUnique,
  });

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'page': page,
      'namePrefix': namePrefix,
      'minGoldenPalmCount': minGoldenPalmCount,
      'isUsaBoxOfficeUnique': isUsaBoxOfficeUnique,
    };
  }
}
