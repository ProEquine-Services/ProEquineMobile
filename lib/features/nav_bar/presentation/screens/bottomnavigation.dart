import 'package:blur_bottom_bar/blur_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:proequine/core/constants/images/app_images.dart';
import 'package:proequine/features/horses/presentation/screens/main_horses_screen.dart';
import 'package:proequine/features/nav_bar/domain/inbox_badge.dart';
import 'package:proequine/features/nav_bar/domain/navbar_cubit.dart';
import 'package:proequine/features/nav_bar/domain/theme_cubit.dart';
import 'package:proequine/features/manage_account/presentation/screens/user_profile.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../home/presentation/screens/main_screen.dart';
import '../../../shipping/presentation/screens/main_shipping_services_screen.dart';
import '../../../transports/presentation/screens/main_transportation_screen.dart';

class BottomNavigation extends StatefulWidget {
  final int? selectedIndex;
  final int? selectedSection;

  const BottomNavigation({super.key, this.selectedIndex, this.selectedSection});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int _selectedIndex;
  int? selectedSection = 0;

  late List<Widget> _widgetOptions;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ThemeCubit themeCubit = ThemeCubit();

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex ?? 0;
    selectedSection = widget.selectedSection ?? 0;
    _widgetOptions = <Widget>[
      const MainScreen(),
      const MainTransportationScreen(),
      const MainShippingRequestsScreen(),
      MainHorsesScreen(selectedSection: selectedSection),
      const UserProfile(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () =>
            BlocProvider.of<NavbarCubit>(context).onWillPop(context),
        child: BlocConsumer<ChangeBoolCubit, ChangeBoolState>(
          listener: (context, state) {
            // context.watch<ThemeCubit>().getSavedThemeMode();
          },
          builder: (context, state) {
            return Stack(
              children: <Widget>[
                _widgetOptions.elementAt(_selectedIndex),
                BlurBottomView(
                    backgroundColor:
                        AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                            ? AppColors.backgroundColor
                            : AppColors.navigatorBar,
                    filterX: 21,
                    filterY: 21,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    selectedItemColor: AppColors.yellow,
                    unselectedItemColor: AppColors.grey,
                    opacity: 0.85,
                    bottomNavigationBarItems: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: SvgPicture.asset(
                          _selectedIndex == 0
                              ? AppIcons.selectedBookingIcon
                              : AppIcons.unSelectedBookingIcon,
                          color: _selectedIndex == 0
                              ? AppColors.yellow
                              : const Color(0xFF8B9299),
                          height: 22,
                        ),
                        label: 'Services',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: SvgPicture.asset(
                          _selectedIndex == 1
                              ? AppIcons.selectedBookingNavbar
                              : AppIcons.selectiveTransportCar,
                          height: 20,
                        ),
                        label: 'Transport',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: SvgPicture.asset(
                          AppIcons.shippingNavbar,
                          color: _selectedIndex == 2
                              ? AppColors.yellow
                              : AppColors.grey,
                        ),
                        label: 'Shipping',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: AppColors.gold,
                        icon: Stack(
                          children: [
                            SvgPicture.asset(
                              _selectedIndex == 3
                                  ? AppIcons.selectedHorses
                                  : AppIcons.unSelectedHorses,
                            ),
                          ],
                        ),
                        label: 'Horses',
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: SvgPicture.asset(
                          _selectedIndex == 4
                              ? AppIcons.selectedProfile
                              : AppIcons.unSelectedProfile,
                        ),
                        label: 'Profile',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    onIndexChange: (val) {
                      if (_selectedIndex == 3) {
                        // BlocProvider.of<ChangeBoolCubit>(context)
                        //     .changeStatusToFalse();
                      }

                      _onItemTapped(val);
                    }),
              ],
            );
          },
        ),
      ),
    );
  }
}
