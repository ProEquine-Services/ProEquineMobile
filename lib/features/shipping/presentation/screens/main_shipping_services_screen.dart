import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/features/home/domain/cubits/local_horse_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../manage_account/data/verify_email_route.dart';
import '../widgets/shipping_list_widget.dart';

class MainShippingRequestsScreen extends StatefulWidget {
  const MainShippingRequestsScreen({super.key});

  @override
  State<MainShippingRequestsScreen> createState() =>
      _MainShippingRequestsScreenState();
}

class _MainShippingRequestsScreenState
    extends State<MainShippingRequestsScreen> {
  Future<bool> checkVerificationStatus() async {
    if (AppSharedPreferences.getEmailVerified!) {
      return true;
    } else {
      await Future.delayed(
          const Duration(milliseconds: 50)); // Simulating an asynchronous call
      return false;
    }
  }

  ScrollController scrollController = ScrollController();
  bool isScrolled = false;
  bool isLoading = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    checkVerificationStatus().then((verified) {
      if (verified) {
        // If the account is not verified, show a dialog after a delay.
        Future.delayed(const Duration(milliseconds: 50), () {
          showUnverifiedAccountDialog(
            context: context,
            isThereNavigationBar: true,
            onPressVerify: () {
              Navigator.pushNamed(context, verifyEmail,
                      arguments: VerifyEmailRoute(
                          type: 'Booking',
                          email: AppSharedPreferences.userEmailAddress))
                  .then((value) {});
            },
          );
        });
      }
    });
    scrollController.addListener(() {
      if (scrollController.offset > 30) {
        if (!isScrolled) {
          setState(() {
            isScrolled = true;
          });
        }
      } else {
        if (isScrolled) {
          setState(() {
            isScrolled = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(10.0.h),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 11.0.h,
                ),
                const Text(
                  "Shipping",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                ),
              ],
            ),
          )),
      body: BlocListener<LocalHorseCubit, LocalHorseState>(
        listener: (context, state) {
          if (state is DeleteTripSuccessfully) {
            // localHorseCubit.getAllTrips();
          }
        },
        child: DefaultTabController(
          length: 2,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: isScrolled ? 50 : 2,
                ),
                Theme(
                  data: ThemeData().copyWith(splashColor: Colors.transparent),
                  child: Container(
                    width: 90.0.w,
                    margin: const EdgeInsets.only(bottom: 10, left: 16),
                    decoration: BoxDecoration(
                        //This is for background color
                        color: Colors.white.withOpacity(0.0),
                        //This is for bottom border that is needed
                        border: const Border(
                            bottom: BorderSide(
                                color: Color(0XFFDFD9C9), width: 0.8))),
                    child: const TabBar(
                        tabAlignment: TabAlignment.start,

                        labelColor: AppColors.blackLight,
                        indicatorColor: Colors.yellow,
                        labelStyle: TextStyle(
                          color: AppColors.blackLight,
                          fontSize: 18,
                          fontFamily: 'notosan',
                          fontWeight: FontWeight.w500,
                        ),
                        unselectedLabelColor: AppColors.blackLight,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                          color: AppColors.yellow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        indicatorPadding: EdgeInsets.only(top: 47),
                        indicatorWeight: 4,
                        isScrollable: true,
                        labelPadding: EdgeInsets.only(right: 30),
                        tabs: [
                          Tab(
                            text: "Requested",
                          ),
                          Tab(
                            text: "Completed",
                          ),
                        ]),
                  ),
                ),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: kPadding),
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),

                      children: [
                        ShippingListWidget(
                          status: "Requested",
                        ),
                        ShippingListWidget(
                          status: "Completed",
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
      //TODO: CHANGE HERE IF THE BOOKINGS IS EMPTY
      //     body: const SafeArea(
      //     child: Padding(
      //     padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 50),
      // child: NoBooking()
    );
  }
}
