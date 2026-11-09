import 'package:movies_app/features/movies/data/models/movies.dart';

part 'browse_loading_stats.dart';
part 'browse_success_stats.dart';
part 'browse_empty_stats.dart';
part 'browse_error_stats.dart';

sealed class BrowseStats {
  const BrowseStats();
}
