import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/widgets/status_widget.dart';
import 'package:proequine/features/shipping/presentation/widgets/shipping_icon_widget.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class ShippingWidgetItem extends StatefulWidget {
  final String? bookingId;
  final String? date;
  final String status;
  final String? transportType;
  final String? from;
  final String? to;
  final int? horsesCount;

  const ShippingWidgetItem(
      {super.key,
      this.bookingId,
      this.transportType,
      this.date,
      this.from,
      this.to,
      this.horsesCount,
      required this.status});

  @override
  State<ShippingWidgetItem> createState() => _ShippingWidgetItemState();
}

class _ShippingWidgetItemState extends State<ShippingWidgetItem> {
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
                  widget.transportType == 'Export'
                      ? 'Export'
                      : "Import",
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
                  widget.transportType == 'Import' ? widget.to! : widget.from!,
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
                  widget.transportType == 'Import' ? widget.from! : widget.to!,
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
