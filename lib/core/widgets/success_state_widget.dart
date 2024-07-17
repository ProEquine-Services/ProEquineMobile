import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/manage_account/presentation/screens/user_profile.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:sizer/sizer.dart';

import '../../features/manage_account/data/basic_account_management_route.dart';
import '../constants/colors/app_colors.dart';
import '../constants/constants.dart';
import '../constants/thems/app_styles.dart';

class SuccessStateScreen extends StatefulWidget {
  String? title;
  bool isThereButton = false;
  bool isItVerifyPhone = true;
  Function? onButtonPressed;
  String? buttonText;

  SuccessStateScreen(
      {Key? key,
      this.title,
      this.isThereButton = false,
      this.isItVerifyPhone = true,
      this.onButtonPressed,
      this.buttonText})
      : super(key: key);

  @override
  State<SuccessStateScreen> createState() => _SuccessStateScreenState();
}

class _SuccessStateScreenState extends State<SuccessStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  BasicAccountManagementRoute? verifyPhoneRoute = BasicAccountManagementRoute();

  @override
  Widget build(BuildContext context) {
    if (widget.isItVerifyPhone) {
      verifyPhoneRoute = ModalRoute.of(context)?.settings.arguments
          as BasicAccountManagementRoute;
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
              child: Lottie.asset(
                'assets/animation/Success.json',
                height: 250,
                width: 250,
                controller: _controller,
                onLoaded: (composition) {
                  // Configure the AnimationController with the duration of the
                  // Lottie file and start the animation.
                  if (widget.isThereButton) {
                    _controller
                      ..duration = composition.duration
                      ..forward();
                  } else {
                    if (verifyPhoneRoute?.type == 'manageAccount') {
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BottomNavigation(
                                          selectedIndex: 4,
                                        ))));
                    }
                    if (verifyPhoneRoute?.type == 'profileImage') {
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() {
                          Navigator.pop(context);
                        });
                    } else {
                      // _controller
                      //   ..duration = composition.duration
                      //   ..forward().whenComplete(() => Navigator.pop(context));
                    }
                  }
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Text(
                widget.title ?? verifyPhoneRoute!.title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: AppColors.blackLight,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          widget.isThereButton
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: RebiButton(
                    onPressed: () {
                      widget.onButtonPressed!();
                    },
                    child: Text(
                      widget.buttonText!,
                      style: AppStyles.buttonStyle,
                    ),
                  ))
              : const SizedBox(
                  height: 2,
                ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
