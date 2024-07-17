import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/features/shipping/presentation/widgets/shipping_icon_widget.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class SelectiveServiceWidget extends StatefulWidget {
  final String? selectiveId;
  final String? title;
  final String? date;
  final String status;
  final String? transportType;
  final String? from;
  final String? to;
  final int? horsesCount;

  const SelectiveServiceWidget(
      {super.key,
      this.selectiveId,
      this.title,
      this.transportType,
      this.date,
      this.from,
      this.to,
      this.horsesCount,
      required this.status});

  @override
  State<SelectiveServiceWidget> createState() => _SelectiveServiceWidgetState();
}

class _SelectiveServiceWidgetState extends State<SelectiveServiceWidget> {
  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) {
      // Define the date format
      final dateFormat = DateFormat("MMMM d, yyyy");
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(

                    widget.title!,
                    maxLines: 2,
                    style: AppStyles.mainContent
                  ),
                ),
                Text(
                  widget.selectiveId!,
                  style: AppStyles.bookingContent,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.from == 'United Arab Emirates' ||
                        widget.to == 'United Arab Emirates'
                    ?  Text(
                        'UAE',
                        style: AppStyles.mainContent,
                      )
                    : Text(
                        widget.transportType == 'Import'
                            ? widget.to??'undefined'
                            : widget.from??'Whatever',
                        style: AppStyles.mainContent,
                      ),
                const SizedBox(
                  width: 10,
                ),
                ShippingIconWidget(
                  type: widget.transportType!,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.transportType == 'Import' ? widget.from??'undefined' : widget.to??'Why',
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
            )
          ],
        ),
      ),
    );
  }
}
