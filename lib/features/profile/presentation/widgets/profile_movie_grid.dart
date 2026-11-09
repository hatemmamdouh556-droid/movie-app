import 'package:flutter/material.dart';
import 'package:movies_app/features/watchlist/data/saved_movie.dart';
import 'package:movies_app/features/profile/presentation/widgets/profile_empty_state.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class ProfileMovieGrid extends StatelessWidget {
  ProfileMovieGrid({required this.movies});

  final List<SavedMovie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return ProfileEmptyState();
    final width = context.width;
    final height = context.height;

    return GridView.builder(
      padding: EdgeInsets.fromLTRB(
        width * 0.037,
        height * 0.017,
        width * 0.037,
        height * 0.107,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: height * 0.017,
        crossAxisSpacing: width * 0.028,
        childAspectRatio: 0.65,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.detailsRouteName,
            arguments: movie.id,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(width * 0.037),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  movie.posterUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) =>
                      ColoredBox(color: AppColors.fieldColor),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.all(width * 0.019),
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.014,
                      vertical: height * 0.002,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.blackColor71,
                      borderRadius: BorderRadius.circular(width * 0.023),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${movie.rating}', style: AppStyles.white14),
                        SizedBox(width: width * 0.009),
                        Image.asset(
                          AppAssets.star,
                          width: width * 0.033,
                          height: width * 0.033,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
