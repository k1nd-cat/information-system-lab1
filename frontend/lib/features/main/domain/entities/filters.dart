class MovieFilters {
  String prefix;
  int minGoldenPalmCount;
  bool isUsaBoxOfficeUnique;

  MovieFilters({
    this.prefix = '',
    this.minGoldenPalmCount = 0,
    this.isUsaBoxOfficeUnique = false,
  });

  factory MovieFilters.empty() => MovieFilters();
}