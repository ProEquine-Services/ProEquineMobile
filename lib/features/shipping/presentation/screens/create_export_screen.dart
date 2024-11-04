import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine_dev/core/constants/colors/app_colors.dart';
import 'package:proequine_dev/core/constants/constants.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/widgets/phone_number_field_widget.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';

import '../../../../core/widgets/verify_dialog.dart';
import '../../../home/presentation/widgets/select_place_widget.dart';
import '../../../manage_account/data/verify_email_route.dart';
import '../../data/create_shipping_request_model.dart';
import '../../domain/shipping_cubit.dart';
import 'export_second_step_screen.dart';

class CreateExportScreen extends StatefulWidget {
  bool isFromEditing = false;
  String? exportCountry;

  String? importCountry;

  DateTime? estimatedDate;

  CreateExportScreen({
    this.isFromEditing = false,
    this.exportCountry,
    this.importCountry,
    this.estimatedDate,
    super.key,
  });

  @override
  CreateExportScreenState createState() => CreateExportScreenState();
}

class CreateExportScreenState extends State<CreateExportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> checkBoxKey = GlobalKey<FormState>();
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController long = TextEditingController();
  TextEditingController placeId = TextEditingController();
  TextEditingController pickUpLocationUrl = TextEditingController();
  TextEditingController dropLocation = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController pickUpContactName = TextEditingController();
  TextEditingController dropContactName = TextEditingController();
  TextEditingController dropContactNumber = TextEditingController();
  TextEditingController dropContactCountryCode =
      TextEditingController(text: "+971");

  TextEditingController numberOfHorses = TextEditingController();
  TextEditingController exportingCountry = TextEditingController();
  TextEditingController pickupCountry = TextEditingController();
  TextEditingController pickUpContactNumber = TextEditingController();
  TextEditingController pickUpCountryCode = TextEditingController(text: '+971');
  DateTime focusedDay = DateTime.now();
  TextEditingController? estimatedDate;

  late DateTime dateTime;
  late DateTime pickDate;

  String? selectedTrip;
  String? selectedEquipment;
  String? selectedCountryIso2;
  String? formatted;

  @override
  void initState() {
    initializeDateFormatting();
    dateTime = DateTime.now();
    estimatedDate = TextEditingController();

    super.initState();
  }

  bool? isEmailVerified = false;
  DateTime? currentBackPressTime;
  String? phoneNumber;
  int? shippingId;
  ShippingCubit cubit = ShippingCubit();

  // Future<bool> onWillPop() {
  //   DateTime now = DateTime.now();
  //   if (currentBackPressTime == null ||
  //       now.difference(currentBackPressTime!) > const Duration(seconds: 0)) {
  //     currentBackPressTime = now;
  //     return Future.value(true);
  //   }
  //   return Future.value(true);
  // }

  @override
  void dispose() {
    estimatedDate?.dispose();
    super.dispose();
  }

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

  String? selectedNumber;
  bool equipmentValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Shipping Export",
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
                  if (isEmailVerified!) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: kPadding,
                          ),
                          child: Text(
                            'UAE delivery address',
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
                                horizontal: kPadding, vertical: 7),
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
                        SelectPlaceWidget(
                            placeName: pickUpLocation,
                            hintText: 'Pickup Location',
                            lat: latitude,
                            lng: long,
                            selectedPlaceId: placeId,
                            changeTrue: changeToTrueValue,
                            changeFalse: changeToFalseValue,
                            category: "Normal"),
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
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            isOptional: false,
                            color: AppColors.formsLabel,
                            readOnly: false,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            obscureText: false,
                            validator: (value) {
                              return Validator.validateHorseNumber(
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
                            onChanged: (equipment) {
                              setState(() {
                                selectedEquipment = equipment;
                              });
                            },
                            validator: (value) {
                              return Validator.requiredValidator(
                                  selectedEquipment);
                            },
                            hint: 'Equipment Tack',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14,
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
                                if (_formKey.currentState!.validate()) {
                                  phoneNumber = pickUpCountryCode.text +
                                      pickUpContactNumber.text;
                                  if (widget.isFromEditing) {}
                                  _onPressSaveDraft();
                                }
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
                            phoneNumber = pickUpCountryCode.text +
                                pickUpContactNumber.text;
                            if (widget.isFromEditing) {
                              DateFormat formatter = DateFormat('dd MMM yyyy');
                              formatted =
                                  formatter.format(widget.estimatedDate!);
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ExportSecondStepScreen(
                                          shippingId: shippingId,
                                          selectedEquipment: selectedEquipment!,
                                          importCountry: 'United Arab Emirates',
                                          estimatedDate:
                                              pickDate.toIso8601String(),
                                          pickupContactName:
                                              pickUpContactName.text,
                                          placeId: int.parse(placeId.text),
                                          pickupContactNumber:
                                              pickUpCountryCode.text +
                                                  pickUpContactNumber.text.replaceAll(' ', ''),
                                          numberOfHorses: numberOfHorses.text,
                                        )));
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
      type: 'Export',
      placeId: int.parse(placeId.text),
      pickUpContactName: pickUpContactName.text,
      pickUpPhoneNumber: pickUpCountryCode.text + pickUpContactNumber.text.replaceAll(' ', ''),
      pickUpCountry: "United Arab Emirates",
      numberOfHorses: int.parse(numberOfHorses.text),
      pickUpDate: pickDate.toIso8601String(),
      tackAndEquipment: selectedEquipment,
    ));
  }
}
