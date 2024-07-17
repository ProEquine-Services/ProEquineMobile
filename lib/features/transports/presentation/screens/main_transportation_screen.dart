import 'dart:async';

import 'package:flutter/material.dart';
import 'package:proequine/features/home/domain/cubits/local_horse_cubit.dart';
import 'package:proequine/features/home/domain/repo/local_storage_repository.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../manage_account/data/verify_email_route.dart';
import '../widgets/all_transportations_list_widget.dart';

class MainTransportationScreen extends StatefulWidget {
  const MainTransportationScreen({super.key});

  @override
  State<MainTransportationScreen> createState() =>
      _MainTransportationScreenState();
}

class _MainTransportationScreenState extends State<MainTransportationScreen> {
  LocalHorseCubit localHorseCubit =
      LocalHorseCubit(localStorageRepository: LocalStorageRepository());

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
  // TabController controller=TabController(length: 2, vsync: this,);
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
    timer = Timer(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
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
                  "Transportation",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                ),
              ],
            ),
          )),
      body: DefaultTabController(
        length: 2,
        child:
            // body:Padding(
            //     padding:
            //         EdgeInsets.only(left: kPadding, right: kPadding, bottom: 20),
            //     child: Booking(),
            //   ),
            Column(
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
                      physics: NeverScrollableScrollPhysics(),
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
                      AllTransportsWidget(
                        status: "Requested",
                      ),
                      AllTransportsWidget(
                        status: "Completed",
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
