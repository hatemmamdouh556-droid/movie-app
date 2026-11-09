part of 'browse_stats.dart';

class BrowseSuccessStats extends BrowseStats {
  const BrowseSuccessStats({
    required this.genres,
    required this.selectedGenre,
    required this.movies,
  });

  final List<String> genres;
  final String selectedGenre;
  final List<Movies> movies;
}
