import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/widgets/rebi_button.dart';
import 'package:proequine_dev/features/uncompleted_customers/presentation/screens/exist_customer_support_screen.dart';
import 'package:proequine_dev/features/uncompleted_customers/presentation/screens/update_exist_customer_details_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../user/data/login_request_model.dart';
import '../../../user/domain/user_cubit.dart';
import '../../../user/presentation/screens/contact_support_otp_issue_screen.dart';

class ExistCustomerLoginScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isPhoneGenerated;
  final bool isEmailGenerated;

  const ExistCustomerLoginScreen({
    super.key,
    required this.phoneNumber,
    required this.isPhoneGenerated,
    required this.isEmailGenerated,
  });

  @override
  State<ExistCustomerLoginScreen> createState() =>
      _ExistCustomerLoginScreenState();
}

class _ExistCustomerLoginScreenState extends State<ExistCustomerLoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserCubit cubit = UserCubit();

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
            title: "",
            isThereBackButton: true,
            isThereChangeWithNavigate: false,
            isThereThirdOption: false),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "When you're ready, use the credentials we've sent you to login ",
                          style: AppStyles.mainTitle2),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: kPadding),
              child: RebiInput(
                hintText: 'Email'.tra,
                controller: _email,
                scrollPadding: const EdgeInsets.only(bottom: 100),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                isOptional: false,
                color: AppColors.formsLabel,
                readOnly: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                obscureText: false,
                validator: (value) {
                  return Validator.emailValidator(_email.text);
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 7, horizontal: kPadding),
              child: RebiInput(
                hintText: 'Password'.tra,
                controller: _password,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                scrollPadding: const EdgeInsets.only(bottom: 100),
                isOptional: false,
                color: AppColors.formsLabel,
                readOnly: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                obscureText: true,
                validator: (value) {
                  return Validator.passwordValidator(_password.text);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: _buildLoginConsumer(),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "If you face any problem   ",
                  style: TextStyle(
                      color: AppColors.blackLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExistCustomerSupportScreen(
                                  division: 'Technology',
                                  subject: 'IT Support',
                                  phoneNumber: widget.phoneNumber,
                                )));
                  },
                  child: const Text(
                    "Contact Support",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: AppColors.blackLight,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
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
                child: const Text(
                  "Sign in",
                  style: AppStyles.buttonStyle,
                ));
          }
        },
        listener: (context, state) {
          if (state is LoginError) {
            RebiMessage.error(msg: state.message!, context: context);
          }
          if (state is LoginSuccessful) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateExistCustomerDetailsScreen()));
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
