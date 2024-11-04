import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class SelectiveServiceHomeWidget extends StatefulWidget {
  final String? bookingId;
  final String? title;
  final String? startDate;
  final String? endDate;
  final String status;
  final String? serviceType;

  const SelectiveServiceHomeWidget(
      {super.key,
      this.bookingId,
      this.title,
      this.serviceType,
      this.startDate,
      this.endDate,
      required this.status});

  @override
  State<SelectiveServiceHomeWidget> createState() =>
      _SelectiveServiceHomeWidgetState();
}

class _SelectiveServiceHomeWidgetState
    extends State<SelectiveServiceHomeWidget> {
  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) {
      // Define the date format
      final dateFormat = DateFormat("MMM d, yyyy");
      // Format the date
      final formattedDate = dateFormat.format(date);
      return formattedDate;
    }

    String formatStartDate(DateTime date) {
      // Define the date format
      final dateFormat = DateFormat("MMMM d");
      // Format the date
      final formattedDate = dateFormat.format(date);
      return formattedDate;
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
          ? const Color.fromRGBO(12, 12, 12, 1)
          : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Text(
                    '${widget.title}',
                    style: TextStyle(
                        color: AppColors.blackLight,
                        fontSize: widget.title!.length > 4 ? 12 : 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  widget.serviceType == 'Import'
                      ? AppIcons.selectiveImport
                      : widget.serviceType == 'Export'
                          ? AppIcons.selectiveExport
                          : AppIcons.selectiveTransportCar,
                  height: widget.serviceType == 'Import' ||
                          widget.serviceType == 'Export'
                      ? 30
                      : 25,
                  width: widget.serviceType == 'Import' ||
                          widget.serviceType == 'Export'
                      ? 35
                      : 30,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.serviceType!,
                  style: AppStyles.bookingContent,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Transform.translate(
                        offset: const Offset(0.0, 3.0),
                        child: SvgPicture.asset(
                          AppIcons.dateIcon,
                          color: AppColors.yellow,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      formatStartDate(DateTime.parse(widget.startDate!)),
                      style: AppStyles.bookingContent,
                    ),
                    widget.serviceType == 'Show'
                        ?   Transform.translate(
                        offset: const Offset(0.0, -5.0),
                        child:const Text(' - ')):
                         const SizedBox(),
                    widget.serviceType == 'Show'
                        ? Text(
                            formatDate(DateTime.parse(widget.endDate!)),
                            style: AppStyles.bookingContent,
                          )
                        : const SizedBox(),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          widget.status,
                          style: widget.status == 'Book Now'
                              ? const TextStyle(
                                  color: AppColors.yellow,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700)
                              : AppStyles.bookingContent,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Transform.translate(
                            offset: const Offset(0.0, 1.0),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.yellow,
                              size: 12,
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
