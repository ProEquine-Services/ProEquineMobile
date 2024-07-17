import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/events/presentation/widgets/all_events_list.dart';
import 'package:sizer/sizer.dart';
import '../../../manage_account/presentation/screens/user_profile.dart';
import '../widgets/eventitem.dart';

class EventListMain extends StatelessWidget {
  const EventListMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(23.0.h),
        child: ClipRect(
          child: BackdropFilter(
            // blendMode: BlendMode.color,
            filter: ImageFilter.blur(
              sigmaX: 30.0,
              sigmaY: 30.0,
            ),
            child: Container(
              // color: AppColors.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50, bottom: 20, left: 20, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Upcoming Events",
                      style:  TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        fontFamily: "hemiHead",
                      ),
                    ),
                    GestureDetector(
                      child: SvgPicture.asset(AppIcons.userSquare,height: 32,width: 32,),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfile(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        // child: EventList(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 65.h,
                  width: double.infinity,
                  // TODO : when getting api remove the const then put Api data
                  child: const EventItem(
                    imgUrl: AppImages.upComingEvent,
                    national: "UAE LONGINES",
                    team: 'TEAM MASTER',
                    date: '12-13 Oct',
                    location: 'EEC',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20, right: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "All Events",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: "notosan",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.0.h,
                  child: const AllEventsScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
