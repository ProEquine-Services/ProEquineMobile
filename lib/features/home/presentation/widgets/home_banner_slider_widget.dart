import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/features/home/domain/cubits/home_cubit.dart';
import 'package:proequine/features/home/presentation/screens/join_show_screen.dart';
import 'package:proequine/features/home/presentation/widgets/selective_service_home_widget.dart';
import 'package:proequine/features/shipping/domain/shipping_cubit.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../manage_account/data/verify_email_route.dart';
import '../../../shipping/presentation/screens/selective_service_export_screen.dart';
import '../../../shipping/presentation/screens/selective_service_import_screen.dart';

class HomeBannerSliderWidget extends StatefulWidget {
  const HomeBannerSliderWidget({super.key});

  @override
  State<HomeBannerSliderWidget> createState() => _HomeBannerSliderWidgetState();
}

class _HomeBannerSliderWidgetState extends State<HomeBannerSliderWidget> {
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
    context
        .read<HomeCubit>()
        .getAllSelectiveServices(limit: 4, showOnHomePage: true);
    super.initState();
  }

  ShippingCubit cubit = ShippingCubit();

  int currentIndex = 0;

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocBuilder<HomeCubit, HomeState>(
        bloc: context.read<HomeCubit>(),
        builder: (context, state) {
          if (state is GetHomeSelectiveServicesSuccessfully) {
            if (state.model.isEmpty) {
              return const SizedBox();
            } else {
              return Column(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                        height: 130.0,
                        viewportFraction: 1,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        autoPlay: true,
                        reverse: false,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        }),
                    items: state.model.map((i) {
                      return GestureDetector(
                        onTap: () {
                          checkVerificationStatus().then((verified) {
                            if (!verified) {
                              // If the account is not verified, show a dialog after a delay.
                              Future.delayed(const Duration(milliseconds: 50),
                                  () {
                                showUnverifiedAccountDialog(
                                  context: context,
                                  isThereNavigationBar: true,
                                  onPressVerify: () {
                                    Navigator.pushNamed(context, verifyEmail,
                                            arguments: VerifyEmailRoute(
                                                type: 'HomeSelective',
                                                email: AppSharedPreferences
                                                    .userEmailAddress))
                                        .then((value) {});
                                  },
                                );
                              });
                            } else {
                              if (i.type == 'Show') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            JoinShowScreen(model: i)));
                              } else if (i.type == 'Import') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SelectiveServiceImportScreen(
                                                model: i)));
                              } else if (i.type == 'Export') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SelectiveServiceExportScreen(
                                                model: i)));
                              }
                            }
                          });
                        },
                        child: SelectiveServiceHomeWidget(
                          bookingId: i.selectiveCode.toString(),
                          title: i.title,
                          serviceType: i.type,
                          status: i.availableForBooking ?? true
                              ? 'Book Now'
                              : 'Closed',
                          startDate: i.startDate,
                          endDate: i.endDate,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Visibility(
                    visible: state.model.length > 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(state.model.length, (index) {
                        bool isSelected = currentIndex == index;
                        return AnimatedContainer(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: isSelected ? 5 : 5,
                          width: isSelected ? 30 : 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                isSelected ? AppColors.yellow : AppColors.grey,
                          ),
                          duration: const Duration(milliseconds: 300),
                        );
                      }),
                    ),
                  )
                ],
              );
            }
          }
          return Container();
        },
      ),
      // DotsIndicator(
      //   dotsCount: itemsList.length,
      //   position: currentIndex.toDouble(),
      // )
    ]);
  }
}
