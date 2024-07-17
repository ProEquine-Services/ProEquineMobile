import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/constants/thems/pin_put_theme.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../data/basic_account_management_route.dart';
import '../../data/update_email_route.dart';

class VerifyUpdateEmailScreen extends StatefulWidget {

  const VerifyUpdateEmailScreen({super.key,});

  @override
  State<VerifyUpdateEmailScreen> createState() =>
      _VerifyUpdateEmailScreenState();
}

class _VerifyUpdateEmailScreenState extends State<VerifyUpdateEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  UserCubit cubit = UserCubit();

  final TextEditingController _pinPutController = TextEditingController();
  int _secondsLeft = 60;
  bool isResendCode = false;
  late Timer _timer;
  @override
  void initState() {

    super.initState();

    context.read<UserCubit>().sendMailVerificationCode();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _timer.cancel();
          isResendCode = false;
          _secondsLeft = 60;
        }
      });
    });
  }
  UpdateEmailRoute emails=UpdateEmailRoute();

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
  @override
  void dispose() {
    cubit.close();
    _pinPutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     emails = ModalRoute.of(context)?.settings.arguments as UpdateEmailRoute;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Confirm your Email",
          isThereBackButton: true,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20,),

                      Text(
                        "A 4 digit verification code has been sent to your registered email address.",
                        style: AppStyles.descriptions,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: Directionality(
                          textDirection: ui.TextDirection.ltr,
                          child: Pinput(
                            keyboardType: TextInputType.text,
                            scrollPadding: EdgeInsets.only(bottom: 50.h),
                            preFilledWidget: Container(
                              width: 30,
                              height: 5,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 2.0,
                                    color:
                                    AppSharedPreferences.getTheme ==
                                        'ThemeCubitMode.dark'
                                        ? AppColors.greyLight
                                        : AppColors.blackLight,
                                  ),
                                ),
                                color: AppSharedPreferences.getTheme ==
                                    'ThemeCubitMode.dark'
                                    ? AppColors.formsBackground
                                    : AppColors.formsBackgroundLight,
                              ),
                            ),
                            androidSmsAutofillMethod:
                            AndroidSmsAutofillMethod
                                .smsUserConsentApi,
                            length: 4,
                            closeKeyboardWhenCompleted: true,
                            isCursorAnimationEnabled: true,
                            controller: _pinPutController,
                            defaultPinTheme:
                            PinThemeConst.defaultPinTheme,
                            focusedPinTheme:
                            PinThemeConst.focusedPinTheme,
                            submittedPinTheme:
                            PinThemeConst.submittedPinTheme,
                            pinAnimationType: PinAnimationType.rotation,
                            pinputAutovalidateMode:
                            PinputAutovalidateMode.onSubmit,
                            validator: (value) {
                              if (value!.isEmpty || value.length < 4) {
                                return 'please enter your code';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Center(
                        child: Text(
                          "Haven’t received a code?",
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14.0,
                              fontFamily: 'notosan',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 10,
                        thickness: 3,
                        color: AppColors.borderColor,
                        endIndent: 30.0,
                        indent: 30.0,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isResendCode
                          ? Center(
                          child: Text(
                            _formatDuration(Duration(seconds: _secondsLeft))
                                .toString(),
                            style: const TextStyle(
                                color: AppColors.yellow,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ))
                          : Center(
                        child: InkWell(
                          onTap: () {
                            cubit.sendMailVerificationCode();
                            setState(() {
                              isResendCode = true;
                            });

                            _startTimer();
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => LoginScreen()));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 7),
                            clipBehavior: Clip.antiAlias,
                            // decoration: BoxDecoration(
                            //     color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                            //         ? AppColors.backgroundColor
                            //         : AppColors.backgroundColorLight,

                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0.50,
                                    color: AppColors.yellow),
                                borderRadius:
                                BorderRadius.circular(8),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Resend Code",
                                  style: TextStyle(
                                      color: AppColors.yellow,
                                      fontFamily: "notosan"),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  Icons.refresh,
                                  size: 20,
                                  color: AppColors.yellow,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Center(
                        child: Text(
                            "don’t forget to check your spam inbox",
                            style: TextStyle(
                                color: AppColors.borderColor,
                                fontFamily: 'notosan',
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400)
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocConsumer<UserCubit, UserState>(
                        bloc: cubit,
                        listener: (context, state) {
                          if (state is CheckUpdateMailSuccessful) {
                            AppSharedPreferences.inputEmailAddress=emails.newEmail!;
                            Navigator.pushReplacementNamed(
                                context, successScreen,
                                arguments: BasicAccountManagementRoute(
                                    type: 'manageAccount',
                                    title: "Email Updated Successfully"));
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SuccessStateScreen(
                            //               title: "Phone Updated Successfully",
                            //               isThereButton: false,
                            //             ))).then((value) => cubit
                            //     .getUser(AppSharedPreferences.userPhoneNumber));
                          } else if (state is CheckUpdateMailError) {
                            RebiMessage.error(msg: state.message!,context: context);
                          }
                        },
                        builder: (context, state) {
                          if (state is CheckUpdateMailLoading) {
                            return const LoadingCircularWidget();
                          }
                          return RebiButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                onPressVerify(previousEmail:emails.previousEmail!,newEmail:emails.newEmail!);
                              } else {}
                            },
                            // backgroundColor: AppColors.white,
                            child:  Text("Confirm", style: AppStyles.buttonStyle,),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  onPressVerify({
    required String previousEmail,
    required String newEmail,
  }) {
    return cubit
      ..checkUpdatedMail(
        // previousEmail: previousEmail,
        _pinPutController.text,
      );
  }
}
