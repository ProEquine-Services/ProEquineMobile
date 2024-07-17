import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:proequine/features/user/presentation/screens/create_user_name_screen.dart';
import 'package:sizer/sizer.dart';

class VerificationSubmit extends StatefulWidget {
  const VerificationSubmit({Key? key}) : super(key: key);

  @override
  State<VerificationSubmit> createState() => _VerificationSubmitState();
}

class _VerificationSubmitState extends State<VerificationSubmit>
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

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Lottie.asset(

                'assets/animation/Success.json',
                height: 250,
                width: 250,
                controller: _controller,
                onLoaded: (composition) {
                  // Configure the AnimationController with the duration of the
                  // Lottie file and start the animation.
                  _controller
                    ..duration = composition.duration
                    ..forward().whenComplete(() => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  CreateUserNameScreen())));
                },
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: const Text(
                "Your account has been verified successfully",
                textAlign: TextAlign.center,
                style:  TextStyle(

                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
