import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/divider.dart';
import '../../../transports/data/create_transport_response_model.dart';

class SummaryBoxWidget extends StatefulWidget {
  final TransportModel? tripServiceDataModel;

  const SummaryBoxWidget({super.key, required this.tripServiceDataModel});

  @override
  State<SummaryBoxWidget> createState() => _SummaryBoxWidgetState();
}

class _SummaryBoxWidgetState extends State<SummaryBoxWidget> {
  String returnDate() {
    if (widget.tripServiceDataModel!.type == "Other day return" &&
        widget.tripServiceDataModel!.returnTime!.isNotEmpty) {
      return "Returning: ${widget.tripServiceDataModel!.returnDate} • ${widget.tripServiceDataModel!.returnTime}";
    } else if (widget.tripServiceDataModel!.type == "Same day return" &&
        widget.tripServiceDataModel!.returnTime!.isNotEmpty) {
      return "Returning:  ${widget.tripServiceDataModel!.pickUpDate} • ${widget.tripServiceDataModel!.pickUpTime}";
    } else {
      return "";
    }
  }

  String formatDate(DateTime date) {
    // Define the date format
    final dateFormat = DateFormat("MMMM d, yyyy");
    // Format the date
    final formattedDate = dateFormat.format(date);
    return formattedDate;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.50, color: Color(0xFFDFD9C9)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 19),
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
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${formatDate(DateTime.parse(widget.tripServiceDataModel!.pickUpDate!))} • ${widget.tripServiceDataModel!.pickUpTime}",
                  style: AppStyles.summaryDesStyle,
                ),
                Text(
                  widget.tripServiceDataModel!.type!,
                  style: AppStyles.summaryDesStyle,
                ),
              ],
            ),
            const CustomDivider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pick up",
                  style: AppStyles.summaryTitleStyle,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.tripServiceDataModel!.pickPlace?.name.toString()??'',
                  style: AppStyles.summaryDesStyle,
                ),
                Text(
                  "${widget.tripServiceDataModel!.pickUpContactName} • ${widget.tripServiceDataModel!.pickUpPhoneNumber}",
                  style: AppStyles.summaryDesStyle,
                ),
              ],
            ),
            const CustomDivider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Drop off",
                  style: AppStyles.summaryTitleStyle,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.tripServiceDataModel!.dropPlace?.name.toString()??'',
                  style: AppStyles.summaryDesStyle,
                ),
                Text(
                  "${widget.tripServiceDataModel!.dropContactName} • ${widget.tripServiceDataModel!.dropPhoneNumber}",
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
                  widget.tripServiceDataModel!.numberOfHorses.toString(),
                  style: AppStyles.summaryDesStyle,
                ),
              ],
            ),
            widget.tripServiceDataModel!.notes != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomDivider(),
                      Column(
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
                            widget.tripServiceDataModel!.notes!,
                            style: AppStyles.summaryDesStyle,
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
