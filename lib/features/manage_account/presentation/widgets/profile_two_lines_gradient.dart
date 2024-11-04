import 'package:flutter/material.dart';


import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/widgets/shimmer.dart';

class ProfileTwoLineGradientLoading extends StatefulWidget {
  const ProfileTwoLineGradientLoading({super.key});

  @override
  ProfileTwoLineGradientLoadingState createState() =>
      ProfileTwoLineGradientLoadingState();
}

class ProfileTwoLineGradientLoadingState
    extends State<ProfileTwoLineGradientLoading> {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListTile(
          dense: false,
          onTap: () {},
          subtitle: ShimmerLoading(
            isLoading: true,
            child: Container(
              height: 7,
              width: 80,
              decoration: BoxDecoration(
                color:AppColors.borderColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          title: ShimmerLoading(
            isLoading: true,
            child: Container(
              height: 10,
              width: 120,
              decoration: BoxDecoration(
                color:AppColors.borderColor,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          trailing: const ShimmerLoading(
            isLoading: true,
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.blackLight,
              size: 12,
            ),
          ),
      ),
    );
  }
}
