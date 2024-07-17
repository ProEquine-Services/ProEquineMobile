import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine/core/utils/extensions.dart';

import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class TransactionWidget extends StatefulWidget {
  final String description;
  final int type;
  final num amount;
  final String date;

  const TransactionWidget(
      {Key? key,
      required this.description,
      required this.type,
      required this.amount,
      required this.date})
      : super(key: key);

  @override
  State<TransactionWidget> createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  String formatDateString(String inputDateString) {
    // Parse the input date string
    DateTime dateTime = DateTime.parse(inputDateString).toLocal();

    // Format the date to "dd MMM"
    String formattedDate =
        DateFormat('dd MMM', AppSharedPreferences.lang).format(
      dateTime,
    );

    // Format the time to "h:mm a"
    String formattedTime =
        DateFormat('h:mm a', AppSharedPreferences.lang).format(
      dateTime,
    );

    // Combine the formatted date and time
    String result = '$formattedDate - $formattedTime';

    return result;
  }

  String formatValue(int type, num value) {
    if (type == 0) {
      return '+ $value';
    } else if (type == 1) {
      return '- $value';
    } else {
      // Handle other types if needed
      return 'Invalid type';
    }
  }

  @override
  void initState() {
    initializeDateFormatting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.description.tra,
              style: const TextStyle(
                color: Color(0xFF232F39),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              formatDateString(widget.date),
              style: const TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.0,
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            formatValue(widget.type, widget.amount),
            style: TextStyle(
              color: widget.type == 1
                  ? const Color(0xFFC62929)
                  : const Color(0xFF00A250),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }
}
