import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';

class ProfileListTileWidget extends StatefulWidget {
  bool notificationList = false;
  bool isThereNewNotification = false;
  bool isDeleteAccount = false;
  String? title;
  Function? onTap;

  ProfileListTileWidget(
      {super.key,
      this.notificationList = false,
      this.isThereNewNotification = true,
      this.isDeleteAccount = false,
      this.title,
      this.onTap});

  @override
  ProfileListTileWidgetState createState() => ProfileListTileWidgetState();
}

class ProfileListTileWidgetState extends State<ProfileListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: const VisualDensity(horizontal: 0, vertical: -1),
      style: ListTileStyle.list,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      dense: false,
      onTap: () {
        widget.onTap!();
      },
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: widget.isDeleteAccount
                    ? AppColors.red
                    : AppColors.blackLight,
                fontFamily: 'notosan',
                fontSize: 14),
          ),
          const SizedBox(
            height: 4,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          widget.notificationList && widget.isThereNewNotification
              ? Container(
                  height: 6,
                  width: 6,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                )
              : const SizedBox(
                  height: 6,
                  width: 6,
                ), // icon-1
          Icon(
            Icons.arrow_forward_ios_rounded,
            color:
                widget.isDeleteAccount ? AppColors.red : AppColors.blackLight,
            size: 12,
          ),
        ],
      ),
    );
  }
}
