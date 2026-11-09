import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/features/movies/data/models/movies.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';

class SearchMovieCard extends StatelessWidget {
  const SearchMovieCard({super.key, required this.movie});

  final Movies movie;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final imageUrl = movie.mediumCoverImage ?? movie.largeCoverImage ?? '';
    final movieTitle = movie.title ?? movie.titleLong ?? '';

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: movie.id == null
          ? null
          : () => Navigator.pushNamed(
              context,
              AppRoutes.detailsRouteName,
              arguments: movie.id,
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (imageUrl.isEmpty)
                    ColoredBox(color: AppColors.fieldColor)
                  else
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => ColoredBox(
                        color: AppColors.fieldColor,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      errorWidget: (_, _, _) => ColoredBox(
                        color: AppColors.fieldColor,
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: AppColors.white70,
                        ),
                      ),
                    ),
                  PositionedDirectional(
                    top: 8,
                    end: 8,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blackColor71,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(AppAssets.star, width: 14, height: 14),
                          SizedBox(width: 4),
                          Text(
                            '${movie.rating ?? 0}',
                            style: AppStyles.bold12White,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            movieTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.bold14White,
          ),
          SizedBox(height: 2),
          Text(
            movie.year?.toString() ?? l10n.searchUnknownYear,
            style: AppStyles.white14.copyWith(color: AppColors.white70),
          ),
        ],
      ),
    );
  }
}
