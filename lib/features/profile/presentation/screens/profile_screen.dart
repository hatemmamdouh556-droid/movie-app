import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movies_app/features/auth/domain/auth_failure.dart';
import 'package:movies_app/features/profile/presentation/widgets/profile_action_button.dart';
import 'package:movies_app/features/profile/presentation/widgets/profile_movie_grid.dart';
import 'package:movies_app/features/profile/presentation/widgets/profile_stat.dart';
import 'package:movies_app/features/profile/presentation/widgets/profile_tab_bar_delegate.dart';
import 'package:movies_app/features/watchlist/presentation/cubit/history_cubit.dart';
import 'package:movies_app/features/watchlist/presentation/cubit/watch_list_cubit.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/utils/app_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<void> _confirmLogout(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final authCubit = context.read<AuthCubit>();
    final messenger = ScaffoldMessenger.of(context);
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.darkFieldColor,
        title: Text(l10n.authLogout),
        content: Text(l10n.authLogoutConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.authCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.authLogout),
          ),
        ],
      ),
    );
    if (shouldLogout != true) return;
    try {
      await authCubit.signOut();
    } on AuthFailure {
      messenger.showSnackBar(SnackBar(content: Text(l10n.authErrorUnexpected)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = context.watch<AuthCubit>().state.user;
    final name = user?.displayName?.trim() ?? '';
    final photoUrl = user?.photoUrl;
    final width = context.width;
    final height = context.height;

    final watchList = context.watch<WatchListCubit>().state;
    final history = context.watch<HistoryCubit>().state;

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverToBoxAdapter(
            child: Container(
              color: AppColors.profileHeaderColor,
              padding: EdgeInsets.fromLTRB(
                width * 0.037,
                height * 0.026,
                width * 0.037,
                0,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width * 0.302,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: width * 0.135,
                              backgroundColor: AppColors.fieldColor,
                              backgroundImage: photoUrl == null
                                  ? null
                                  : photoUrl.startsWith('assets/')
                                  ? AssetImage(photoUrl)
                                  : NetworkImage(photoUrl),
                              child: photoUrl == null
                                  ? Icon(
                                      Icons.person_outline,
                                      size: width * 0.135,
                                      color: AppColors.primaryColor,
                                    )
                                  : null,
                            ),
                            SizedBox(height: height * 0.013),
                            Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppStyles.bold20White,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ProfileStat(
                          count: watchList.count,
                          label: l10n.profileWishList,
                        ),
                      ),
                      Expanded(
                        child: ProfileStat(
                          count: history.count,
                          label: l10n.profileHistory,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.021),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: ProfileActionButton(
                          label: l10n.authEditProfile,
                          color: AppColors.primaryColor,
                          textColor: AppColors.blackColor,
                          onPressed: () => Navigator.of(
                            context,
                          ).pushNamed(AppRoutes.updateProfileRouteName),
                        ),
                      ),
                      SizedBox(width: width * 0.023),
                      Expanded(
                        flex: 2,
                        child: ProfileActionButton(
                          label: l10n.profileExit,
                          icon: Icons.logout,
                          color: AppColors.logoutColor,
                          textColor: AppColors.whiteColor,
                          onPressed: () => _confirmLogout(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.017),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: ProfileTabBarDelegate(
              TabBar(
                indicatorColor: AppColors.primaryColor,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: AppColors.transparentColor,
                labelColor: AppColors.whiteColor,
                unselectedLabelColor: AppColors.whiteColor,
                labelStyle: AppStyles.white20,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.format_list_bulleted,
                      color: AppColors.primaryColor,
                      size: width * 0.074,
                    ),
                    text: l10n.profileWatchList,
                  ),
                  Tab(
                    icon: Icon(
                      Icons.folder,
                      color: AppColors.primaryColor,
                      size: width * 0.074,
                    ),
                    text: l10n.profileHistory,
                  ),
                ],
              ),
            ),
          ),
        ],
        body: ColoredBox(
          color: AppColors.backgroundColor,
          child: TabBarView(
            children: [
              ProfileMovieGrid(movies: watchList.movies),
              ProfileMovieGrid(movies: history.movies),
            ],
          ),
        ),
      ),
    );
  }
}
