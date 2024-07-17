import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/success_state_widget.dart';
import '../../../user/presentation/widgets/security_cases_widget.dart';
import '../../data/basic_account_management_route.dart';
import '../../data/change_password_request_model.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPassword = TextEditingController();

  final TextEditingController _newPassword = TextEditingController();

  final TextEditingController _confirmNewPassword = TextEditingController();

  bool isCoverCases = false;
  bool isCoverNumbers = false;
  bool isCoverCharacters = false;
  bool isCoverSpecial = false;
  bool isCoverAllCases = false;

  bool _containsSymbol(String value) {
    return value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  bool _containsNumber(String value) {
    return value.contains(RegExp(r'[0-9]'));
  }

  bool _containsCapitalLetter(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  bool _containsSmallLetter(String value) {
    return value.contains(RegExp(r'[a-z]'));
  }

  ManageAccountCubit cubit = ManageAccountCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Update Password",
          isThereBackButton: true,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    isCoverAllCases ? AppIcons.check : AppIcons.info,
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
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: kPadding, right: kPadding, bottom: 10),
                child: RebiInput(
                  hintText: 'Old password'.tra,
                  controller: _oldPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  isOptional: false,
                  readOnly: false,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  obscureText: true,
                  validator: (value) {
                    return Validator.passwordValidator(_oldPassword.text);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: kPadding),
                child: RebiInput(
                  hintText: 'New password'.tra,
                  controller: _newPassword,
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
                  color: AppColors.formsLabel,
                  readOnly: false,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
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
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: kPadding),
                child: RebiInput(
                  hintText: 'Confirm new password'.tra,
                  controller: _confirmNewPassword,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  isOptional: false,
                  readOnly: false,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  obscureText: true,
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return "".tra;
                    } else if (value != _newPassword.text) {
                      return "".tra;
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              BlocConsumer<ManageAccountCubit, ManageAccountState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is ChangePasswordSuccessful) {
                    Navigator.pushReplacementNamed(
                        context, successScreen,
                        arguments: BasicAccountManagementRoute(
                            type: 'manageAccount',
                            title: "Password updated successfully"));
                  } else if (state is ChangePasswordError) {
                    RebiMessage.error(msg: state.message!, context: context);
                  }
                },
                builder: (context, state) {
                  if (state is ChangePasswordLoading) {
                    return const LoadingCircularWidget();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: RebiButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          onPressChange();
                        } else {}
                      },
                      child:  Text("Update", style: AppStyles.buttonStyle,),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  onPressChange() {
    return cubit.changePassword(ChangePasswordRequestModel(

      currentPassword: _oldPassword.text,
      newPassword: _newPassword.text,
      confirmNewPassword: _confirmNewPassword.text
    ));
  }
}
