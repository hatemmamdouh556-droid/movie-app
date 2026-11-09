import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';

class ProfileTabBarDelegate extends SliverPersistentHeaderDelegate {
  ProfileTabBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) =>
      ColoredBox(color: AppColors.profileHeaderColor, child: tabBar);

  @override
  bool shouldRebuild(ProfileTabBarDelegate oldDelegate) =>
      oldDelegate.tabBar != tabBar;
}
