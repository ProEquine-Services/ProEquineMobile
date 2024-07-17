import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/Printer.dart';
import 'package:proequine/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine/core/widgets/custom_error_widget.dart';
import 'package:proequine/features/horses/domain/horse_cubit.dart';
import 'package:proequine/features/horses/presentation/screens/add_horse_screen.dart';
import 'package:proequine/features/horses/presentation/screens/horse_profile_screen.dart';
import 'package:proequine/features/horses/presentation/widgets/empty_horses_widget.dart';
import 'package:proequine/features/horses/presentation/widgets/horse_card-widget.dart';
import 'package:proequine/features/horses/presentation/widgets/main_horses_loading_widget.dart';
import 'package:proequine/features/splash/domain/splash_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../manage_account/data/verify_email_route.dart';
import '../widgets/associated_horses_widget.dart';

class MainHorsesScreen extends StatefulWidget {
  final int? selectedSection;

  const MainHorsesScreen({Key? key, this.selectedSection}) : super(key: key);

  @override
  State<MainHorsesScreen> createState() => _MainHorsesScreenState();
}

class _MainHorsesScreenState extends State<MainHorsesScreen> {
  ScrollController scrollController = ScrollController();
  bool isScrolled = false;
  Future<bool> checkVerificationStatus() async {
    if (AppSharedPreferences.getEmailVerified!) {
      return true;
    } else {
      await Future.delayed(
          const Duration(milliseconds: 50)); // Simulating an asynchronous call
      return false;
    }
  }

  @override
  void initState() {
    Print(AppSharedPreferences.getEmailVerified);
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
                      type: 'Horses',
                      email: AppSharedPreferences.userEmailAddress))
                  .then((value) {});
            },
          );
        });
      }
    });
    context.read<HorseCubit>().getAllHorses(limit: 100);
    super.initState();
    // Set a timer for 3 seconds
    scrollController.addListener(() {
      setState(() {
        if (scrollController.offset > 30) {
          isScrolled = true;
        } else {
          isScrolled = false;
        }
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  HorseCubit cubit = HorseCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(10.0.h),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.5.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        String? userId = await SecureStorage().getUserId();
                        if (context.mounted) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddHorseScreen(
                                        userId: int.parse(userId!),
                                      )));
                        }
                      },
                      child: const Text(
                        "Add Horse",
                        style: TextStyle(
                          color: Color(0xFFC48636),
                          fontSize: 15,
                          fontFamily: 'notosans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Horses",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 28),
                ),
              ],
            ),
          )),
      body: DefaultTabController(
        initialIndex: widget.selectedSection ?? 0,
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
                      labelColor: AppColors.blackLight,
                      tabAlignment: TabAlignment.start,
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
                          text: "My Horses",
                        ),
                        Tab(
                          text: "Associated Horses",
                        ),
                      ]),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        child: BlocBuilder<HorseCubit, HorseState>(
                          // bloc: cubit,
                          builder: (context, state) {
                            if (state is GetHorsesSuccessfully) {
                              if (state.horses.isEmpty) {
                                return SizedBox(
                                    height: 100.0.h,
                                    width: 200,
                                    child: EmptyHorsesWidget(associatedIcon: false,));
                              } else {
                                return Column(
                                  children: [
                                    GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 8,
                                          crossAxisSpacing: 15,
                                          childAspectRatio: 0.92,

                                          crossAxisCount:
                                              2, // Adjust the number of columns
                                        ),
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: state.horses.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(

                                                vertical: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HorseProfileScreen(
                                                              response:
                                                                  state.horses[
                                                                      index],
                                                            )));
                                              },
                                              child: HorseCardWidget(
                                                age: state
                                                    .horses[index].dateOfBirth
                                                    .toString(),
                                                gender:
                                                    state.horses[index].gender!,
                                                breed:
                                                    state.horses[index].breed!,
                                                horseName:
                                                    state.horses[index].name!,
                                                discipline: state.horses[index]
                                                    .discipline!.title!,
                                                horsePic:
                                                    state.horses[index].image ??
                                                        '',
                                                isVerified: state
                                                    .horses[index].isVerified!,
                                                horseStable: state.horses[index]
                                                    .stable?.name??'',
                                                horseStatus: state
                                                        .horses[index].status ??
                                                    '',
                                              ),
                                            ),
                                          );
                                        }),
                                    const SizedBox(
                                      height: 80,
                                    ),
                                  ],
                                );
                              }
                            }
                            if (state is GetHorsesError) {
                              return CustomErrorWidget(onRetry: () async {
                                String? refreshToken =
                                    await SecureStorage().getRefreshToken();
                                context
                                    .read<SplashCubit>()
                                    .refreshToken(refreshToken!);
                                cubit.getAllHorses(limit: 1000);
                              });
                            } else if (state is GetHorsesLoading) {
                              return const MainHorsesLoadingWidget();
                            }
                            return Container();
                          },
                        ),
                      ),
                      const AssociatedHorsesWidget(),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
