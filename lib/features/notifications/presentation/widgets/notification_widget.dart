import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class NotificationWidget extends StatelessWidget {
  final String? type;
  final String? title;
  final String? content;
  final String? date;

  const NotificationWidget({
    super.key,
    this.type,
    this.title,
    this.content,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    String formatDateDifference(DateTime dateTime) {
      Duration difference = DateTime.now().difference(dateTime);

      if (difference.inDays > 1) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays == 1) {
        return '${difference.inDays} day ago';
      } else if (difference.inHours > 1) {
        return '${difference.inHours} hours ago';
      } else if (difference.inHours == 1) {
        return '${difference.inHours} hour ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} min ago';
      } else {
        return 'just now';
      }
    }

    String returnedIcon() {
      if (type == 'HorseDocumentsApproval' ||
          type == 'HorseAssociation' ||
          type == 'SupportRequestAvailable' ||
          type == 'ShippingJobActive' ||
          type == 'TransportJobActive') {
        return AppIcons.infoNotification;
      } else if (type == 'HorseDocumentsRejection' ||
          type == 'HorseAssociationReject' ||
          type == 'ServiceRequestRejection' ||
          type == 'ShippingJobRejected' ||
          type == 'TransportJobRejected') {
        return AppIcons.errorNotification;
      }
      return AppIcons.checkNotification;
    }

    DateTime dateTime = DateTime.parse(date!);
    String formattedDate = formatDateDifference(dateTime);
    return Card(
      margin: EdgeInsets.zero,
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
                SvgPicture.asset(returnedIcon()),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.backgroundColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  formattedDate,
                  style: AppStyles.bookingContent,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: 14,
                  width: 14,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Text(
                    content!,
                    style: AppStyles.bookingContent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
