import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine/core/StartUp/StartUp.dart';
import 'package:proequine/core/widgets/submit_verify_email.dart';
import 'package:proequine/core/widgets/success_state_widget.dart';
import 'package:proequine/features/associations/domain/associations_cubit.dart';
import 'package:proequine/features/associations/presentation/screens/horse_invites_association_screen.dart';
import 'package:proequine/features/bank_transfer/domain/bank_transfer_cubit.dart';
import 'package:proequine/features/equine_info/domain/equine_info_cubit.dart';
import 'package:proequine/features/events/domain/event_cubit.dart';
import 'package:proequine/features/home/domain/cubits/home_cubit.dart';
import 'package:proequine/features/home/domain/cubits/local_horse_cubit.dart';

import 'package:proequine/features/home/presentation/screens/create_media_request_screen.dart';
import 'package:proequine/features/home/presentation/screens/shows_screen.dart';
import 'package:proequine/features/invoices/domain/invoices_cubit.dart';
import 'package:proequine/features/shipping/domain/shipping_cubit.dart';
import 'package:proequine/features/shipping/presentation/screens/selective_service_screen.dart';
import 'package:proequine/features/support/presentation/screens/all_support_requests_screen.dart';
import 'package:proequine/features/transports/domain/transport_cubit.dart';
import 'package:proequine/features/transports/presentation/screens/create_trip_screen.dart';
import 'package:proequine/features/horses/domain/horse_cubit.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
import 'package:proequine/features/nav_bar/domain/inbox_badge.dart';
import 'package:proequine/features/nav_bar/domain/theme_cubit.dart';
import 'package:proequine/features/notifications/domain/notifications_cubit.dart';
import 'package:proequine/features/manage_account/presentation/screens/add_second_number_screen.dart';
import 'package:proequine/features/manage_account/presentation/screens/user_profile.dart';
import 'package:proequine/features/manage_account/presentation/screens/verify_email_screen.dart';
import 'package:proequine/features/manage_account/presentation/screens/verify_update_email_screen.dart';

import 'package:proequine/features/splash/domain/splash_cubit.dart';
import 'package:proequine/features/splash/presentation/screens/splash_screen.dart';
import 'package:proequine/features/stables/domain/stable_cubit.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:proequine/features/stables/presentation/screens/choose_stable_screen.dart';
import 'package:proequine/features/wallet/domain/wallet_cubit.dart';
import 'package:proequine/features/wallet/presentation/screens/main_wallet_screen.dart';
import 'package:proequine/theme_cubit_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'core/constants/constants.dart';
import 'core/constants/routes/routes.dart';
import 'core/constants/thems/app_styles.dart';
import 'core/http/path_provider.dart';
import 'core/utils/Printer.dart';
import 'core/utils/secure_storage/secure_storage_helper.dart';
import 'core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'features/home/domain/repo/local_storage_repository.dart';
import 'features/manage_account/presentation/screens/update_phone_screen.dart';
import 'features/manage_account/presentation/screens/verify_updated_phone_screen.dart';
import 'features/nav_bar/domain/navbar_cubit.dart';
import 'features/nav_bar/presentation/screens/bottomnavigation.dart';

import 'features/shipping/presentation/screens/create_export_screen.dart';
import 'features/shipping/presentation/screens/create_import_screen.dart';
import 'features/support/domain/support_cubit.dart';
import 'features/user/presentation/screens/login_screen.dart';
import 'features/user/presentation/screens/register_screen.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.init();
  await AppPathProvider.initPath();
  Stripe.publishableKey =
      'pk_test_51JSKeuJawRWtFfJ7Pl7OzShHujsSvaaB0KjNVa5eS4jR0F0NTmJHuXfW8lyyqKOb0OYpI3GWFsV2xGUmfgJjL6hh00C89XiTTu';

  await Stripe.instance.applySettings();
  await di.init();
  await initializeDateFormatting('en', null);

  StartUp.setup();
  String? defaultLocale = Platform.localeName;
  if (defaultLocale.substring(0, 2) == 'en') {
    defaultLocale = 'en';
  } else if (defaultLocale.substring(0, 2) == 'ar') {
    defaultLocale = 'ar';
  } else {
    defaultLocale = 'en';
  }
  Locale? startLocale;
  startLocale = languages['en'];
  AppSharedPreferences.lang = 'en';
  runApp(
    EasyLocalization(
      startLocale: startLocale,
      supportedLocales: languages.values.toList(),
      path: "assets/languages",
      child: _blocProvider(),
    ),
  );
}

LocalHorseCubit localHorseCubit =
    LocalHorseCubit(localStorageRepository: LocalStorageRepository());

_blocProvider() {
  return MultiBlocProvider(
    providers: [
      BlocProvider<NavbarCubit>(
        create: (context) => NavbarCubit(),
      ),
      BlocProvider<SplashCubit>(
        create: (context) => SplashCubit(),
      ),
      BlocProvider<NotificationsCubit>(
        create: (context) => NotificationsCubit(),
      ),
      BlocProvider<UserCubit>(
        create: (context) => UserCubit(),
      ),
      BlocProvider<EventCubit>(
        create: (context) => EventCubit(),
      ),
      BlocProvider<SupportCubit>(
        create: (context) => SupportCubit(),
      ),
      BlocProvider<ManageAccountCubit>(
        create: (context) => ManageAccountCubit(),
      ),
      BlocProvider<LocalHorseCubit>(
        create: (context) => localHorseCubit,
      ),
      BlocProvider<EquineInfoCubit>(
        create: (context) => EquineInfoCubit(),
      ),
      BlocProvider<StableCubit>(
        create: (context) => StableCubit(),
      ),
      BlocProvider<HorseCubit>(
        create: (context) => HorseCubit(),
      ),
      BlocProvider<InvoicesCubit>(
        create: (context) => InvoicesCubit(),
      ),
      BlocProvider<AssociationsCubit>(
        create: (context) => AssociationsCubit(),
      ),
      BlocProvider<WalletCubit>(
        create: (context) => WalletCubit(),
      ),
      BlocProvider<BankTransferCubit>(
        create: (context) => BankTransferCubit(),
      ),
      BlocProvider<HomeCubit>(
        create: (context) => HomeCubit(),
      ),
      BlocProvider<TransportCubit>(
        create: (context) => TransportCubit(),
      ),
      BlocProvider<ShippingCubit>(
        create: (context) => ShippingCubit(),
      ),
      BlocProvider<ChangeBoolCubit>(
        create: (context) =>
            ChangeBoolCubit(ChangeBoolState(thereAreNotification: false)),
      ),
    ],
    child: const ResponsiveSizer(),
  );
}

class ResponsiveSizer extends StatelessWidget {
  const ResponsiveSizer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return const MyApp();
      },
    );
  }
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  ThemeCubit cubit = ThemeCubit();
  String? userId;

  Future<String> getUserId() async {
    userId = await SecureStorage().getUserId();
    return userId!;
  }

  deleteSecureStorage() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getBool('first_run') ?? true) {
      Print('first run');
     SecureStorage().deleteToken();
     SecureStorage().deleteRefreshToken();
     SecureStorage().deleteDeviceId();
     SecureStorage().deleteUserId();

      prefs.setBool('first_run', false);
    }
  }

  @override
  void initState() {
    super.initState();
    deleteSecureStorage();
    getUserId();
    BlocProvider.of<NotificationsCubit>(context).configOneSignal();
    GlobalKey<NavigatorState>();
  }

  @override
  Widget build(BuildContext context) {
    return ThemeCubitProvider(child:
        BlocBuilder<ThemeCubit, ThemeCubitMode>(builder: (context, themeMode) {
      Print("theme mode $themeMode");
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: MyApp.navigatorKey,
        theme: themeMode == ThemeCubitMode.dark
            ? AppStyles().darkTheme
            : AppStyles().lightTheme,
        title: 'Pro Equine',
        home:  const SplashScreen(),
        routes: {
          loginRoute: (context) => const LoginScreen(),
          horses: (context) => const BottomNavigation(selectedIndex: 3,),
          horseAssociation: (context) => const BottomNavigation(selectedIndex: 3,selectedSection: 1,),
          shipping: (context) => const BottomNavigation(selectedIndex: 2,),
          transportation: (context) => const BottomNavigation(selectedIndex: 1,),
          registerRoute: (context) => const RegisterScreen(),
          horseAssociationRequests: (context) => const HorseRequestAssociationScreen(),
          support: (context) => const AllSupportRequestsScreen(),
          wallet: (context) => const MainWalletScreen(),
          homeRoute: (context) => const BottomNavigation(),
          createTrip: ((context) => const CreateTripScreen()),
          createHospitalTrip: ((context) => const CreateTripScreen(type: 'hospital',)),
          joinShow: ((context) => const ShowsServicesScreen()),
          createMedia: ((context) => const CreateMediaRequestScreen()),
          import: ((context) => CreateImportScreen()),
          export: ((context) => CreateExportScreen()),
          selectiveServiceImport: ((context) => const SelectiveServicesScreen(type: 'Import')),
          selectiveServiceExport: ((context) => const SelectiveServicesScreen(type: 'Export')),
          userProfile: (context) => const UserProfile(),
          updatePhone: (context) => UpdatePhoneScreen(),
          choseStable: (context) => const ChoseStableScreen(),
          addSecondaryPhone: (context) => const AddSecondaryPhoneScreen(),
          verifyUpdatePhone: (context) => const VerifyUpdatedPhoneScreen(),
          verifyUpdateEmail: (context) => const VerifyUpdateEmailScreen(),
          submitVerifyEmail: (context) => SubmitVerifyEmail(),
          successScreen: (context) => SuccessStateScreen(),
          verifyEmail: (context) => const VerifyEmailScreen(),
        },
      );
    }));
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name == '/') {
      SystemNavigator.pop();
    }
  }
}
