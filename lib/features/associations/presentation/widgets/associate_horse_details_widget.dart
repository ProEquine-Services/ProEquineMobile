import 'package:flutter/material.dart';

class AssociateHorseDetailsWidget extends StatefulWidget {
  final String title;
  final String value;

  const AssociateHorseDetailsWidget(
      {super.key, required this.title, required this.value});

  @override
  State<AssociateHorseDetailsWidget> createState() =>
      _AssociateHorseDetailsWidgetState();
}

class _AssociateHorseDetailsWidgetState
    extends State<AssociateHorseDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: widget.title == 'Horse Name' ||
                    widget.title == 'Associated Role'
                ? const Color(0xFF232F39)
                : const Color(0xFF6B7280),
            fontSize: 14,
            fontFamily: 'notosan',
            fontWeight: widget.title == 'Horse Name' ||
                    widget.title == 'Associated Role'
                ? FontWeight.w600
                : FontWeight.w400,
          ),
        ),
        Text(
          widget.value,
          style: TextStyle(
            color: widget.title == 'Horse Name' ||
                    widget.title == 'Associated Role'
                ? const Color(0xFFC48636)
                : const Color(0xFF232F39),
            fontSize: widget.title == 'Horse Name' ||
                    widget.title == 'Associated Role'
                ? 18
                : 14,
            fontFamily: 'notosan',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
