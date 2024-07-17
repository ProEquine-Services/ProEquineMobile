import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/widgets/shimmer.dart';

class ProfileListTileGradient extends StatefulWidget {
  ProfileListTileGradient({super.key});

  @override
  ProfileListTileGradientState createState() => ProfileListTileGradientState();
}

class ProfileListTileGradientState extends State<ProfileListTileGradient> {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ListTile(
        dense: false,
        onTap: () {},
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShimmerLoading(
              isLoading: true,
              child: Container(
                height: 10,
                width: 260,
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
          ],
        ),
        trailing: // icon-1
            const ShimmerLoading(
          isLoading: false,
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
