import 'package:movies_app/features/movies/data/models/movies.dart';

part 'search_initial_stats.dart';
part 'search_loading_stats.dart';
part 'search_success_stats.dart';
part 'search_empty_stats.dart';
part 'search_error_stats.dart';

sealed class SearchStats {
  const SearchStats();
}
