import 'package:flutter/material.dart';
import 'package:proequine_dev/core/utils/sharedpreferences/SharedPreferencesHelper.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';


void showPrivacyBottomSheet({
  required BuildContext context,
  required String content,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
        ? AppColors.formsBackground
        : AppColors.backgroundColorLight,
    useSafeArea: false,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    builder: (BuildContext context) {
      return Wrap(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.90,
          child: Padding(
            padding: const EdgeInsets.only(
                top: kPadding, left: kPadding, right: kPadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Center(
                        child: Text('Privacy&Policy',
                            style: TextStyle(
                                fontSize: 17,
                                fontFamily: "notosan",
                                fontWeight: FontWeight.w600,
                                color: AppSharedPreferences.getTheme ==
                                    'ThemeCubitMode.dark'
                                    ? Colors.white
                                    : AppColors.blackLight)),
                      ),

                     IconButton(
                          icon: const Icon(Icons.close,size: 18,color: AppColors.yellow,),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),

                    ],
                  ),
                  const SizedBox(
                    height: kPadding,
                  ),
                   Text(
                    content,
                    style: const TextStyle(
                      // color: AppColors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'notosan',
                        fontSize: 14),
                  ),
                  const SizedBox(height: 50,),
                ],
              ),
            ),
          ),
        ),
      ]);
    },
  );
}
