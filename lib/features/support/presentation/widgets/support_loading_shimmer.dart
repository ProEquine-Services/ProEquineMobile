import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/shimmer.dart';

class SupportLoadingWidget extends StatefulWidget {
  const SupportLoadingWidget({Key? key}) : super(key: key);

  @override
  State<SupportLoadingWidget> createState() => _SupportLoadingWidgetState();
}

class _SupportLoadingWidgetState extends State<SupportLoadingWidget> {
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
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 7),
                          child: ShimmerLoading(
                              isLoading: true,
                              child: Container(
                                height: 100,
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
