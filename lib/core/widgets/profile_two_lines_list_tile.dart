import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class ProfileTwoLineListTile extends StatefulWidget {
  bool ableToEdit = true;
  bool isDeleteAccount = false;
  String? title;
  String? subTitle;
  Function? onTap;

  ProfileTwoLineListTile(
      {super.key,
      this.ableToEdit = true,
      this.isDeleteAccount = false,
      this.title,
      this.subTitle,
      this.onTap});

  @override
  ProfileTwoLineListTileState createState() => ProfileTwoLineListTileState();
}

class ProfileTwoLineListTileState extends State<ProfileTwoLineListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      onTap: () {
        widget.onTap!();
      },
      subtitle: Text(
        widget.subTitle!,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: AppColors.formsHintFontLight,
          fontSize: 12,
          fontFamily: 'Noto Sans',
          fontWeight: FontWeight.w400,
        ),
      ),
      title: Text(
        widget.title??"Other",
        textAlign: TextAlign.start,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color:
                widget.isDeleteAccount ? AppColors.red : AppColors.blackLight,
            fontFamily: 'notosan',
            fontSize: 14),
      ),
      trailing: widget.ableToEdit
          ? const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.blackLight,
              size: 12,
            )
          : const SizedBox(),
    );
  }
}
