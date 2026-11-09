import 'package:movies_app/features/watchlist/data/saved_movie.dart';

class WatchListState {
  WatchListState({List<SavedMovie>? movies, this.errorMessage})
    : movies = movies ?? [];

  final List<SavedMovie> movies;
  final String? errorMessage;

  int get count => movies.length;

  bool isSaved(int movieId) => movies.any((movie) => movie.id == movieId);
}
