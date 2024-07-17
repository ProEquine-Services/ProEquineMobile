import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/images/app_images.dart';

class EventItem extends StatelessWidget {
  final String imgUrl;
  final String national;
  final String team;
  final String location;
  final String date;

  const EventItem(
      {super.key,
      required this.imgUrl,
      required this.national,
      required this.team,
      required this.location,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GridTile(
          footer: Container(
            height: 90,
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  color: const Color.fromRGBO(0, 0, 0, 0.8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "National / $national",
                            style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                fontFamily: 'notosan'),
                          ),
                          Text(
                            team,
                            style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                fontFamily: 'notosan'),
                          ),
                        ],
                      ),
                     const SizedBox(height: 5,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(AppIcons.location),
                              Text(
                                location,
                                style: const TextStyle(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    fontFamily: 'notosan'),
                              ),
                          ]
                          ),
                          Row(
                            children: [


                          SvgPicture.asset(AppIcons.date,color: AppColors.gold,),
                          Text(
                            date,
                            style: const TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                fontFamily: 'notosan'),
                          ),
                            ],
                          ),


                        ],
                      ),
                    ],
                  ),
                )

                // GridTileBar(
                //   title: Text(
                //     maxLines: 2,
                //     description,
                //     textAlign: TextAlign.left,
                //     style: TextStyle(fontSize: 16.sp,fontFamily: 'notosan',fontWeight: FontWeight.w400),
                //   ),
                //   backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
                //   trailing: Padding(
                //     padding: const EdgeInsets.only(right: 15.0),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Row(
                //           children: const [
                //             Icon(
                //               MyIcons.calendar_r,
                //               size: 17,
                //             ),
                //             SizedBox(
                //               width: 5,
                //             ),
                //             Text(
                //               "15 Sep 2022",
                //               style: TextStyle(fontSize: 12),
                //             ),
                //           ],
                //         ),
                //         Row(
                //           children: const [
                //             Icon(
                //               MyIcons.clock_r,
                //               size: 17,
                //             ),
                //             SizedBox(
                //               width: 5,
                //             ),
                //             Text(
                //               "04:30 PM",
                //               style: TextStyle(fontSize: 12),
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                ),
          ),
          child: GestureDetector(
            onTap: (() {}),
            // TODO : convert this image to network image when get the api
            child: Image.asset(
              imgUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
