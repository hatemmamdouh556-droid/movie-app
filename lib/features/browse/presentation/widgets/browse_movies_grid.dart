import 'package:flutter/material.dart';
import 'package:movies_app/features/browse/presentation/widgets/browse_movie_card.dart';
import 'package:movies_app/features/movies/data/models/movies.dart';
import 'package:movies_app/utils/app_routes.dart';

class BrowseMoviesGrid extends StatelessWidget {
  const BrowseMoviesGrid({super.key, required this.movies});

  final List<Movies> movies;

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: const EdgeInsets.fromLTRB(12, 24, 12, 100),
    itemCount: movies.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.67,
      crossAxisSpacing: 20,
      mainAxisSpacing: 16,
    ),
    itemBuilder: (context, index) {
      final movie = movies[index];
      return BrowseMovieCard(
        imageUrl: movie.mediumCoverImage ?? '',
        rating: movie.rating ?? 0,
        onTap: movie.id == null
            ? null
            : () => Navigator.pushNamed(
                context,
                AppRoutes.detailsRouteName,
                arguments: movie.id,
              ),
      );
    },
  );
}
