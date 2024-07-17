import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/user/presentation/screens/verify_phone_screen.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/password_input_field_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/register_header.dart';

class SignUpScreen extends StatefulWidget {
  final String? dob;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? gender;
  final String? nationality;

  const SignUpScreen(
      {super.key,
      this.dob,
      this.firstName,
      this.middleName,
      this.lastName,
      this.gender,
      this.nationality});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _email = TextEditingController();

    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                        const Spacer(
                          flex: 3,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Enter your email",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "For account verification and receive timely notifications this helps us",
                                    style: AppStyles.descriptions),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'Email'.tra,
                                  controller: _email,
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
                              const SizedBox(
                                height: 24,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Create your password",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              PasswordInputFieldWidget(
                                password: _password,
                                confirmPassword: _confirmPassword,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: RebiButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerifyPhoneScreen(
                                              firstName: widget.firstName,
                                              middleName: widget.middleName,
                                              lastName: widget.lastName,
                                              dob: widget.dob,
                                              password: _password.text,
                                              email: _email.text,
                                              confirmPassword:
                                                  _confirmPassword.text,
                                              gender: widget.gender,
                                              nationality: widget.nationality,
                                            )));
                              } else {}
                            },
                            child:  Text("Continue", style: AppStyles.buttonStyle,),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
}
