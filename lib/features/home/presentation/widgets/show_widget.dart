import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../data/get_all_places_response_model.dart';

class ShowWidget extends StatefulWidget {
  final String? selectiveId;
  final String? title;
  final Place? place;
  final String? startDate;
  final String? endDate;
  final String status;
  final String? serviceType;

  const ShowWidget(
      {super.key,
        this.selectiveId,
        this.title,
        this.serviceType,
        this.place,
        this.startDate,
        this.endDate,
        required this.status});

  @override
  State<ShowWidget> createState() =>
      _ShowWidgetState();
}

class _ShowWidgetState
    extends State<ShowWidget> {
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
      final dateFormat = DateFormat("MMM d");
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
            Text(
              '${widget.title}',
              style: const TextStyle(
                  color: AppColors.blackLight,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(AppIcons.mapPin),
                const SizedBox(width: 5,),
                Text(
                  widget.place!.code!,
                  style: AppStyles.bookingContent,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.translate(
                    offset: const Offset(0.0,3.0),
                    child: SvgPicture.asset(AppIcons.dateIcon,color: AppColors.yellow,)),
                const SizedBox(width: 5,),
                Text(
                  formatStartDate(DateTime.parse(widget.startDate!)),
                  style: AppStyles.bookingContent,
                ),
                Transform.translate(
                    offset: Offset(0.0, -5),
                    child: const Text(' - ')),
                Text(
                  formatDate(DateTime.parse(widget.endDate!)),
                  style: AppStyles.bookingContent,
                ),
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
                    SizedBox(
                      width: 5,
                    ),
                    Transform.translate(
                        offset: Offset(0.0, 1.0),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.yellow,
                          size: 10,
                        ))
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
