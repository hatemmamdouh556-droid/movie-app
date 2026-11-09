import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/browse/presentation/screens/browse_screen.dart';
import 'package:movies_app/features/home/presentation/screens/home_tab/home_tab.dart';
import 'package:movies_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:movies_app/features/search/presentation/screens/search_tab.dart';
import 'package:movies_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/features/home/presentation/widgets/home_navigation_bar.dart';

/// Movie browsing home for an authenticated user, with account actions.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final _tabs = [
    HomeTab(),
    const SearchTab(),
    const BrowseScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: BlocBuilder<HomeCubit, int>(
        builder: (context, selectedIndex) => Scaffold(
          backgroundColor: AppColors.backgroundColor,
          extendBody: true,
          body: SafeArea(
            child: IndexedStack(index: selectedIndex, children: _tabs),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            minimum: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: HomeNavigationBar(selectedIndex: selectedIndex),
          ),
        ),
      ),
    );
  }
}
