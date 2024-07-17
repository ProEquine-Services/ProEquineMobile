import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/features/support/presentation/widgets/media_link_list_tile.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/widgets/custom_header.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  State<SocialMediaScreen> createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
            title: "We’re on social media ",
            isThereBackButton: true,
            isThereChangeWithNavigate: false,
            isThereThirdOption: false),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  "ProEquine Services",
                  style: AppStyles.profileTitles,
                  textAlign: TextAlign.start,
                ),
              ),

              MediaListTileWidget(
                title: "Instagram",
                application: AppIcons.instagramMedia,
                applicationUrl: 'https://www.instagram.com/proequine.ae/',
              ),
              MediaListTileWidget(
                title: "Facebook",
                application: AppIcons.facebookMedia,
                applicationUrl: 'https://www.facebook.com/proequine.ae',
              ),
              // MediaListTileWidget(
              //   title: "TikTok",
              //   application: AppIcons.tikTokMedia,
              //   applicationUrl:
              //   'https://www.tiktok.com/@proequine.ae?_t=8f3HLWvQOLI&_r=1',
              // ),
              // MediaListTileWidget(
              //   title: "Youtube",
              //   application: AppIcons.youtubeMedia,
              //   applicationUrl: 'https://www.youtube.com/@ProEquine',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
