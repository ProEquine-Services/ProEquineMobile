import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/utils/rebi_message.dart';
import 'package:proequine_dev/core/widgets/loading_widget.dart';
import 'package:proequine_dev/core/widgets/rebi_button.dart';
import 'package:proequine_dev/features/uncompleted_customers/data/update_exist_account_request_model.dart';
import 'package:proequine_dev/features/uncompleted_customers/domain/exist_customer_cubit.dart';
import 'package:proequine_dev/features/uncompleted_customers/presentation/screens/welcome_back_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/password_input_field_widget.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../user/domain/user_cubit.dart';

class UpdateExistCustomerDetailsScreen extends StatefulWidget {
  const UpdateExistCustomerDetailsScreen({
    super.key,
  });

  @override
  State<UpdateExistCustomerDetailsScreen> createState() =>
      _UpdateExistCustomerDetailsScreenState();
}

class _UpdateExistCustomerDetailsScreenState
    extends State<UpdateExistCustomerDetailsScreen> {
  late final TextEditingController _dateOfBirth;
  late final TextEditingController _userName;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  late final TextEditingController year;

  late DateTime dateTime;

  var now = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _yearKey = GlobalKey<FormState>();
  DateTime _selectedDay = DateTime.utc(1950);
  final DateTime _focusedDay = DateTime.now();
  late int _selectedYear;
  late TextEditingController _yearController;

  int? firstDay = 1;
  int? firstMonth = 1;
  int? firstYear = 1;
  int? lastDay = 30;
  int? lastMonth = 1;
  int? lastYear = 1;
  final ExistCustomerCubit cubit = ExistCustomerCubit();

  @override
  void initState() {
    initializeDateFormatting();
    _dateOfBirth = TextEditingController();
    _userName = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _yearController = TextEditingController();
    year = TextEditingController();
    _selectedYear = _selectedDay.year;
    super.initState();
  }

  @override
  void dispose() {
    _confirmPassword.dispose();
    _password.dispose();
    _userName.dispose();
    _dateOfBirth.dispose();
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          "Almost there, just few we need you to update  ",
                          style: AppStyles.mainTitle2),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Text(
                  "Enter your date of birth",
                  style: AppStyles.descriptions,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: RebiInput(
                    hintText: 'Date Of Birth'.tra,
                    controller: _dateOfBirth,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    onTap: () {
                      selectDate(
                          context: context,
                          isSupportChangingYears: true,
                          selectedOurDay: _selectedDay,
                          from: DateTime.utc(1950),
                          to: DateTime.utc(2030),
                          selectedYear: _selectedYear,
                          yearController: _yearController,
                          focusDay: _focusedDay,
                          controller: _dateOfBirth,
                          yearKey: _yearKey);
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    isOptional: false,
                    color: AppColors.formsLabel,
                    readOnly: true,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                    obscureText: false,
                    validator: (value) {
                      DateFormat inputFormat = DateFormat("dd MMM yyyy");
                      DateTime dateTime = inputFormat.parse(value!);
                      _selectedDay = dateTime;
                      return Validator.requiredValidator(_dateOfBirth.text);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Create username",
                  style: AppStyles.appBarTitle,
                ),
                Text(
                  "Remember to keep it simple and unique.",
                  style: AppStyles.descriptions,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      const Expanded(
                          flex: 1,
                          child: Text(
                            "@",
                            style: TextStyle(
                                color: AppColors.blackLight,
                                fontSize: 26,
                                fontWeight: FontWeight.w700),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 15,
                        child: RebiInput(
                          hintText: 'Username'.tra,
                          controller: _userName,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          isOptional: false,
                          color: AppColors.formsLabel,
                          readOnly: false,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 13),
                          obscureText: false,
                          validator: (value) {
                            return Validator.requiredValidator(_userName.text);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Update password",
                  style: AppStyles.appBarTitle,
                ),
                const SizedBox(
                  height: 10,
                ),
                PasswordInputFieldWidget(
                  password: _password,
                  confirmPassword: _confirmPassword,
                ),
                const Spacer(),
                BlocConsumer<ExistCustomerCubit, ExistCustomerState>(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state is UpdateCustomerDetailsError){
                      RebiMessage.error(msg: state.message!, context: context);
                    }else if (state is UpdateCustomerDetailsSuccessfully){

                      Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeBackScreen()));
                    }
                  },
                  builder: (context, state) {
                    if(state is UpdateCustomerDetailsLoading){
                      return const LoadingCircularWidget();
                    }
                    return RebiButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            _onPressUpdate();
                          }else{
                            RebiMessage.error(msg: "Some data are missing.", context: context);
                          }

                        }, child: const Text("Update"));
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  _onPressUpdate(){
    cubit.updateExistCustomer(UpdateExistAccountRequestModel(
      dateOfBirth: _selectedDay
          .toIso8601String(),
      userName: _userName.text.replaceAll(' ', ''),
      password: _password.text,
      confirmPassword: _confirmPassword.text
    ));
  }
}
