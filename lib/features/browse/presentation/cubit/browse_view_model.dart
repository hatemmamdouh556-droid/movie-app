import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/network/dio_manager.dart';
import 'package:movies_app/features/browse/presentation/cubit/browse_stats.dart';
import 'package:movies_app/features/movies/data/models/movies.dart';

class BrowseViewModel extends Cubit<BrowseStats> {
  BrowseViewModel() : super(const BrowseLoadingStats());

  static const _moviesLimit = 50;

  List<Movies> _allMovies = const [];
  List<String> _genres = const [];
  String? _selectedGenre;
  int _requestId = 0;

  Future<void> loadMovies() async {
    final requestId = ++_requestId;
    emit(const BrowseLoadingStats());
    try {
      final movies = await DioManager.getMovies(limit: _moviesLimit);
      if (requestId != _requestId || isClosed) return;
      if (movies.isEmpty) {
        _allMovies = const [];
        _genres = const [];
        _selectedGenre = null;
        emit(const BrowseEmptyStats());
        return;
      }

      _allMovies = movies;
      _genres =
          movies
              .expand((movie) => movie.genres ?? const <String>[])
              .where((genre) => genre.trim().isNotEmpty)
              .toSet()
              .toList()
            ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

      if (_genres.isEmpty) {
        _selectedGenre = null;
        emit(const BrowseEmptyStats());
        return;
      }

      _selectedGenre = _genres.contains('Action') ? 'Action' : _genres.first;
      _emitSelectedGenre();
    } catch (_) {
      if (requestId != _requestId || isClosed) return;
      emit(const BrowseErrorStats());
    }
  }

  void selectGenre(String genre) {
    if (!_genres.contains(genre) || genre == _selectedGenre) return;
    _selectedGenre = genre;
    _emitSelectedGenre();
  }

  void _emitSelectedGenre() {
    final selectedGenre = _selectedGenre;
    if (selectedGenre == null) {
      emit(const BrowseEmptyStats());
      return;
    }

    final filteredMovies = _allMovies
        .where((movie) => movie.genres?.contains(selectedGenre) ?? false)
        .toList();
    emit(
      BrowseSuccessStats(
        genres: _genres,
        selectedGenre: selectedGenre,
        movies: filteredMovies,
      ),
    );
  }
}
