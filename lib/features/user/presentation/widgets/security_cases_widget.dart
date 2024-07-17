import 'package:flutter/material.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';

class SecurityCasesWidget extends StatefulWidget {
  String? header;
  String? description;
  bool isValidate=false;
   SecurityCasesWidget({Key? key,this.header,this.description,this.isValidate=false}) : super(key: key);

  @override
  State<SecurityCasesWidget> createState() => _SecurityCasesWidgetState();
}

class _SecurityCasesWidgetState extends State<SecurityCasesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.header!,
          style: TextStyle(
              color: widget.isValidate?AppColors.yellow: AppColors.blackLight,
              fontSize: 16,
              fontWeight: FontWeight.w700),
        ),
        Text(
          widget.description!,
          style: TextStyle(
              color: widget.isValidate?AppColors.yellow:Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),

      ],
    );
  }
}
