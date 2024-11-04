import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class ProfileTwoLinesLoading extends StatefulWidget {
  const ProfileTwoLinesLoading({
    super.key,
  });

  @override
  ProfileTwoLinesLoadingState createState() => ProfileTwoLinesLoadingState();
}

class ProfileTwoLinesLoadingState extends State<ProfileTwoLinesLoading> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      onTap: () {},
      subtitle: FadeShimmer(
        baseColor: AppColors.shimmerColors,
        highlightColor: AppColors.shimmerColor2,
        height: 7,
        width: 80,
        radius: 20,
      ),
      title: FadeShimmer(
        baseColor: AppColors.shimmerColors,
        highlightColor: AppColors.shimmerColor2,
        height: 10,
        width: 100,
        radius: 20,
      ),
      trailing: FadeShimmer.round(
        size: 12,
        baseColor: AppColors.shimmerColors,
        highlightColor: AppColors.shimmerColor2,
      ),
    );
  }
}
