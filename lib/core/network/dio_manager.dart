import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:movies_app/core/errors/api_error_handler.dart';
import 'package:movies_app/features/movies/data/models/movie_suggestions_response.dart';
import 'package:movies_app/features/movies/data/models/movies.dart';
import 'package:movies_app/features/movies/data/models/movies_list_model.dart';
import 'package:movies_app/features/movies/data/models/movie_details_response.dart';
import 'package:movies_app/core/config/api_constants.dart';
import 'package:movies_app/core/config/api_end_points.dart';

class DioManager {
  DioManager._();

  static DioManager? _instance;

  static DioManager getInstance() {
    _instance ??= DioManager._();
    return _instance!;
  }

  static final Dio dio =
      Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            receiveTimeout: Duration(seconds: 3),
            connectTimeout: Duration(seconds: 5),
          ),
        )
        ..interceptors.add(
          PrettyDioLogger(
            requestBody: true,
            responseHeader: true,
            responseBody: true,
            maxWidth: 90,
            enabled: kDebugMode,
          ),
        );

  //todo https://movies-api.accel.li/api/v2/movie_details.json?movie_id=1
  static Future<DetailsResponse> getMovieDetailsBySourceId({
    required int sourceId,
  }) async {
    try {
      var detailsResponse = await dio.get(
        ApiConstants.movieDetails,
        queryParameters: {"movie_id": sourceId},
      );
      return DetailsResponse.fromJson(detailsResponse.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }

  //todo https://movies-api.accel.li/api/v2/movie_suggestions.json?movie_i=10
  static Future<MovieSuggestions> getMovieSuggestions({
    required int sourceId,
  }) async {
    try {
      var detailsResponse = await dio.get(
        ApiEndPoints.movieSuggestions,
        queryParameters: {"movie_id": sourceId},
      );
      return MovieSuggestions.fromJson(detailsResponse.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    }
  }

  // TODO https://movies-api.accel.li/api/v2/list_movies.json?sort_by=year&order_by=desc&limit=15
  static Future<List<Movies>> getMovies({
    String? queryTerm,
    int limit = 15,
  }) async {
    try {
      final normalizedQuery = queryTerm?.trim();
      final queryParameters = normalizedQuery == null || normalizedQuery.isEmpty
          ? {'sort_by': 'year', 'order_by': 'desc', 'limit': limit}
          : {'query_term': normalizedQuery, 'limit': limit};
      final response = await dio.get(
        ApiEndPoints.listMovies,
        queryParameters: queryParameters,
      );

      final result = MoviesListModel.fromJson(response.data);

      return result.data?.movies ?? [];
    } on DioException catch (e) {
      throw ApiErrorHandler.handleDioException(e);
    } catch (e) {
      rethrow;
    }
  }
}
