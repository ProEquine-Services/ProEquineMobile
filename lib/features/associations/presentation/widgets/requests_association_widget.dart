import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/features/horses/presentation/widgets/horse_card_status_widget.dart';
import '../../../../core/constants/colors/app_colors.dart';

class RequestAssociateWidget extends StatefulWidget {
  final String? title;
  final String? status;
  final String? role;

  const RequestAssociateWidget({
    super.key,
    required this.title,
    required this.status,
    required this.role,
  });

  @override
  State<RequestAssociateWidget> createState() => _RequestAssociateWidgetState();
}

class _RequestAssociateWidgetState extends State<RequestAssociateWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 0.8, color: Color(0xFFDFD9C9)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Text(
                  widget.title!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: AppColors.blackLight,
                    fontSize: 14,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: HorseCardStatusWidget(
                  type: widget.status!,
                  title: widget.status!,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPadding, vertical: 12),
                child: Text(
                  widget.role!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: AppColors.blackLight,
                    fontSize: 14,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: kPadding, vertical: 12),
                child: Text(
                  'View details',
                  style: TextStyle(
                    color: Color(0xFFC48636),
                    fontSize: 12,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
