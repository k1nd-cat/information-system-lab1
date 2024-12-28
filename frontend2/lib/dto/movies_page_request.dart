import '../viewmodel/movie_viewmodel.dart';

class MoviesPageRequest {
  int size;
  int page;
  String namePrefix;
  int minGoldenPalmCount;
  bool isUsaBoxOfficeUnique;
  Sorting sorting;

  MoviesPageRequest({
    required this.size,
    required this.page,
    required this.namePrefix,
    required this.minGoldenPalmCount,
    required this.isUsaBoxOfficeUnique,
    required this.sorting
  });

  Map<String, dynamic> toJson() {
    return {
      'size': size,
      'page': page,
      'namePrefix': namePrefix,
      'minGoldenPalmCount': minGoldenPalmCount,
      'isUsaBoxOfficeUnique': isUsaBoxOfficeUnique,
      'sorting' : sorting.name,
    };
  }
}
