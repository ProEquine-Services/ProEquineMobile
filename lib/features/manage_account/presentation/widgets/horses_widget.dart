import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';

class HorsesWidget extends StatelessWidget {
  String? imageUrl;
  String? name;
  String? property;
  bool isActive;

  HorsesWidget({super.key,this.isActive=false,this.imageUrl,this.name,this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: AppColors.formsBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name!,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'notosan',
                        color: AppColors.white),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    property!,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'notosan',
                        color: AppColors.gold),
                  ),
                ],

              )),
          const Spacer(flex: 10,),
          isActive?Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.notificationReview,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                "Active",
                style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: 'notosan'),
              ),
            ),
          ):Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFF646D74),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Text(
                "Inactive",
                style: TextStyle(
                    color: Color.fromRGBO(255, 255 ,255, 0.32),
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    fontFamily: 'notosan'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
