import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/app_settings.dart';

import 'package:proequine_dev/core/constants/colors/app_colors.dart';
import 'package:proequine_dev/core/constants/constants.dart';
import 'package:proequine_dev/core/constants/thems/app_styles.dart';
import 'package:proequine_dev/core/utils/Printer.dart';
import 'package:proequine_dev/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine_dev/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine_dev/core/widgets/custom_popup_widget.dart';
import 'package:proequine_dev/core/widgets/rebi_button.dart';
import 'package:proequine_dev/features/invoices/presentation/screens/user_invoices_screen.dart';
import 'package:proequine_dev/features/manage_account/domain/manage_account_cubit.dart';
import 'package:proequine_dev/features/manage_account/presentation/screens/manage_account_screen.dart';
import 'package:proequine_dev/features/splash/presentation/screens/splash_screen.dart';
import 'package:proequine_dev/features/wallet/presentation/screens/main_wallet_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../associations/presentation/screens/horse_invites_association_screen.dart';
import '../../../equine_info/presentation/screens/chose_discilpine_update_screen.dart';
import '../../../equine_info/presentation/screens/chose_stable_update_screen.dart';
import '../../../support/presentation/screens/all_support_requests_screen.dart';
import '../../../support/presentation/screens/legal.dart';
import '../../../support/presentation/screens/social_media_screen.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';
import '../../../wallet/domain/wallet_cubit.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  ManageAccountCubit cubit = ManageAccountCubit();
  String? email;

  @override
  void initState() {
    cubit.getUser();
    BlocProvider.of<WalletCubit>(context).getWallet();
    super.initState();
  }
  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final themeCubit = ThemeCubitProvider.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 11.h,
            ),
            Text(
              'Hi, ${AppSharedPreferences.getName}',
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 29),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                "Account Information",
                style: AppStyles.profileTitles,
                textAlign: TextAlign.start,
              ),
            ),
            ProfileListTileWidget(
              title: "Manage Account",
              onTap: () async {
                String? userId = await SecureStorage().getUserId();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ManageAccountScreen(userId: int.parse(userId!))));
                Print(email);
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "Equine Interests",
              onTap: () async {
                String? userId = await SecureStorage().getUserId();
                if (context.mounted) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChooseDisciplineScreen(
                                userId: int.parse(userId!),
                              )));
                }
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "Stables",
              onTap: () async {
                String? userId = await SecureStorage().getUserId();
                if (context.mounted) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ChooseUpdateStableScreen(
                                  userId: int.parse(userId!))));
                }
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "Horse Association Invite",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const HorseRequestAssociationScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "Wallet",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainWalletScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "Unpaid Invoices",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserInvoicesScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: Text(
                "More About ProEquine",
                style: AppStyles.profileTitles,
                textAlign: TextAlign.start,
              ),
            ),
            ProfileListTileWidget(
              title: "Support",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const AllSupportRequestsScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "Legal",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LegalScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            ProfileListTileWidget(
              title: "We're on social media",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SocialMediaScreen()));
              },
              notificationList: false,
              isThereNewNotification: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: GestureDetector(
                onTap: () async {
                  customPopupWidget(context: context,
                      description:'Are you sure you want to logout ?' ,
                      logoutButton: RebiButton(
                          height: 38,
                          onPressed: () async{
                        AppSharedPreferences.clearForLogOut();
                        await SecureStorage().deleteUserId();
                        await SecureStorage().deleteDeviceId();
                        await SecureStorage().deleteRefreshToken();
                        await SecureStorage().deleteToken();
                        AppSharedPreferences.phoneVerified = false;
                        AppSharedPreferences.typeSelected = false;
                        AppSharedPreferences.emailVerified = false;
                        if (context.mounted) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SplashScreen()));
                        }
                      },
                          child: Text("Logout", style: AppStyles.buttonTitle
                            ,)),
                      title: 'Confirm Logout');

                },
                child: const Center(
                  child: Text("Logout",
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        fontFamily: "notosan",
                        color: AppColors.blackLight,
                      )),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: "v ${AppSettings.version}",
                      style: TextStyle(
                        color: AppColors.grey,
                      ),
                    ),
                  ])),
            ),
            const Spacer(
              flex: 10,
            ),
          ],
        ),
      ),
    );
  }
}
