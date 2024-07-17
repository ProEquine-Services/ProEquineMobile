

import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/wallet/presentation/widgets/show_contact_support_bottom_sheet.dart';

import '../../../../core/constants/colors/app_colors.dart';

class ContactSupportWidget extends StatelessWidget {
  ContactSupportWidget({Key? key}) : super(key: key);

  final TextEditingController inquiry=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
       showContactSupportBottomSheet(context: context, inquiry: inquiry);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            horizontal: 15.78, vertical: 17.53),
        decoration: ShapeDecoration(
          color: AppColors.backgroundColorLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(21.04),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x1EAAAAAA),
              blurRadius: 21.04,
              offset: Offset(0, 7.01),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SvgPicture.asset(
            //   AppIcons.questionMark,
            //   height: 35,
            //   width: 35,
            // ),
            Column(
              children: [
                Text(
                  'Trouble With Your Payment?'.tra,
                  style: const TextStyle(
                    color: AppColors.blackLight,
                    fontSize: 14.02,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Let us know on help center now!'.tra,
                  style: const TextStyle(
                    color: Color(0xFF3D3D3D),
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Color(0xFF3D3D3D),
            )
          ],
        ),
      ),
    );
  }
}
