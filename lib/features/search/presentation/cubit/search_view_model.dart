import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/network/dio_manager.dart';
import 'package:movies_app/features/search/presentation/cubit/search_stats.dart';

class SearchViewModel extends Cubit<SearchStats> {
  SearchViewModel() : super(SearchInitialStats());

  int _requestId = 0;
  String _lastQuery = '';

  Future<void> search(String query) async {
    final normalizedQuery = query.trim();
    _lastQuery = normalizedQuery;
    final requestId = ++_requestId;

    if (normalizedQuery.isEmpty) {
      emit(SearchInitialStats());
      return;
    }

    emit(SearchLoadingStats());
    try {
      final movies = await DioManager.getMovies(
        queryTerm: normalizedQuery,
        limit: 30,
      );
      if (requestId != _requestId || isClosed) return;
      if (movies.isEmpty) {
        emit(SearchEmptyStats());
      } else {
        emit(SearchSuccessStats(movies: movies));
      }
    } catch (error) {
      if (requestId != _requestId || isClosed) return;
      emit(const SearchErrorStats());
    }
  }

  Future<void> retry() => search(_lastQuery);
}
