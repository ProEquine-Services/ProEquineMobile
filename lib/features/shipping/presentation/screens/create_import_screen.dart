import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine_dev/core/constants/colors/app_colors.dart';
import 'package:proequine_dev/core/constants/constants.dart';
import 'package:proequine_dev/core/global_functions/global_statics_drop_down.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/utils/rebi_message.dart';
import 'package:proequine_dev/features/shipping/data/create_shipping_request_model.dart';
import 'package:proequine_dev/features/shipping/domain/shipping_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/phone_number_field_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/chose_location_widget.dart';
import 'import_second_step_screen.dart';

class CreateImportScreen extends StatefulWidget {
  bool isFromEditing = false;
  String? exportCountry;

  String? importCountry;

  DateTime? estimatedDate;
  String? selectedEquipment;

  CreateImportScreen({
    this.isFromEditing = false,
    this.exportCountry,
    this.importCountry,
    this.estimatedDate,
    super.key,
  });

  @override
  CreateImportScreenState createState() => CreateImportScreenState();
}

class CreateImportScreenState extends State<CreateImportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController pickUpContactName = TextEditingController();
  TextEditingController pickupCountry = TextEditingController();
  TextEditingController dropOfLocationUrl = TextEditingController();
  TextEditingController numberOfHorses = TextEditingController();
  TextEditingController pickUpContactNumber = TextEditingController();
  TextEditingController pickUpCountryCode = TextEditingController(text: '+971');

  TextEditingController dropLocation = TextEditingController();
  TextEditingController dropContactName = TextEditingController();
  TextEditingController dropContactNumber = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController long = TextEditingController();
  TextEditingController placeId = TextEditingController();
  TextEditingController dropCountryCode = TextEditingController(text: '+971');
  DateTime focusedDay = DateTime.now();
  TextEditingController? estimatedDate;

  DateTime dateTime = DateTime.now();
  late DateTime pickDate;

  String convertToTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return time;
  }

  String? selectedEquipment;
  String? selectedCountryIso2;

  @override
  void initState() {
    initializeDateFormatting();
    if (widget.isFromEditing) {}
    estimatedDate = TextEditingController();

    super.initState();
  }

  String? formatted;

  @override
  void dispose() {
    estimatedDate?.dispose();
    super.dispose();
  }

  String? selectedNumber;
  String? phoneNumber;

  bool isChoseAddPlace = false;

  void changeToTrueValue() {
    setState(() {
      isChoseAddPlace = true;
    });
  }

  void changeToFalseValue() {
    setState(() {
      isChoseAddPlace = false;
    });
  }

  ShippingCubit cubit = ShippingCubit();
  int? shippingId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Shipping Import",
            style: TextStyle(
                fontSize: 17,
                fontFamily: "notosan",
                fontWeight: FontWeight.w600,
                color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                    ? Colors.white
                    : AppColors.blackLight)),
        centerTitle: true,
        backgroundColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
            ? Colors.transparent
            : AppColors.backgroundColorLight,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                      ? Colors.white
                      : AppColors.blackLight,
                ),
              )),
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kPadding,
                          ),
                          child: Text(
                            'Abroad address',
                            style: TextStyle(
                              color: Color(0xFFC48636),
                              fontSize: 16,
                              fontFamily: 'Noto Sans',
                              fontWeight: FontWeight.w600,
                              height: 1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: !widget.isFromEditing,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 6),
                            child: RebiInput(
                              hintText: 'Shipping Estimated Date '.tra,
                              controller: estimatedDate,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              onTap: () {
                                selectDate(
                                  context: context,
                                  from: DateTime.now(),
                                  to: DateTime(2025, 1, 1),
                                  isSupportChangingYears: false,
                                  selectedOurDay: dateTime,
                                  controller: estimatedDate!,
                                  focusDay: focusedDay,
                                );
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
                                if (value!.isNotEmpty) {
                                  DateFormat inputFormat =
                                      DateFormat("dd MMM yyyy");
                                  DateTime setUpdatedDate =
                                      inputFormat.parse(value);
                                  pickDate = setUpdatedDate;
                                } else {
                                  return 'please select date';
                                }

                                if (dateTime.isBefore(DateTime.now()) &&
                                    !dateTime.isSameDate(DateTime.now())) {
                                  return 'correct date please';
                                }
                                return Validator.requiredValidator(
                                    estimatedDate?.text);
                              },
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !widget.isFromEditing,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 7),
                            child: RebiInput(
                              hintText: 'Importing country'.tra,
                              controller: pickupCountry,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                      inputDecoration: const InputDecoration(
                                        hintText: 'Search by name or code',
                                        hintStyle: TextStyle(
                                          color: AppColors.formsHintFontLight,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        prefixIcon: Icon(
                                          Icons.search,
                                          color: AppColors.formsHintFontLight,
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
                                    onSelect: (Country country) {
                                      pickupCountry.text = country.name;
                                      setState(() {
                                        selectedCountryIso2 =
                                            country.countryCode;
                                      });
                                    });
                              },
                              isOptional: false,
                              color: AppColors.formsLabel,
                              readOnly: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 13),
                              obscureText: false,
                              validator: (value) {
                                return Validator.countryCodeValidator(
                                    pickUpCountryCode.text);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: ChoseLocationWidget(
                            locationName: dropLocation,
                            lat: latitude,
                            lng: long,
                            changeTrue: changeToTrueValue,
                            changeFalse: changeToFalseValue,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 6),
                          child: RebiInput(
                            hintText: 'Pickup contact name'.tra,
                            controller: pickUpContactName,
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
                              return Validator.requiredValidator(
                                  pickUpContactName.text);
                            },
                          ),
                        ),
                        PhoneNumberFieldWidget(
                            countryCode: pickUpCountryCode,
                            phoneNumber: pickUpContactNumber),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 6),
                          child: RebiInput(
                            hintText: 'Number Of Horses'.tra,
                            controller: numberOfHorses,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(2),
                              // Limit input to 2 characters
                              FilteringTextInputFormatter.digitsOnly,
                              // Only allow digits
                            ],
                            isOptional: false,
                            color: AppColors.formsLabel,
                            readOnly: false,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            obscureText: false,
                            validator: (value) {
                              return Validator.requiredValidator(
                                  numberOfHorses.text);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: kPadding),
                          child: DropDownWidget(
                            items: equipments,
                            selected: selectedEquipment,
                            onChanged: (gender) {
                              setState(() {
                                selectedEquipment = gender;
                                Print('Tack & Equipment $selectedEquipment');
                              });
                            },
                            validator: (value) {
                              // return Validator.requiredValidator(selectedNumber);
                            },
                            hint: 'Tack & Equipment',
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    BlocConsumer<ShippingCubit, ShippingState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is CreateShippingSuccessfully) {
                          RebiMessage.success(
                              msg: "Saved as draft successfully",
                              context: context);

                          shippingId = state.responseModel.id!;
                        } else if (state is CreateShippingError) {
                          RebiMessage.error(
                              msg: state.message!, context: context);
                        }
                      },
                      builder: (context, state) {
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: TextButton(
                              onPressed: () {
                                phoneNumber = pickUpCountryCode.text +
                                    pickUpContactNumber.text.replaceAll(' ', '');
                                Print(phoneNumber);
                                _onPressSaveDraft();
                              },
                              child: const Text(
                                "Save as draft",
                                style: TextStyle(
                                  color: Color(0xFF232F39),
                                  fontSize: 14,
                                  fontFamily: 'Noto Sans',
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline,
                                ),
                              )),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: RebiButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() && selectedEquipment !=null) {
                              phoneNumber = pickUpCountryCode.text +
                                  pickUpContactNumber.text.replaceAll(' ', '');
                              if (widget.isFromEditing) {
                                DateFormat formatter =
                                    DateFormat('dd MMM yyyy');
                                formatted =
                                    formatter.format(widget.estimatedDate!);
                              }
                              Print(phoneNumber);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImportSecondStepScreen(
                                      shippingId: shippingId,
                                      selectedEquipment: selectedEquipment!,
                                      importCountry: pickupCountry.text,
                                      estimatedDate: pickDate.toIso8601String(),
                                      pickupContactName: pickUpContactName.text,
                                      pickupContactNumber:
                                          pickUpCountryCode.text +
                                              pickUpContactNumber.text.replaceAll(' ', ''),
                                      numberOfHorses: numberOfHorses.text,
                                      location: ChooseLocation(
                                          lat: latitude.text,
                                          lng: long.text,
                                          name: dropLocation.text)),
                                ),
                              );
                            }else{

                                RebiMessage.error(msg: "Some data are missing.", context: context);
                              
                            }
                          },
                          child: Text(
                            "Next",
                            style: AppStyles.buttonStyle,
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  _onPressSaveDraft() {
    cubit.createShipping(CreateShippingRequestModel(
        type: 'Import',
        // placeId: int.parse(placeId.text),
        pickUpContactName: pickUpContactName.text,
        pickUpPhoneNumber: pickUpCountryCode.text + pickUpContactNumber.text.replaceAll(' ', ''),
        pickUpCountry: pickupCountry.text,
        dropCountry: 'United Arab Emirates',
        numberOfHorses: numberOfHorses.text.isNotEmpty
            ? int.parse(numberOfHorses.text)
            : null,
        pickUpDate: pickDate.toIso8601String(),
        tackAndEquipment: selectedEquipment ?? 'No Tack',
        chooseLocation: ChooseLocation(
            lat: latitude.text, lng: long.text, name: dropLocation.text)));
  }
}
