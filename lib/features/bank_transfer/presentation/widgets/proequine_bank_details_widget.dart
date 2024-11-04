import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/divider.dart';

class ProEquineBankDetailsWidget extends StatefulWidget {
  const ProEquineBankDetailsWidget({super.key});

  @override
  State<ProEquineBankDetailsWidget> createState() =>
      _ProEquineBankDetailsWidgetState();
}

class _ProEquineBankDetailsWidgetState
    extends State<ProEquineBankDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.borderColor,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kPadding, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bank Name",
                    style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'notosan'),
                  ),

                  Row(
                    children: [
                      const Text(
                        "PRO EQUINE SERVICES LLC",
                        style: TextStyle(
                            color: Color(0xFF232F39),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'notosan'),
                      ),
                      const SizedBox(width: 10,),
                      InkWell(
                          onTap: () async {
                            await Clipboard.setData(const ClipboardData(
                                text: "PRO EQUINE SERVICES LLC"));

                            // copied successfully
                            RebiMessage.success(
                                msg: "copied successfully", context: context);
                          },
                          child: SvgPicture.asset(AppIcons.copyIcon)),
                    ],
                  ),

                ],
              ),
              const Padding(
                  padding: EdgeInsets.all(2.0), child: CustomDivider()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Swift Code",
                    style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'notosan'),
                  ),
                  Row(
                    children: [
                      const Text(
                        "NBSHAEAS",
                        style: TextStyle(
                            color: Color(0xFF232F39),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'notosan'),
                      ),
                      const SizedBox(width: 10,),
                      InkWell(
                          onTap: () async {
                            await Clipboard.setData(
                                const ClipboardData(text: "NBSHAEAS"));

                            // copied successfully
                            RebiMessage.success(
                                msg: "copied successfully", context: context);
                          },
                          child: SvgPicture.asset(AppIcons.copyIcon)),
                    ],
                  ),

                ],
              ),
              const Padding(
                  padding: EdgeInsets.all(2.0), child: CustomDivider()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Iban",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'notosan'),
                  ),
                  Row(
                    children: [
                       const Text(
                        "AE950410000012092456001",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Color(0xFF232F39),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'notosan'),
                      ),
                      const SizedBox(width: 10,),
                      InkWell(
                          onTap: () async {
                            await Clipboard.setData(const ClipboardData(
                                text: "AE950410000012092456001"));

                            // copied successfully
                            RebiMessage.success(
                                msg: "copied successfully", context: context);
                          },
                          child: SvgPicture.asset(AppIcons.copyIcon)),
                    ],
                  ),

                ],
              ),
              // const SizedBox(
              //   height: 15,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
