import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';

class InvoiceTileWidget extends StatefulWidget {
  final String? title;
  final String? status;
  final String? invoiceId;
  final String? date;

  const InvoiceTileWidget({
    super.key,
    required this.title,
    required this.status,
    this.invoiceId,
    this.date,
  });

  @override
  State<InvoiceTileWidget> createState() => _SupportWidgetState();
}

class _SupportWidgetState extends State<InvoiceTileWidget> {
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

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: kPadding,right: 8),
                    child: SvgPicture.asset(AppIcons.invoiceIcon),
                  ),
                  Text(
                    widget.title!,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      color: AppColors.blackLight,
                      fontSize: 20,
                      fontFamily: 'notosan',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Text(
                  widget.invoiceId!,
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: kPadding, right: 5),
                    child: SvgPicture.asset(
                      AppIcons.dateIcon,
                      height: 15,
                      color: AppColors.yellow,
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kPadding),
                child: Text('Pay Now',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColors.yellow,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
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
