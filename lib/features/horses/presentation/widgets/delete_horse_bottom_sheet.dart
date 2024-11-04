
import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

void showDeleteHorseBottomSheet({
  required BuildContext context,
  required String title,
  required Widget content,
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
        Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            child: Padding(
              padding:  const EdgeInsets.only(
                  top: kPadding, left: kPadding, right: kPadding),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        Center(
                          child: Text(title,
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
                          icon: const Icon(
                            Icons.close,
                            size: 18,
                            color: AppColors.yellow,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: kPadding,
                    ),
                    content,
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]);
    },
  );
}
