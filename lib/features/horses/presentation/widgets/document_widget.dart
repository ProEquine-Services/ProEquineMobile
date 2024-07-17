import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class DocumentWidget extends StatefulWidget {
  final String? title;
  final String? category;
  final Function? onTapEdit;

  const DocumentWidget({
    super.key,
    required this.title,
    required this.category,
    required this.onTapEdit,
  });

  @override
  State<DocumentWidget> createState() => _DocumentWidgetState();
}

class _DocumentWidgetState extends State<DocumentWidget> {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  '${widget.category}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 10,
                    fontFamily: 'notosan',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: GestureDetector(
              onTap: () {
                widget.onTapEdit!();
              },
              child: const Text(
                "Edit",
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Color(0xFFC48636),
                  fontSize: 14,
                  fontFamily: 'Noto Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
