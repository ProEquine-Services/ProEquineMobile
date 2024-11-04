import 'package:flutter/material.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/widgets/rebi_button.dart';
import 'package:proequine_dev/core/widgets/rebi_input.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/phone_number_field_widget.dart';

class MissingDetailsScreen extends StatefulWidget {
  final bool phoneGenerated;
  final bool? emailGenerated;
  final String? email;
  final String? phone;

  const MissingDetailsScreen(
      {super.key, required this.phoneGenerated, required this.emailGenerated, this.email, this.phone});

  @override
  State<MissingDetailsScreen> createState() =>
      _MissingDetailsScreenState();
}

class _MissingDetailsScreenState extends State<MissingDetailsScreen> {
  late final TextEditingController _phone;
  late final TextEditingController _countryCode;
  final TextEditingController _email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _phone = TextEditingController();
    _countryCode = TextEditingController(text: "+971");
    super.initState();
  }

  @override
  void dispose() {
    _phone.dispose();
    _countryCode.dispose();
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Your Account is All Set! We’re excited to welcome you to ProEquine.",
                        style: AppStyles.mainTitle2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: widget.phoneGenerated
                        ? Text(
                            "To complete the setup, we just need a quick confirmation we just need to confirm your phone",
                            style: AppStyles.descriptions)
                        : Text(
                            "To complete the setup, we just need a quick confirmation we just need to confirm your email",
                            style: AppStyles.descriptions),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  widget.phoneGenerated
                      ? PhoneNumberFieldWidget(
                          countryCode: _countryCode, phoneNumber: _phone)
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 7,
                          ),
                          child: RebiInput(
                            hintText: 'Email'.tra,
                            controller: _email,
                            scrollPadding: const EdgeInsets.only(bottom: 100),
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
                              return Validator.emailValidator(_email.text);
                            },
                          ),
                        ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: RebiButton(
                onPressed: () {

                },
                child: const Text("Next"),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
