import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/search/presentation/cubit/search_stats.dart';
import 'package:movies_app/features/search/presentation/cubit/search_view_model.dart';
import 'package:movies_app/features/search/presentation/widgets/search_error.dart';
import 'package:movies_app/features/search/presentation/widgets/search_message.dart';
import 'package:movies_app/features/search/presentation/widgets/search_results.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

part 'search_tab_content.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => SearchViewModel(),
    child: const _SearchTabContent(),
  );
}
