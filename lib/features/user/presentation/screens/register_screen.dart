import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/privacy_checkbox.dart';
import 'package:proequine/features/user/presentation/screens/signup_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../widgets/register_header.dart';
import 'package:intl/date_symbol_data_local.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController _firstName;
  late final TextEditingController _middleName;
  late final TextEditingController _lastName;
  late final TextEditingController _dateOfBirth;
  late final TextEditingController year;
  late final TextEditingController nationality;

  late DateTime dateTime;

  var now = DateTime.now();

  int? firstDay = 1;
  int? firstMonth = 1;
  int? firstYear = 1;
  int? lastDay = 30;
  int? lastMonth = 1;
  int? lastYear = 1;

  bool privacyValue = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _yearKey = GlobalKey<FormState>();
  DateTime _selectedDay = DateTime.utc(1950);
  final DateTime _focusedDay = DateTime.now();
  late int _selectedYear;
  late TextEditingController _yearController;
  double logoHeight = 18.h;
  List<DropdownMenuItem<String>> gender = [
    const DropdownMenuItem(
      value: "Male",
      child: Text("Male"),
    ),
    const DropdownMenuItem(
      value: "Female",
      child: Text("Female"),
    ),
  ];
  String? selectedGender;

  @override
  void initState() {
    initializeDateFormatting();
    _firstName = TextEditingController();
    _yearController = TextEditingController(text: _selectedDay.year.toString());
    _middleName = TextEditingController();
    _lastName = TextEditingController();
    _dateOfBirth = TextEditingController();
    nationality = TextEditingController();
    year = TextEditingController();
    _selectedYear = _selectedDay.year;

    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _middleName.dispose();
    _lastName.dispose();
    _dateOfBirth.dispose();
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
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        RegistrationHeader(isThereBackButton: true),
                        // Spacer(flex: 1,),
                        const Spacer(
                          flex: 3,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child:
                                    Text("Sign up", style: AppStyles.mainTitle),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    flex: 9,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      child: RebiInput(
                                        capitalization: true,
                                        hintText: 'First Name'.tra,
                                        controller: _firstName,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        isOptional: false,
                                        color: AppColors.formsLabel,
                                        onFieldSubmitted: (value){
                                          if(value!=null){
                                            setState(() {
                                              Print("sadasdasd");
                                              value.capitalize();
                                              _firstName.text.capitalize!();
                                            });

                                          }
                                        },
                                        readOnly: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validator.requiredValidator(
                                              _firstName.text);
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 7),
                                      child: RebiInput(
                                        onTap: () {
                                          setState(() {
                                            logoHeight = 15.h;
                                          });
                                        },
                                        hintText: 'Middle Name'.tra,
                                        controller: _middleName,
                                        capitalization: true,
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.done,
                                        isOptional: false,
                                        color: AppColors.formsLabel,
                                        onFieldSubmitted: (value){
                                          if(value!=null){
                                            value.capitalize();
                                            _middleName.text.capitalize!();
                                          }

                                        },
                                        readOnly: false,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 13),
                                        obscureText: false,
                                        validator: (value) {
                                          return Validator.requiredValidator(
                                              _middleName.text);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'Last Name'.tra,
                                  controller: _lastName,
                                  capitalization: true,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: false,
                                  onFieldSubmitted: (value){
                                    if(value!=null){
                                      value.capitalize();
                                      _lastName.text.capitalize!();
                                    }
                                  },
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    return Validator.requiredValidator(
                                        _lastName.text);
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
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
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    DateFormat inputFormat =
                                        DateFormat("dd MMM yyyy");
                                    DateTime dateTime =
                                        inputFormat.parse(value!);
                                    _selectedDay = dateTime;
                                    return Validator.requiredValidator(
                                        _dateOfBirth.text);
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: DropDownWidget(
                                  items: gender,
                                  selected: selectedGender,
                                  onChanged: (gender) {
                                    setState(() {
                                      selectedGender = gender;
                                      Print('selected gender $selectedGender');
                                    });
                                  },
                                  validator: (value) {
                                    // return Validator.requiredValidator(selectedNumber);
                                  },
                                  hint: 'Gender (optional)',
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'Nationality'.tra,
                                  controller: nationality,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.done,
                                  onTap: () {
                                    showCountryPicker(
                                        context: context,
                                        showPhoneCode: true,
                                        countryListTheme: CountryListThemeData(
                                          flagSize: 25,
                                          backgroundColor:
                                              AppColors.backgroundColorLight,
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: AppColors.blackLight),
                                          bottomSheetHeight: 85.0.h,
                                          // Optional. Country list modal height
                                          //Optional. Sets the border radius for the bottomsheet.
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20.0),
                                            topRight: Radius.circular(20.0),
                                          ),
                                          //Optional. Styles the search field.
                                          inputDecoration:
                                              const InputDecoration(
                                            hintText: 'Search by name or code',
                                            hintStyle: TextStyle(
                                              color:
                                                  AppColors.formsHintFontLight,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search,
                                              color:
                                                  AppColors.formsHintFontLight,
                                            ),
                                            filled: true,
                                            fillColor: AppColors.whiteLight,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              borderSide: BorderSide(
                                                color: Color(0xFFDBD4C3),
                                                width: 0.50,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              borderSide: BorderSide(
                                                color: Color(0xFFDBD4C3),
                                                width: 0.50,
                                              ),
                                            ),
                                          ),
                                        ),
                                        onSelect: (Country country) => {
                                              nationality.text = country.name,
                                          Print(country.countryCode),
                                          Print(country.name),
                                          Print(country.displayName),
                                          Print(country.e164Key),
                                          Print(country.e164Sc),
                                          Print(country.example),
                                          Print(country.nameLocalized),
                                          Print(country.hashCode),
                                          // Print(country.),
                                            });
                                  },
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  isOptional: false,
                                  color: AppColors.formsLabel,
                                  readOnly: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {},
                                ),
                              ),
                              Transform.translate(
                                offset: const Offset(-10.0, 0.0),
                                child: PrivacyCheckBox(
                                    isTherePrivacy: true,
                                    isItForShipping: false,
                                    value: privacyValue,
                                    onChanged: (value) {
                                      setState(() {
                                        privacyValue = value!;
                                      });
                                    }),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              privacyValue
                                  ? RebiButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate() &&
                                            nationality.text.isNotEmpty) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignUpScreen(
                                                        dob: _selectedDay
                                                            .toIso8601String(),
                                                        firstName: _firstName.text,
                                                        middleName: _middleName.text,
                                                        lastName: _lastName.text,
                                                        gender: selectedGender??'Empty',
                                                        nationality: nationality.text,
                                                      )));
                                        } else {}
                                      },
                                      child:  Text("Continue", style: AppStyles.buttonStyle,))
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(),
                                      child: RebiButton(
                                          onPressed: () {
                                            RebiMessage.error(
                                                msg:
                                                    "Please read and accept the Privacy Policy."
                                                        .tra,
                                                context: context);
                                          },
                                          backgroundColor: AppColors.formsLabel,
                                          child:  Text("Continue", style: AppStyles.buttonStyle,)),
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
}
