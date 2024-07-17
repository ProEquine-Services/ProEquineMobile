import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/custom_logo_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/core/widgets/rebi_input.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:proequine/features/stables/presentation/screens/choose_stable_screen.dart';
import 'package:proequine/features/user/presentation/screens/create_user_name_screen.dart';
import 'package:proequine/features/user/presentation/screens/forget_password_screen.dart';
import 'package:proequine/features/user/presentation/screens/interests_screen.dart';
import 'package:proequine/features/user/presentation/screens/verification_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../nav_bar/domain/navbar_cubit.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../data/login_request_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserCubit cubit = UserCubit();
  double logoHeight = 18.h;

  @override
  void initState() {
    AppSharedPreferences.firstTime = true;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BlocProvider.of<NavbarCubit>(context).onWillPop(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          const Spacer(
                            flex: 1,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              height: logoHeight,
                              child: const CustomLogoWidget()),
                          const Spacer(
                            flex: 1,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Sign in',
                                    style: AppStyles.mainTitle,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: RebiInput(
                                    hintText: 'Email'.tra,
                                    onTap: () {
                                      setState(() {
                                        logoHeight = 15.h;
                                      });
                                    },
                                    onFieldSubmitted: (size) {
                                      setState(() {
                                        logoHeight = 18.h;
                                      });
                                    },
                                    controller: _email,
                                    scrollPadding:
                                        const EdgeInsets.only(bottom: 100),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    isOptional: false,
                                    color: AppColors.formsLabel,
                                    readOnly: false,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 13),
                                    obscureText: false,
                                    validator: (value) {
                                      return Validator.emailValidator(
                                          _email.text);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: RebiInput(
                                    hintText: 'Password'.tra,
                                    onTap: () {
                                      setState(() {
                                        logoHeight = 15.h;
                                      });
                                    },
                                    onFieldSubmitted: (size) {
                                      setState(() {
                                        logoHeight = 18.h;
                                      });
                                    },
                                    controller: _password,
                                    keyboardType: TextInputType.visiblePassword,
                                    textInputAction: TextInputAction.done,
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    scrollPadding:
                                        const EdgeInsets.only(bottom: 100),
                                    isOptional: false,
                                    color: AppColors.formsLabel,
                                    readOnly: false,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 13),
                                    obscureText: true,
                                    validator: (value) {
                                      return Validator.passwordValidator(
                                          _password.text);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: _buildLoginConsumer(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        alignment: Alignment.centerLeft),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgotPasswordScreen()));
                                    },
                                    child: const Text(
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.blackLight,
                                          fontWeight: FontWeight.w700),
                                      "Forget your password?",
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: RichText(
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                        text: "New to ProEquine? ".tra,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppSharedPreferences.getTheme ==
                                                        'ThemeCubitMode.dark'
                                                    ? Colors.white
                                                    : AppColors.blackLight,
                                            fontSize: 18),
                                      ),
                                      TextSpan(
                                          text: "Sign up".tra,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppSharedPreferences
                                                          .getTheme ==
                                                      'ThemeCubitMode.dark'
                                                  ? Colors.white
                                                  : AppColors.blackLight,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'notosan',
                                              decoration:
                                                  TextDecoration.underline),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushNamed(
                                                  context, registerRoute);
                                            }),
                                    ]),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _buildLoginConsumer() {
    return BlocConsumer<UserCubit, UserState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is LoginLoading) {
            return const LoadingCircularWidget();
          } else if (state is LoginError) {}
          {
            return RebiButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    _onPressLogin();
                  } else {}
                },
                child:  Text("Sign in", style: AppStyles.buttonStyle,));
          }
        },
        listener: (context, state) {
          if (state is LoginError) {
            RebiMessage.error(msg: state.message!, context: context);
          }
          if (state is LoginSuccessful) {
            if (!AppSharedPreferences.getPhoneVerified!) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VerificationScreen()));
            } else if (!AppSharedPreferences.isHasUserName!) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateUserNameScreen()));
            } else if (!AppSharedPreferences.getIsITypeSelected!) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const InterestsScreen()));
            } else if (!AppSharedPreferences.isStableChosen!) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChoseStableScreen()));
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavigation()));
            }
          }
        });
  }

  _onPressLogin() {
    return cubit
      ..login(LoginRequestModel(
        userName: _email.text,
        password: _password.text,
      ));
  }
}
