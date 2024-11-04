import 'package:flutter/material.dart';

import '../constants/colors/app_colors.dart';

class StatusContainer extends StatefulWidget {
  final String status;

  StatusContainer({required this.status});

  @override
  State<StatusContainer> createState() => _StatusContainerState();
}

class _StatusContainerState extends State<StatusContainer> {
  Color? textColor;
  Color? containerColor;
  @override
  Widget build(BuildContext context) {

    switch (widget.status.toLowerCase()) {
      case 'rejected':
        setState(() {
          textColor = AppColors.red;
          containerColor = AppColors.errorToast;
        });

        break;
      case 'pending':
        setState(() {
          textColor = AppColors.disciplineText;
          containerColor = AppColors.disciplineBackground;
        });

        break;
      case 'confirmed':
        textColor = AppColors.greenLight;
        containerColor = AppColors.successToast;
        break;
      case 'waiting for payment':
        textColor = AppColors.inProgressTitle;
        containerColor = AppColors.inProgressBackground;
        break;
      case 'in progress':
        textColor = AppColors.inProgressTitle;
        containerColor = AppColors.inProgressBackground;
        break;
      case 'completed':
        textColor = AppColors.greenLight;
        containerColor = AppColors.successToast;
        break;
      case 'draft':
        textColor = AppColors.grey;
        containerColor = Colors.grey[300]!;
        break;
      default:
        textColor = Colors.black;
        containerColor = Colors.grey[200]!;
        break;
    }


    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        widget.status,
        style: TextStyle(

          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}