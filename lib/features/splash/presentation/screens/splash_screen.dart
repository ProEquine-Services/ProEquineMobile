import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
import 'package:proequine/features/notifications/domain/notifications_cubit.dart';
import 'package:proequine/features/splash/domain/splash_cubit.dart';
import 'package:proequine/features/stables/presentation/screens/choose_stable_screen.dart';
import 'package:proequine/features/user/presentation/screens/create_user_name_screen.dart';
import 'package:proequine/features/user/presentation/screens/verification_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/utils/printer.dart';
import '../../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../../notifications/data/saved_notification_data.dart';
import '../../../user/presentation/screens/interests_screen.dart';
import '../../../user/presentation/screens/login_screen.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../widgets/update_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  final String _appUrl = Platform.isAndroid
      ? 'https://play.google.com/store/apps/details?id=com.findyourteam.mobile'
      : 'https://apps.apple.com/ae/app/proequine/id6502438400';
  String version = '';
  String buildVersion = '';
  String packageName = '';

  void updateApp() async {
    if (!await launchUrl(Uri.parse(_appUrl),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_appUrl';
    }
  }

  SplashCubit splashCubit = SplashCubit();
  ManageAccountCubit cubit = ManageAccountCubit();
  NotificationsCubit notificationsCubit = NotificationsCubit();

  getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = 'version: ${packageInfo.version}';
    buildVersion = "${packageInfo.version}.${packageInfo.buildNumber}";
    packageName = packageInfo.packageName;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');

    Print('version: ${packageInfo.version}');
    Print('build Version: ${packageInfo.buildNumber}');
    Print('build Version with build number: $buildVersion');
    Print('name: ${packageInfo.packageName}');
  }

  Future<void> navigateUser() async {
    Print("Token is ${await SecureStorage().getToken()}");

    Print(
        "saved data from notification ${SavedNotificationData.notificationData}");
    if (SavedNotificationData.notificationData != null) {
      Print("render from splash screen");
    } else {
      if (await SecureStorage().getToken() != null) {
        if (AppSharedPreferences.getPhoneVerified!) {
          Print("get phone verified");
          if (AppSharedPreferences.isHasUserName ?? false) {
            Print("get has user Name");
            if (AppSharedPreferences.getIsITypeSelected!) {
              if (AppSharedPreferences.isStableChosen!) {
                if (context.mounted) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavigation()));
                }
              } else {
                if (context.mounted) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChoseStableScreen()));
                }
              }
            } else {
              if (context.mounted) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InterestsScreen()));
              }
            }
          } else {
            if (context.mounted) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateUserNameScreen()));
            }
          }
        } else {
          if (context.mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const VerificationScreen()));
          }
        }
      } else {
        /// edited from login to testPage
        if (context.mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      }
    }
  }

  Future<void> startTimer() async {
    Print("start timer");
    Timer(const Duration(seconds: 2), () async {
      await navigateUser();
    });
  }

  String? refreshToken = '';
  String? userId = '';

  sendRefreshToken() async {
    final token = await SecureStorage().getToken();
    // Print("Refresh token ${refreshToken}");
    // Print("access token ${token}");
    if ((refreshToken != null && token != null) ||
        (refreshToken != '' && token != '')) {
      refreshToken = await SecureStorage().getRefreshToken();
      userId = await SecureStorage().getUserId();
      Print("Token Refreshed");
      splashCubit.refreshToken(refreshToken ?? '');
    } else {
      Print("Token not Refreshed");
    }
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          checkConfigurationAndShowDialog();
        }
      });

    getVersion();
    cubit.getConfiguration();

    sendRefreshToken();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    sendRefreshToken();
    super.dispose();
  }

  void checkConfigurationAndShowDialog() {
    if (cubit.state is GetConfigurationSuccessfully) {
      final state = cubit.state as GetConfigurationSuccessfully;
      if (Platform.isAndroid) {
        if (state.responseModel!.androidBuildNumber != buildVersion) {
          showUpdateDialog(state.responseModel!.updateIsImportant!);
        } else {
          startTimer();
        }
      } else if (Platform.isIOS) {
        if (state.responseModel!.iosBuildNumber! != buildVersion) {
          showUpdateDialog(state.responseModel!.updateIsImportant!);
        } else {
          startTimer();
        }
      }
    }
  }

  void showUpdateDialog(bool isImportant) {
    UpdateAwsomeDialog.updateDialog(
        context: context,
        onTapUpdate: () {
          // on Update
          updateApp();
        },
        onTapIgnore: () async {
          // on Ignore or close depending on updateIsImportant state
          isImportant ? exit(0) : await startTimer();
        },
        isImportant: isImportant);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ManageAccountCubit, ManageAccountState>(
        bloc: cubit,
        listener: (context, state) {
          // No need to handle dialog here
        },
        builder: (context, state) {
          if (state is GetConfigurationSuccessfully) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0.w,
                    ),
                    child: Lottie.asset(
                      'assets/animation/splash.json',
                      controller: _controller,
                      onLoaded: (composition) {
                        _controller
                          ..duration = composition.duration
                          ..forward();
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (state is GetConfigurationLoading) {
            // return Center(child: CircularProgressIndicator());
          }
          return Container();
        },
      ),
    );
  }
}
