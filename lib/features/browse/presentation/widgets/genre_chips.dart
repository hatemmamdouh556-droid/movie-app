import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class GenreChips extends StatelessWidget {
  static const _accentColor = Color(0xFFFFBB3B);

  const GenreChips({
    super.key,
    required this.genres,
    required this.selectedGenre,
    required this.onGenreTap,
  });

  final List<String> genres;
  final String selectedGenre;
  final ValueChanged<String> onGenreTap;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 48,
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      scrollDirection: Axis.horizontal,
      itemCount: genres.length,
      separatorBuilder: (_, _) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        final genre = genres[index];
        final isSelected = genre == selectedGenre;
        return Material(
          color: AppColors.transparentColor,
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => onGenreTap(genre),
            child: Container(
              height: 48,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? _accentColor : AppColors.transparentColor,
                border: Border.all(color: _accentColor, width: 2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                genre,
                style: TextStyle(
                  color: isSelected ? AppColors.blackColor : _accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
