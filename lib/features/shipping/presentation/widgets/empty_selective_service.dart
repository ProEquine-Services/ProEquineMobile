import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';

import '../screens/create_export_screen.dart';
import '../screens/create_import_screen.dart';

class EmptySelectiveServiceWidget extends StatelessWidget {
  final String type;

  const EmptySelectiveServiceWidget({Key? key, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 250,
          ),
          Center(
            child: SvgPicture.asset(type=='Show'?AppIcons.emptyTransport:AppIcons.emptyShipping),
          ),
          const SizedBox(
            height: 10,
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            child: Text(
              type == 'Import'
                  ? "There are no import service yet"
                  :type=='Export'? "There are no export service yet":"There are no shows transports service yet",
              style: const TextStyle(
                color: Color(0xFF232F39),
                fontWeight: FontWeight.w400,
                fontFamily: 'notosan',
                fontSize: 24.26,
              ),
            ),
          ),
          const SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }
}
