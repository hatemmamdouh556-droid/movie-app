import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/browse/presentation/cubit/browse_stats.dart';
import 'package:movies_app/features/browse/presentation/cubit/browse_view_model.dart';
import 'package:movies_app/features/browse/presentation/widgets/browse_empty_view.dart';
import 'package:movies_app/features/browse/presentation/widgets/browse_error_view.dart';
import 'package:movies_app/features/browse/presentation/widgets/browse_movies_grid.dart';
import 'package:movies_app/features/browse/presentation/widgets/genre_chips.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/shared/widgets/custom_loading_widget.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => BrowseViewModel()..loadMovies(),
      child: BlocBuilder<BrowseViewModel, BrowseStats>(
        builder: (context, state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: switch (state) {
                BrowseLoadingStats() => const CustomLoadingWidget(),
                BrowseEmptyStats() => BrowseEmptyView(
                  message: l10n.browseNoMovies,
                ),
                BrowseErrorStats() => BrowseErrorView(
                  message: l10n.browseError,
                  retryLabel: l10n.browseRetry,
                  onRetry: () => context.read<BrowseViewModel>().loadMovies(),
                ),
                BrowseSuccessStats(
                  :final genres,
                  :final selectedGenre,
                  :final movies,
                ) =>
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: GenreChips(
                          genres: genres,
                          selectedGenre: selectedGenre,
                          onGenreTap: context
                              .read<BrowseViewModel>()
                              .selectGenre,
                        ),
                      ),
                      Expanded(
                        child: movies.isEmpty
                            ? BrowseEmptyView(message: l10n.browseNoMovies)
                            : BrowseMoviesGrid(movies: movies),
                      ),
                    ],
                  ),
              },
            ),
          ],
        ),
      ),
    );
  }
}
