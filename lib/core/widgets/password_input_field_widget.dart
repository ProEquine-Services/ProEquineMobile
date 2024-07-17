import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/rebi_input.dart';

import '../../features/user/presentation/widgets/security_cases_widget.dart';
import '../constants/colors/app_colors.dart';
import '../constants/images/app_images.dart';

class PasswordInputFieldWidget extends StatefulWidget {
  final TextEditingController password;
  final TextEditingController confirmPassword;
  const PasswordInputFieldWidget({super.key, required this.password, required this.confirmPassword});

  @override
  State<PasswordInputFieldWidget> createState() => _PasswordInputFieldWidgetState();
}

class _PasswordInputFieldWidgetState extends State<PasswordInputFieldWidget> {
  @override
  void initState() {
    widget.password!=TextEditingController();
    widget.confirmPassword!=TextEditingController();
    super.initState();
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
    return value.contains(RegExp(r'[0-9]'));
  }

  bool _containsCapitalLetter(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  bool _containsSmallLetter(String value) {
    return value.contains(RegExp(r'[a-z]'));
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          height: 7,
        ),
        Padding(
          padding:
          const EdgeInsets.symmetric(vertical: 7),
          child: RebiInput(
            hintText: 'Password'.tra,
            controller: widget.password,
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
          const EdgeInsets.symmetric(vertical: 7),
          child: RebiInput(
            hintText: 'Confirm password'.tra,
            controller: widget.confirmPassword,
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
                return "".tra;
              } else if (value != widget.password.text) {
                return "".tra;
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }
}
