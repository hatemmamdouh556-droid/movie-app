import 'package:flutter/material.dart';
import 'package:movies_app/features/movies/data/models/movies.dart';
import 'package:movies_app/features/search/presentation/widgets/search_movie_card.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key, required this.movies});

  final List<Movies> movies;

  @override
  Widget build(BuildContext context) => GridView.builder(
    padding: EdgeInsets.fromLTRB(16, 4, 16, 24),
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 220,
      mainAxisExtent: 340,
      crossAxisSpacing: 12,
      mainAxisSpacing: 16,
    ),
    itemCount: movies.length,
    itemBuilder: (context, index) => SearchMovieCard(movie: movies[index]),
  );
}
