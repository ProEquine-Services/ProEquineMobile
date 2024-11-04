import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../data/media_service_model.dart';

class MediaSummaryScreen extends StatelessWidget {
  final MediaServiceModel? mediaServiceModel;

  const MediaSummaryScreen({super.key, this.mediaServiceModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Summary",
          isThereBackButton: false,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 14,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0xFFDFD9C9)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 3, vertical: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Service",
                          style: AppStyles.summaryTitleStyle,
                        ),
                        Text(
                          mediaServiceModel!.serviceType,
                          style: AppStyles.summaryDesStyle,
                        ),
                      ],
                    ),
                    const CustomDivider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Event",
                          style: AppStyles.summaryTitleStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          mediaServiceModel!.eventName,
                          style: AppStyles.summaryDesStyle,
                        ),
                      ],
                    ),
                    const CustomDivider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Horses",
                          style: AppStyles.summaryTitleStyle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          mediaServiceModel!.horsesNumber,
                          style: AppStyles.summaryDesStyle,
                        ),
                      ],
                    ),
                    mediaServiceModel?.notes != null
                        ? const CustomDivider()
                        : const SizedBox(),
                    mediaServiceModel?.notes != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Notes",
                                style: AppStyles.summaryTitleStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                mediaServiceModel?.notes??'',
                                style: AppStyles.summaryDesStyle,
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
            const Spacer(),
            RebiButton(
                //
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BottomNavigation(
                              selectedIndex: 1,
                            )),
                  );
                },
                child:  const Text("Close", style: AppStyles.buttonStyle,)),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
