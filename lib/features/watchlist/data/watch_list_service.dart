import 'package:movies_app/features/watchlist/data/saved_movie.dart';

abstract class WatchListService {
  Stream<List<SavedMovie>> watchList(String uid);

  Future<void> add(String uid, SavedMovie movie);

  Future<void> remove(String uid, int movieId);
}
