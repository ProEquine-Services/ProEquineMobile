import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:proequine_dev/core/constants/colors/app_colors.dart';
import 'package:proequine_dev/core/constants/constants.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/utils/rebi_message.dart';
import 'package:proequine_dev/core/widgets/phone_number_field_widget.dart';
import 'package:proequine_dev/features/home/data/trip_service_data_model.dart';
import 'package:proequine_dev/features/home/domain/cubits/home_cubit.dart';
import 'package:proequine_dev/features/transports/presentation/screens/chose_horses_trip_screen.dart';
import 'package:proequine_dev/features/home/presentation/widgets/select_date_time_widget.dart';
import 'package:proequine_dev/features/home/presentation/widgets/select_place_widget.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../manage_account/data/verify_email_route.dart';

class CreateTripScreen extends StatefulWidget {
  final String? type;

  const CreateTripScreen({super.key, this.type});

  @override
  CreateTripScreenState createState() => CreateTripScreenState();
}

class CreateTripScreenState extends State<CreateTripScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController pickUpLocationUrl = TextEditingController();
  TextEditingController dropOfLocationUrl = TextEditingController();

  TextEditingController dropLocation = TextEditingController();
  TextEditingController selectHospital = TextEditingController();
  TextEditingController pickUpContactName = TextEditingController();
  TextEditingController dropContactName = TextEditingController();
  TextEditingController pickUpContactNumber = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController long = TextEditingController();
  TextEditingController pickupPlaceId = TextEditingController();
  TextEditingController dropPlaceId = TextEditingController();
  TextEditingController placeId = TextEditingController();
  TextEditingController numberOfHorses = TextEditingController();
  TextEditingController dropContactNumber = TextEditingController();
  TextEditingController pickUpCountryCode = TextEditingController(text: '+971');
  TextEditingController dropCountryCode = TextEditingController(text: '+971');
  DateTime focusedDay = DateTime.now();
  TextEditingController? date;
  TextEditingController? expectedDate;
  late DateTime dateTime;
  late DateTime expectedDateTime;
  late DateTime pickDate;
  late DateTime exDropDate;
  late DateTime expectedPickDate;

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

  DateTime? time;
  DateTime? expectedTime;
  late TextEditingController? timePicked;
  late TextEditingController? expectedTimePicked;

  Future<bool> checkVerificationStatus() async {
    if (AppSharedPreferences.getEmailVerified!) {
      return true;
    } else {
      await Future.delayed(
          const Duration(milliseconds: 50)); // Simulating an asynchronous call
      return false;
    }
  }

  String? selectedTrip;
  String? selectedHospital;
  int? selectedPlace;

  @override
  void initState() {
    checkVerificationStatus().then((verified) {
      //here just add ! before verified
      if (!verified) {
        // If the account is not verified, show a dialog after a delay.
        Future.delayed(const Duration(milliseconds: 50), () {
          showUnverifiedAccountDialog(
            context: context,
            isThereNavigationBar: true,
            onPressVerify: () {
              Navigator.pushNamed(context, verifyEmail,
                      arguments: VerifyEmailRoute(
                          type: widget.type ?? 'createTrip',
                          email: AppSharedPreferences.userEmailAddress))
                  .then((value) {});
            },
          );
        });
      }
    });
    initializeDateFormatting();
    pickDate = DateTime.now();

    Print(widget.type);
    dateTime = DateTime.now();
    exDropDate = DateTime.now();
    expectedPickDate = DateTime.now().add(const Duration(days: 1));
    expectedDateTime = DateTime.now().add(const Duration(days: 1));
    date = TextEditingController();
    expectedDate = TextEditingController();
    timePicked = TextEditingController();
    expectedTimePicked = TextEditingController();
    time = DateTime.utc(0, 0, 0, 15, 0);
    expectedTime = DateTime.utc(0, 0, 0, 15, 0);
    selectedTrip = "Return";

    super.initState();
  }

  bool? isEmailVerified = false;
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 0)) {
      currentBackPressTime = now;
      context.watch<HomeCubit>().getAllSelectiveServices(limit: 4,showOnHomePage: true);
      return Future.value(true);
    }
    return Future.value(true);
  }

  @override
  void dispose() {
    date?.dispose();
    expectedDate?.dispose();
    timePicked?.dispose();
    expectedTimePicked?.dispose();
    super.dispose();
  }

  String? selectedNumber;
  String? pickPhoneNumber;
  String? dropPhoneNumber;

  @override
  Widget build(BuildContext context) {
    var myCubit=context.watch<HomeCubit>();
    isEmailVerified = ModalRoute.of(context)?.settings.arguments as bool?;
    expectedDateTime = pickDate.add(const Duration(days: 1));
    isEmailVerified ??= false;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
              widget.type == 'hospital'
                  ? "Hospital Transport"
                  : "Local Transport",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: "notosan",
                  fontWeight: FontWeight.w600,
                  color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                      ? Colors.white
                      : AppColors.blackLight)),
          centerTitle: true,
          backgroundColor:
              AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
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
                      myCubit.getAllSelectiveServices(limit: 4,showOnHomePage: true);
                      Navigator.pop(context);
                    }
                  },
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color:
                        AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                            ? Colors.white
                            : AppColors.backgroundColor,
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
                          widget.type == 'hospital'
                              ? const SizedBox(
                                  height: 15,
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding,
                                    vertical: kPadding,
                                  ),
                                  child: Center(
                                    child: CupertinoPageScaffold(
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.borderColor),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: CupertinoSlidingSegmentedControl<
                                            String>(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1, horizontal: 2),
                                          thumbColor: AppColors.gold,
                                          backgroundColor: Colors.white,
                                          children: {
                                            "OneWay": Container(
                                              width: 350,
                                              height: 30,
                                              margin: const EdgeInsets.only(
                                                  top: 2,
                                                  right: 0,
                                                  left: 2,
                                                  bottom: 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Center(
                                                child: Text(
                                                  "One way",
                                                  style: TextStyle(
                                                      color: selectedTrip ==
                                                              'OneWay'
                                                          ? AppColors.white
                                                          : AppColors
                                                              .backgroundColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                            "Return": Container(
                                              width: 350,
                                              height: 30,
                                              margin: const EdgeInsets.only(
                                                  top: 2,
                                                  right: 2,
                                                  left: 0,
                                                  bottom: 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Center(
                                                child: Text(
                                                  "Return",
                                                  style: TextStyle(
                                                      color: selectedTrip ==
                                                              'Return'
                                                          ? AppColors.white
                                                          : AppColors
                                                              .backgroundColor,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ),
                                          },
                                          groupValue: selectedTrip,
                                          onValueChanged: (value) {
                                            setState(() {
                                              selectedTrip = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          SelectPlaceWidget(
                            placeName: pickUpLocation,
                            lat: latitude,
                            hintText: 'Pickup Location',
                            lng: long,
                            selectedPlaceId: pickupPlaceId,
                            changeTrue: changeToTrueValue,
                            changeFalse: changeToFalseValue,
                            category: "Normal",
                          ),
                          SelectDateAndTimeWidget(
                              time: time!,
                              timeController: timePicked!,
                              from: DateTime.now(),
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  DateFormat inputFormat =
                                      DateFormat("dd MMM yyyy");
                                  DateTime setUpdatedDate =
                                      inputFormat.parse(value);
                                  pickDate = setUpdatedDate;
                                } else {
                                  return '';
                                }

                                if (dateTime.isBefore(DateTime.now()) &&
                                    !dateTime.isSameDate(DateTime.now())) {
                                  return 'correct date please';
                                }
                                return Validator.requiredValidator(date!.text);
                              },
                              pickedDate: pickDate,
                              dateController: date!),
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: kPadding),
                            child: CustomDivider(),
                          ),
                          widget.type == 'hospital' || widget.type == 'Hospital'
                              ? SelectPlaceWidget(
                                  placeName: dropLocation,
                                  lat: latitude,
                            hintText: 'Drop Location',
                                  lng: long,
                                  selectedPlaceId: dropPlaceId,
                                  changeTrue: changeToTrueValue,
                                  category: "Hospital",
                                  changeFalse: changeToFalseValue,
                                )
                              : SelectPlaceWidget(
                                  placeName: dropLocation,
                                  lat: latitude,
                            hintText: 'Drop Location',
                                  lng: long,
                                  selectedPlaceId: dropPlaceId,
                                  changeTrue: changeToTrueValue,
                                  category: widget.type == 'hospital'
                                      ? "Hospital"
                                      : "Normal",
                                  changeFalse: changeToFalseValue,
                                ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: kPadding,
                                left: kPadding,
                                top: 6,
                                bottom: 6),
                            child: RebiInput(
                              hintText: 'Drop Contact Name'.tra,
                              controller: dropContactName,
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
                                    dropContactName.text);
                              },
                            ),
                          ),
                          PhoneNumberFieldWidget(
                              countryCode: dropCountryCode,
                              phoneNumber: dropContactNumber),
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
                              needToMessage: true,
                              validator: (value) {
                                return Validator.validateHorseNumber(
                                    numberOfHorses.text);
                              },
                            ),
                          ),
                          widget.type == 'hospital'
                              ? const SizedBox()
                              : Visibility(
                                  visible:
                                      selectedTrip == 'OneWay' ? false : true,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 6),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: RebiInput(
                                            hintText: 'Return Date'.tra,
                                            controller: expectedDate,
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.done,
                                            onTap: () {
                                              selectDate(
                                                context: context,
                                                from: pickDate.add(
                                                    const Duration(days: 1)),
                                                to: DateTime(2025, 1, 1),
                                                isSupportChangingYears: false,
                                                selectedOurDay: pickDate.add(
                                                    const Duration(days: 1)),
                                                controller: expectedDate!,
                                                focusDay: focusedDay,
                                              );
                                            },
                                            autoValidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            isOptional: false,
                                            color: AppColors.formsLabel,
                                            readOnly: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 13),
                                            obscureText: false,
                                            validator: (value) {
                                              DateFormat inputFormat =
                                                  DateFormat("dd MMM yyyy");
                                              DateTime setUpdatedDate =
                                                  inputFormat.parse(value!);
                                              exDropDate = setUpdatedDate;

                                              return Validator
                                                  .requiredValidator(
                                                      expectedDate?.text);
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: RebiInput(
                                            hintText:
                                                expectedTimePicked!.text.isEmpty
                                                    ? 'Return Time'
                                                    : expectedTimePicked?.text,
                                            controller: expectedTimePicked,
                                            onTap: () async {
                                              TimeOfDay? pickedTime =
                                                  await showTimePicker(
                                                confirmText: "Confirm".tra,
                                                context: context,
                                                cancelText: "Cancel".tra,
                                                initialEntryMode:
                                                    TimePickerEntryMode.dial,
                                                initialTime:
                                                    TimeOfDay.fromDateTime(
                                                        DateTime.utc(
                                                            0, 0, 0, 15, 0)),
                                              );

                                              Print(pickedTime);

                                              if (pickedTime != null) {
                                                expectedTime =
                                                    pickedTime.toDateTime();
                                                //output 10:51 PM
                                                String parsedTime =
                                                    pickedTime.format(context);

                                                setState(() {
                                                  expectedTimePicked?.text =
                                                      parsedTime;
                                                });
                                              } else {}
                                            },
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 13),
                                            isOptional: false,
                                            readOnly: true,
                                            validator: (value) {
                                              if (value!.isNotEmpty &&
                                                  expectedPickDate
                                                      .isSameDate(pickDate) &&
                                                  expectedTime!
                                                      .isBefore(time!)) {
                                                return 'Correct time please';
                                              }
                                              // return Validator.requiredValidator(
                                              //     expectedTimePicked?.text);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: RebiButton(
                            onPressed: () {
                              pickPhoneNumber = pickUpCountryCode.text +
                                  pickUpContactNumber.text;
                              dropPhoneNumber =
                                  dropCountryCode.text + dropContactNumber.text;
                              if (widget.type == 'hospital') {
                                if (_formKey.currentState!.validate() &&
                                    numberOfHorses.text.isNotEmpty) {
                                  TripServiceDataModel tripServiceModel =
                                      TripServiceDataModel(
                                    expectedTime: expectedTimePicked?.text,
                                    expectedDate: exDropDate,
                                    pickupLocationUrl: pickUpLocationUrl.text,
                                    pickupContactName: pickUpContactName.text,
                                    pickupContactNumber: pickPhoneNumber!.replaceAll(' ', ''),
                                    showingDate: date!.text,
                                    trip: 'hospital',
                                    dropContactName: dropContactName.text,
                                    dropContactNumber: dropCountryCode.text +
                                        dropContactNumber.text.replaceAll(' ', ''),
                                    hospitalName: selectedHospital,
                                    horsesNumber: numberOfHorses.text,
                                    tripType: selectedTrip ?? "Hospital",
                                    pickupDate: pickDate,
                                    pickupTime: timePicked!.text,
                                    pickupLocation: pickUpLocation.text,
                                  );
                                  if (selectedTrip == "OneWay") {
                                    Print("OneWay");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ChoseTripHorseScreen(
                                          tripServiceDataModel:
                                              tripServiceModel,
                                          pickupPlaceId:
                                              int.parse(pickupPlaceId.text),
                                          dropPlaceId:
                                              int.parse(dropPlaceId.text),
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChoseTripHorseScreen(
                                                  tripServiceDataModel:
                                                      tripServiceModel,
                                                  pickupPlaceId: int.parse(
                                                      pickupPlaceId.text),
                                                  dropPlaceId: int.parse(
                                                      dropPlaceId.text),
                                                )));
                                  }
                                } else {
                                  RebiMessage.error(
                                      msg: "Some data are missing.",
                                      context: context);
                                }
                              } else {
                                if (_formKey.currentState!.validate() &&
                                    numberOfHorses.text.isNotEmpty) {
                                  TripServiceDataModel tripServiceModel =
                                      TripServiceDataModel(
                                    pickupLocationUrl: pickUpLocationUrl.text,
                                    dropOffLocationUrl: dropOfLocationUrl.text,
                                    expectedTime: expectedTimePicked?.text,
                                    expectedDate: exDropDate,
                                    pickupContactName: pickUpContactName.text,
                                    pickupContactNumber: pickPhoneNumber!.replaceAll(' ', ''),
                                    trip: 'local',
                                    showingDate: date!.text,
                                    dropContactName: dropContactName.text,
                                    dropContactNumber: dropPhoneNumber!.replaceAll(' ', ''),
                                    dropLocation: dropLocation.text,
                                    horsesNumber: numberOfHorses.text,
                                    tripType: selectedTrip!,
                                    pickupDate: pickDate,
                                    pickupTime: timePicked!.text,
                                    pickupLocation: pickUpLocation.text,
                                  );
                                  if (selectedTrip == "OneWay") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChoseTripHorseScreen(
                                                  tripServiceDataModel:
                                                      tripServiceModel,
                                                  pickupPlaceId: int.parse(
                                                      pickupPlaceId.text),
                                                  dropPlaceId: int.parse(
                                                      dropPlaceId.text),
                                                )));
                                  } else if ((selectedTrip == "Return" &&
                                      exDropDate.isBefore(pickDate))) {
                                    RebiMessage.error(
                                        msg:
                                            "please enter the correct expected Date",
                                        context: context);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChoseTripHorseScreen(
                                                  tripServiceDataModel:
                                                      tripServiceModel,
                                                  pickupPlaceId: int.parse(
                                                      pickupPlaceId.text),
                                                  dropPlaceId: int.parse(
                                                      dropPlaceId.text),
                                                )));
                                  }
                                } else {
                                  RebiMessage.error(
                                      msg: "Some data are missing.",
                                      context: context);
                                }
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
      ),
    );
  }
}
