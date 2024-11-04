import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';

class HistoryWidget extends StatelessWidget {
  final String? statusImg;
  final String? transport;
  final String? refNumber;
  final String? title;
  final String? horsesCount;

  const HistoryWidget({
    super.key,
    this.title,
    this.refNumber,
    this.statusImg,
    this.transport,
    this.horsesCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Row(
              children: [
                SvgPicture.asset(statusImg!),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  title!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 14,
                      fontFamily: 'notosan',
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(
                  flex: 1,
                ),
                Text(
                  refNumber!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: AppColors.grey,
                      fontSize: 14,
                      fontFamily: 'notosan',
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Row(children: [
              Expanded(
                flex: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.greyTransportIcon,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            transport!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: AppColors.grey,
                                fontSize: 12,
                                fontFamily: 'notosan',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppIcons.horse,
                          color: AppColors.grey,
                          height: 14,
                          width: 14,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          horsesCount!,
                          style: const TextStyle(
                              color: AppColors.grey,
                              fontSize: 12,
                              fontFamily: 'notosan',
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
