import 'package:flutter/material.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

class BankTransferWidget extends StatefulWidget {
  final String? status;
  final String? type;
  final String? amount;
  final String? referenceNumber;
  final String? date;

  const BankTransferWidget({
    super.key,
    required this.status,
    required this.type,
    required this.referenceNumber,
    required this.amount,
    this.date,
  });

  @override
  State<BankTransferWidget> createState() => _BankTransferWidgetState();
}

class _BankTransferWidgetState extends State<BankTransferWidget> {
  @override
  Widget build(BuildContext context) {
    int returnedColor() {
      if (widget.status == 'Confirmed') {
        return 0xFF007AFF;
      } else if (widget.status == 'Pending') {
        return 0xFFF8F3E6;
      }
      // return 0xFF1E90FF;
      return 0xFFB8DCFF;
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
                  'AED ${widget.amount!}',
                  style: const TextStyle(
                    fontSize: 14,
                    color:
                     Color(0xFF232F39),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.referenceNumber!,
                  style: const TextStyle(
                    fontSize: 14,
                    color:
                    Color(0xFF6B7280),
                    fontWeight: FontWeight.w500,
                  ),
                ),

              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Container(

                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color(returnedColor()),
                    borderRadius: BorderRadius.circular(20),

                  ),
                  child: Center(
                    child: Text(widget.status!, style: TextStyle(
                        color: widget.status == 'Pending'
                            ? AppColors.disciplineText
                            : const Color(0xFF1E90FF),
                      fontFamily: 'notosan',
                      fontWeight: FontWeight.w500,
                      fontSize: 12
                    ),),
                  ),
                ),
                const SizedBox(width: 50,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.date!,
                  style: AppStyles.bookingContent,
                ),
                InkWell(
                    onTap: () {},
                    child: const Text(
                      'View details',
                      style: TextStyle(
                        color: Color(0xFFC48636),
                        fontSize: 12,
                        fontFamily: 'notosan',
                        fontWeight: FontWeight.w700,
                        height: 0.10,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
