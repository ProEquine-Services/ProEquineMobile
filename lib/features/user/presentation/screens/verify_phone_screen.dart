import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/phone_number_field_widget.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';
import 'package:proequine/features/user/presentation/screens/verification_screen.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';

import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../data/register_request_model.dart';
import '../../data/send_verification_request_model.dart';
import '../widgets/register_header.dart';

class VerifyPhoneScreen extends StatefulWidget {
  String? firstName;
  String? lastName;
  String? middleName;
  String? dob;
  String? email;
  String? password;
  String? confirmPassword;
  String? gender;
  String? nationality;

  VerifyPhoneScreen(
      {super.key,
      this.firstName,
      this.middleName,
      this.lastName,
      this.dob,
      this.email,
      this.password,
      this.confirmPassword,
      this.gender,
      this.nationality});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  late final TextEditingController _phone;
  late final TextEditingController _countryCode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserCubit cubit = UserCubit();
  String? dob = '';
  String? phoneNumber;

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
    cubit.close();
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
                        Spacer(),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Mobile number",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "For account verification and receive timely notifications this helps us ensure your account's safety while keeping you informed",
                                    style: AppStyles.descriptions),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              PhoneNumberFieldWidget(
                                  countryCode: _countryCode,
                                  phoneNumber: _phone),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: BlocConsumer<UserCubit, UserState>(
                                  bloc: cubit,
                                  builder: (context, state) {
                                    if (state is RegisterLoading) {
                                      return const LoadingCircularWidget();
                                    }
                                    return RebiButton(
                                        onPressed: () {
                                          phoneNumber =
                                              _countryCode.text + _phone.text;
                                          Print(phoneNumber);
                                          if (_formKey.currentState!
                                              .validate()) {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            _sendRegisterData(
                                              email: widget.email,
                                              phone: _countryCode.text +
                                                  _phone.text,
                                              firstName: widget.firstName,
                                              lastName: widget.lastName,
                                              middleName: widget.middleName,
                                              gender: widget.gender,
                                              nationality: widget.nationality,
                                              password: widget.password,
                                              confirmPassword:
                                                  widget.confirmPassword,
                                              dob: widget.dob,
                                            );
                                            // cubit.sendVerificationCode(
                                            //     SendVerificationRequestModel(
                                            //   phoneNumber: _countryCode.text +
                                            //       _phone.text,
                                            // ));
                                          } else {}
                                        },
                                        child:  Text("Verify", style: AppStyles.buttonStyle,));
                                  },
                                  listener: (context, state) {
                                    if (state is RegisterSuccessful) {
                                      AppSharedPreferences.inputPhoneNumber =
                                          _countryCode.text + _phone.text;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VerificationScreen()));
                                    } else if (state is RegisterError){
                                      RebiMessage.error(msg: state.message!, context: context);
                                    }else if (state is SendVerificationError) {
                                      RebiMessage.error(
                                          msg: state.message!,
                                          context: context);
                                    }
                                  },
                                ),
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
          },
        ),
      ),
    );
  }

  _sendRegisterData(
      {String? email,
      String? firstName,
      String? middleName,
      String? lastName,
      String? phone,
      String? gender,
      String? nationality,
      String? password,
      String? confirmPassword,
      String? dob}) {
    return cubit.register(RegisterRequestModel(
      email: email,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      password: password,
      dateOfBirth: dob,
      confirmPassword: confirmPassword,
      gender: gender,
      nationality: nationality,
      phoneNumber: phone,
      // dob: dob,
    ));
  }
}
