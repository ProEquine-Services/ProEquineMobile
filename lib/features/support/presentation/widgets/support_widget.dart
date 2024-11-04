import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine_dev/core/constants/constants.dart';
import 'package:proequine_dev/core/constants/images/app_images.dart';
import 'package:proequine_dev/features/support/presentation/widgets/support_status_widget.dart';
import '../../../../core/constants/colors/app_colors.dart';

class SupportWidget extends StatefulWidget {
  final String? title;
  final String? status;
  final String? reference;
  final String? date;
  final String? type;

  const SupportWidget({
    super.key,
    required this.title,
    required this.status,
    required this.type,
    this.reference,
    this.date,
  });

  @override
  State<SupportWidget> createState() => _SupportWidgetState();
}

class _SupportWidgetState extends State<SupportWidget> {
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
                    fontSize: 15,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Text(
                  widget.reference!,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 12,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                  ),
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
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: kPadding, vertical: 12),
                child: Text(
                  widget.type!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 11,
                    fontFamily: 'Noto Sans',
                    fontWeight: FontWeight.w600,
                    height: 0.12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: kPadding, right: 5),
                    child: SvgPicture.asset(
                      AppIcons.dateIcon,
                      height: 18,
                    ),
                  ),
                  Text(
                    widget.date!,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 11,
                      fontFamily: 'Noto Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: SupportStatusWidget(
                  type: widget.status!,
                  title: widget.status!,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
