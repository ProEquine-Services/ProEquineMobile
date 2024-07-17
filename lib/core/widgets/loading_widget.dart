import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

class LoadingCircularWidget extends StatelessWidget {
  final bool isDeleteButton;
  const LoadingCircularWidget({super.key,this.isDeleteButton=false});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        backgroundColor:isDeleteButton
            ? AppColors.red
            : AppColors.yellow,
        valueColor:  AlwaysStoppedAnimation<Color>(isDeleteButton?AppColors.red:AppColors.gold),
      ),
    );
  }
}
