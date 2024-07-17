import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pinput/pinput.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/submit_reset_password_page.dart';
import 'package:proequine/features/user/data/reset_password_request_model.dart';
import 'package:proequine/features/user/data/send_verify_request_forgot_password.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/constants/thems/pin_put_theme.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../domain/user_cubit.dart';
import '../widgets/register_header.dart';
import '../widgets/security_cases_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String? email;

  const ResetPasswordScreen({
    super.key,
    this.email,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _pinPutController = TextEditingController();
  int _secondsLeft = 60;
  bool isResendCode = false;
  late Timer _timer;

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

  UserCubit cubit = UserCubit();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  bool isCoverCases = false;
  bool isCoverNumbers = false;
  bool isCoverCharacters = false;
  bool isCoverSpecial = false;
  bool isCoverAllCases = false;

  bool _containsSymbol(String value) {
    return value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  bool _containsNumber(String value) {
    return value.contains(RegExp(r'\d'));
  }

  bool _containsCapitalLetter(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  bool _containsSmallLetter(String value) {
    return value.contains(RegExp(r'[a-z]'));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    _password.dispose();
    _confirmPassword.dispose();
    _pinPutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: _buildVerifyConsumer(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        RegistrationHeader(isThereBackButton: true),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Confirm your number",
                                  style: AppStyles.mainTitle),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "A 4 digit verification code has been sent to your registered email.",
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
                                    scrollPadding:
                                        EdgeInsets.only(bottom: 50.h),
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
                                      fontSize: 14.0,
                                      fontFamily: 'notosan',
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const CustomDivider(),
                              const SizedBox(
                                height: 20,
                              ),
                              isResendCode
                                  ? Center(
                                      child: Text(
                                      _formatDuration(
                                              Duration(seconds: _secondsLeft))
                                          .toString(),
                                      style: const TextStyle(
                                          color: AppColors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ))
                                  : Center(
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            context
                                                .read<UserCubit>()
                                                .sendVerificationCodeForgotPassword(
                                                    SendForgotPasswordVerifyRequestModel(
                                                  email: widget.email,
                                                ));
                                            isResendCode = true;
                                          });

                                          _startTimer();
                                          // Navigator.push(context,
                                          //     MaterialPageRoute(builder: (context) => LoginScreen()));
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 7),
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
                                                color: AppColors.yellow,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              const SizedBox(
                                height: 20,
                              ),
                              const CustomDivider(),
                              const SizedBox(
                                height: 20,
                              ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SvgPicture.asset(
                                    isCoverAllCases
                                        ? AppIcons.check
                                        : AppIcons.info,
                                    height: isCoverAllCases ? 25 : 40,
                                    color: isCoverAllCases
                                        ? AppColors.greenLight
                                        : AppColors.yellow,
                                  ),
                                  SecurityCasesWidget(
                                    header: "Aa",
                                    description: "Cases",
                                    isValidate: isCoverCases,
                                  ),
                                  SecurityCasesWidget(
                                    header: "@!&",
                                    description: "Special",
                                    isValidate: isCoverSpecial,
                                  ),
                                  SecurityCasesWidget(
                                    header: "1",
                                    description: "Number",
                                    isValidate: isCoverNumbers,
                                  ),
                                  SecurityCasesWidget(
                                    header: "8+",
                                    description: "characters",
                                    isValidate: isCoverCharacters,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'New password'.tra,
                                  controller: _password,
                                  onChanged: (value) {
                                    if (_containsSymbol(value!)) {
                                      setState(() {
                                        isCoverSpecial = true;
                                      });
                                    } else {
                                      setState(() {
                                        isCoverSpecial = false;
                                      });
                                    }
                                    if (_containsCapitalLetter(value) &&
                                        _containsSmallLetter(value)) {
                                      setState(() {
                                        isCoverCases = true;
                                      });
                                    } else {
                                      setState(() {
                                        isCoverCases = false;
                                      });
                                    }
                                    if (_containsNumber(value)) {
                                      setState(() {
                                        isCoverNumbers = true;
                                      });
                                    } else {
                                      setState(() {
                                        isCoverNumbers = false;
                                      });
                                    }
                                    if (value.length >= 8) {
                                      setState(() {
                                        isCoverCharacters = true;
                                      });
                                    } else {
                                      setState(() {
                                        isCoverCharacters = false;
                                      });
                                    }
                                    if (_containsNumber(value) &&
                                        _containsSmallLetter(value) &&
                                        _containsCapitalLetter(value) &&
                                        _containsSymbol(value) &&
                                        value.length >= 8) {
                                      setState(() {
                                        isCoverAllCases = true;
                                      });
                                    } else {
                                      setState(() {
                                        isCoverAllCases = false;
                                      });
                                    }
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  isOptional: false,
                                  autoValidateMode: AutovalidateMode.disabled,
                                  color: AppColors.formsLabel,
                                  readOnly: false,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: true,
                                  validator: (value) {
                                    if (!_containsNumber(value!) ||
                                        !_containsSmallLetter(value) ||
                                        !_containsCapitalLetter(value) ||
                                        !_containsSymbol(value) ||
                                        value.length < 8) {
                                      return 'Password must include numbers, capital letters, and symbols.'
                                          .tra;
                                    }
                                    if (value.isEmpty) {
                                      return 'Please enter your password'.tra;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: RebiInput(
                                  hintText: 'Confirm new password'.tra,
                                  controller: _confirmPassword,
                                  scrollPadding:
                                      const EdgeInsets.only(bottom: 100),
                                  keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: false,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value != null && value.isEmpty) {
                                      return "Please confirm your password".tra;
                                    } else if (value != _password.text) {
                                      return "password does not match".tra;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),

                              SizedBox(
                                height: 5.h,
                              ),

                              _buildVerifyConsumer(),
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
          },
        ),
      ),
    );
  }

  _buildVerifyConsumer() {
    return BlocConsumer<UserCubit, UserState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is ResetPasswordLoading) {
            return const LoadingCircularWidget();
          }
          {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0) ,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: RebiButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      _onPressVerify();
                    } else {}
                  },
                  child:  Text("Verify", style: AppStyles.buttonStyle,),
                ),
              ),
            );
          }
        },
        listener: (context, state) {
          if (state is ResetPasswordSuccessful) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ResetPasswordSubmit()));
          } else if (state is ResetPasswordError) {
            RebiMessage.error(msg: state.message!, context: context);
          }
        });
  }

  _onPressVerify() {
    return cubit.resetPassword(ResetPasswordRequestModel(
      email: widget.email,
      otpCode: _pinPutController.text,
      newPassword: _password.text,
      confirmNewPassword: _confirmPassword.text
    ));
  }
}
