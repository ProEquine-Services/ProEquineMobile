import 'package:flutter/material.dart';
import 'package:proequine_dev/core/constants/colors/app_colors.dart';
import 'package:proequine_dev/core/constants/routes/routes.dart';

import '../../../../core/widgets/shimmer.dart';

class TransportsLoadingWidget extends StatefulWidget {
  final bool shipping;

  const TransportsLoadingWidget({Key? key, required this.shipping})
      : super(key: key);

  @override
  State<TransportsLoadingWidget> createState() =>
      _TransportsLoadingWidgetState();
}

class _TransportsLoadingWidgetState extends State<TransportsLoadingWidget> {
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
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: ShimmerLoading(
                              isLoading: true,
                              child: Container(
                                height: widget.shipping ? 130 : 120,
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
