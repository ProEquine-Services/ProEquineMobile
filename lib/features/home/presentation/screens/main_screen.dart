import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine_dev/features/home/presentation/screens/shows_screen.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../nav_bar/domain/inbox_badge.dart';
import '../../../notifications/presentation/screens/user_notifications_screen.dart';
import '../../../shipping/domain/shipping_cubit.dart';
import '../../../shipping/presentation/screens/selective_service_screen.dart';
import '../../../transports/presentation/screens/create_trip_screen.dart';
import '../widgets/home_banner_slider_widget.dart';
import '../widgets/service_widget.dart';
import '../widgets/shipping_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();
  bool isScrolled = false;

  @override
  void initState() {
    super.initState();

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<ShippingCubit>();
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
                  trailing: BlocConsumer<ChangeBoolCubit, ChangeBoolState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      return Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const UserNotificationScreen()));
                              },
                              child: SvgPicture.asset(
                                AppIcons.notificationIcon,
                                alignment: Alignment.centerRight,
                                height: 25,
                                width: 30,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: state.thereAreNotification,
                            child: Transform.translate(
                              offset: const Offset(18, 12),
                              child: const Icon(
                                Icons.brightness_1,
                                size: 10.0,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  largeTitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: isScrolled ? kPadding : 0,
                            vertical: isScrolled ? 10 : 0),
                        child: SvgPicture.asset(
                          AppIcons.proEquineLight,
                          alignment: Alignment.centerLeft,
                          height: isScrolled ? 20 : 28,
                          width: isScrolled ? 25 : 38,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    const HomeBannerSliderWidget(),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Transportation',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ServiceWidget(
                              image: AppImages.local,
                              title: 'Local',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateTripScreen()));
                              },
                            ),
                            ServiceWidget(
                              image: AppImages.hospital,
                              title: 'Hospital',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CreateTripScreen(
                                              type: 'hospital',
                                            )));
                              },
                            ),
                            // const EventComingSoon(),
                            ServiceWidget(
                              image: AppImages.shows,
                              isItDisable: false,
                              title: 'Shows',
                              onTap: () {
                                myCubit.getAllSelectiveServices(
                                    limit: 100, type: 'Show');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ShowsServicesScreen()));
                              },
                            ),
                          ],
                        )),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 10),
                      child: Text(
                        'Shipping',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShippingWidget(
                          image: AppImages.export,
                          title: 'Import',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectiveServicesScreen(
                                            type: "Import")));
                          },
                        ),
                        ShippingWidget(
                          image: AppImages.import,
                          title: 'Export',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectiveServicesScreen(
                                            type: "Export")));
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
