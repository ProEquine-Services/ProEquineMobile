import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/shimmer.dart';

class NotificationsLoadingWidget extends StatefulWidget {
  const NotificationsLoadingWidget({Key? key}) : super(key: key);

  @override
  State<NotificationsLoadingWidget> createState() => _NotificationsLoadingWidgetState();
}

class _NotificationsLoadingWidgetState extends State<NotificationsLoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Column(
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 7),
                          child: ShimmerLoading(
                              isLoading: true,
                              child: Container(
                                height: 80,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )));
                    }),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
