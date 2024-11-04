import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/colors/app_colors.dart';

class MediaListTileWidget extends StatefulWidget {
  final String? title;
  final String? application;
  final Function? onTap;
  final String applicationUrl;

  const MediaListTileWidget(
      {super.key,
      this.title,
      this.onTap,
      this.application,
      required this.applicationUrl});

  @override
  MediaListTileWidgetState createState() => MediaListTileWidgetState();
}

class MediaListTileWidgetState extends State<MediaListTileWidget> {
  void openApplication() async {
    if (!await launchUrl(Uri.parse(widget.applicationUrl),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${widget.applicationUrl}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: false,
      onTap: () {
        openApplication();
      },
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(widget.application!),
        ],
      ),
      title: Text(
        widget.title!,
        textAlign: TextAlign.start,
        style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.blackLight,
            fontFamily: 'notosan',
            fontSize: 14),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        color: AppColors.blackLight,
        size: 12,
      ),
    );
  }
}
