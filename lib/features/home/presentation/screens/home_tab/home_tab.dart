import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/home/presentation/widgets/latest_movies_carousel.dart';
import 'package:movies_app/features/home/presentation/widgets/movie_card.dart';
import 'package:movies_app/features/home/presentation/widgets/movie_gradient.dart';
import 'package:movies_app/features/home/presentation/widgets/section_header.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/shared/widgets/custom_error_widget.dart';
import 'package:movies_app/shared/widgets/custom_loading_widget.dart';
import 'package:movies_app/features/home/presentation/cubit/home_stats.dart';
import 'package:movies_app/features/home/presentation/cubit/home_view_model.dart';

part 'home_tab_state.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}
