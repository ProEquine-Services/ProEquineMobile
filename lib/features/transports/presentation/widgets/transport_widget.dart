import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:proequine_dev/core/constants/thems/app_styles.dart';
import 'package:proequine_dev/core/widgets/status_widget.dart';
import 'package:proequine_dev/features/transports/presentation/widgets/transport_icon_widget.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class TransportWidget extends StatefulWidget {
  final String? bookingId;
  final String? date;
  final String status;
  final String? transportType;
  final String? from;
  final String? to;
  final int? horsesCount;

  const TransportWidget(
      {super.key,
      this.bookingId,
      this.transportType,
      this.date,
      this.from,
      this.to,
      this.horsesCount,
      required this.status});

  @override
  State<TransportWidget> createState() => _TransportWidgetState();
}

class _TransportWidgetState extends State<TransportWidget> {
  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) {
      final dateFormat = DateFormat("MMMM d, yyyy");
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.transportType == 'Hospital'
                      ? 'Hospital Transport'
                      : widget.transportType == 'Show'
                          ? 'Show Transport'
                          : "General Horse Transport",
                  style: AppStyles.mainContent,
                ),
                Text(
                  widget.bookingId!,
                  style: AppStyles.bookingContent,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Text(
                  "${widget.horsesCount.toString()} Horses",
                  style: AppStyles.bookingContent,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.from!,
                  style: AppStyles.mainContent,
                ),
                const SizedBox(
                  width: 10,
                ),
                const TransportIconWidget(),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.to!,
                  style: AppStyles.mainContent,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AppIcons.dateIcon,
                      color: AppColors.yellow,
                      height: 12,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      formatDate(DateTime.parse(widget.date!)),
                      style: AppStyles.bookingContent,
                    ),
                  ],
                ),
                const Spacer(),
                StatusContainer(status: widget.status),
              ],
            )
          ],
        ),
      ),
    );
  }
}
