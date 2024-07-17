import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/features/home/domain/cubits/local_horse_cubit.dart';
import 'package:proequine/features/home/domain/repo/local_storage_repository.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../manage_account/data/verify_email_route.dart';
import '../../../transports/presentation/widgets/all_transportations_list_widget.dart';

class BookingMain extends StatefulWidget {
  const BookingMain({super.key});

  @override
  State<BookingMain> createState() => _BookingMainState();
}

class _BookingMainState extends State<BookingMain> {
  LocalHorseCubit localHorseCubit = LocalHorseCubit(
      localStorageRepository: LocalStorageRepository());

  Future<bool> checkVerificationStatus() async {
    if (AppSharedPreferences.getEmailVerified!) {
      return true;
    } else {
      await Future.delayed(
          const Duration(milliseconds: 50)); // Simulating an asynchronous call
      return false;
    }
  }

  ScrollController _scrollController = ScrollController();
  bool isScrolled = false;
  bool isLoading = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();
      checkVerificationStatus().then((verified) {
        if (!verified) {
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
    _scrollController.addListener(() {
      if (_scrollController.offset > 30) {
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
    _scrollController.dispose();
    timer.cancel();
    super.dispose();
  }

  // @override
  // void initState() {
  //   // checkVerificationStatus().then((verified) {
  //   //   if (!verified) {
  //   //     // If the account is not verified, show a dialog after a delay.
  //   //     Future.delayed(const Duration(milliseconds: 50), () {
  //   //       showUnverifiedAccountDialog(
  //   //         context: context,
  //   //         isThereNavigationBar: true,
  //   //         onPressVerify: () {
  //   //           Navigator.pushNamed(context, verifyEmail,
  //   //                   arguments: VerifyEmailRoute(
  //   //                       type: 'Booking',
  //   //                       email: AppSharedPreferences.userEmailAddress))
  //   //               .then((value) {});
  //   //         },
  //   //       );
  //   //     });
  //   //   }
  //   // });
  //
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MediaQuery(
        data: const MediaQueryData(
            viewInsets: EdgeInsets.only(top: 100, bottom: 0)),
        child: CupertinoPageScaffold(
          child: NestedScrollView(

            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                CupertinoSliverNavigationBar(
                  automaticallyImplyLeading: false,
                  border: Border(
                      bottom: BorderSide(
                          width: 1.0,
                          color: isScrolled
                              ? AppColors.borderColor
                              : Colors.transparent)),
                  alwaysShowMiddle: false,
                  padding: const EdgeInsetsDirectional.only(bottom: 1),
                  backgroundColor: AppColors.backgroundColorLight,
                  largeTitle: const Text(
                    'Transport',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
                  ),
                  middle: const Text(
                    'Transport',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
              ];
            },
            body: BlocListener<LocalHorseCubit, LocalHorseState>(
              listener: (context, state) {
                if(state is DeleteTripSuccessfully){
                  localHorseCubit.getAllTrips();
                }
              },
              child: DefaultTabController(
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
                        height: isScrolled ? 30 : 2,
                      ),
                      Theme(
                        data:
                        ThemeData().copyWith(splashColor: Colors.transparent),
                        child: Container(
                          width: 90.0.w,

                          margin: const EdgeInsets.only(bottom: 10,left: 20),
                          decoration: BoxDecoration(
                            //This is for background color
                              color: Colors.white.withOpacity(0.0),
                              //This is for bottom border that is needed
                              border: const Border(
                                  bottom: BorderSide(
                                      color: Color(0XFFDFD9C9), width: 0.8))),
                          child: const TabBar(
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
                              labelPadding: EdgeInsets.only(
                                  right: 35),
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
                          child:TabBarView(children: [
                            SingleChildScrollView(
                              child: AllTransportsWidget(
                                status: "Requested",
                              ),
                            ),

                        SingleChildScrollView(
                          child:AllTransportsWidget(
                              status: "Requested",
                            ),
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
          ),
        ),
      ),
    );
  }
}
