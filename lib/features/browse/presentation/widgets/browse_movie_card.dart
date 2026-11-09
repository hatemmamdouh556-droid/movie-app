import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class BrowseMovieCard extends StatelessWidget {
  const BrowseMovieCard({
    super.key,
    required this.imageUrl,
    required this.rating,
    required this.onTap,
  });

  static const _accentColor = Color(0xFFFFBB3B);

  final String imageUrl;
  final num rating;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: AppColors.fieldColor,
    borderRadius: BorderRadius.circular(18),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (imageUrl.isEmpty)
            const Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: AppColors.white70,
              ),
            )
          else
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, _) => const Center(
                child: CircularProgressIndicator(color: _accentColor),
              ),
              errorWidget: (_, _, _) => const Center(
                child: Icon(
                  Icons.broken_image_outlined,
                  color: AppColors.white70,
                ),
              ),
            ),
          PositionedDirectional(
            top: 20,
            start: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xCC282A28),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    rating.toString(),
                    style: const TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.star, color: _accentColor, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
