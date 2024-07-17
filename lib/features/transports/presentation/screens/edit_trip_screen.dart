import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/phone_number_field_widget.dart';
import 'package:proequine/features/home/data/trip_service_data_model.dart';
import 'package:proequine/features/transports/data/create_transport_response_model.dart';
import 'package:proequine/features/transports/domain/transport_cubit.dart';
import 'package:proequine/features/transports/presentation/screens/chose_horses_trip_screen.dart';
import 'package:proequine/features/home/presentation/widgets/select_date_time_widget.dart';
import 'package:proequine/features/home/presentation/widgets/select_place_widget.dart';
import 'package:proequine/features/transports/presentation/screens/edit_show_horses_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/delete_popup.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/update_shipping_header.dart';
import '../../../../core/widgets/verify_dialog.dart';
import '../../../manage_account/data/verify_email_route.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';

class EditTripScreen extends StatefulWidget {
  final String? type;
  final TransportModel? model;
  bool selectiveRequest;

  EditTripScreen(
      {super.key, this.type, this.model, this.selectiveRequest = false});

  @override
  EditTripScreenState createState() => EditTripScreenState();
}

class EditTripScreenState extends State<EditTripScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController pickUpLocation;

  late TextEditingController dropLocation;
  TextEditingController selectHospital = TextEditingController();
  late TextEditingController pickUpContactName;
  late TextEditingController dropContactName;
  late TextEditingController pickUpContactNumber;
  late TextEditingController pickLatitude;

  late TextEditingController pickLong;
  late TextEditingController dropLatitude;

  late TextEditingController dropLong;

  late TextEditingController pickupPlaceId;

  late TextEditingController dropPlaceId;

  late TextEditingController numberOfHorses;
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

  String convertToTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return time;
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

  DateTime? time;
  DateTime? expectedTime;
  late TextEditingController? timePicked;
  TextEditingController? expectedTimePicked = TextEditingController();

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
      if (verified) {
        // If the account is not verified, show a dialog after a delay.
        Future.delayed(const Duration(milliseconds: 50), () {
          showUnverifiedAccountDialog(
            context: context,
            isThereNavigationBar: true,
            onPressVerify: () {
              Navigator.pushNamed(context, verifyEmail,
                      arguments: VerifyEmailRoute(
                          type: 'createTrip',
                          email: AppSharedPreferences.userEmailAddress))
                  .then((value) {});
            },
          );
        });
      }
    });
    initializeDateFormatting();
    Print("widget typeeee ${widget.type}");
    Print("widget pick phone ${widget.model!.pickUpPhoneNumber}");
    pickUpLocation =
        TextEditingController(text: widget.model!.pickPlace!.name!);
    dropLocation = TextEditingController(text: widget.model!.dropPlace!.name!);
    dropLong = TextEditingController(text: widget.model!.dropPlace!.lng!);
    dropLatitude = TextEditingController(text: widget.model!.dropPlace!.lat!);
    dropPlaceId =
        TextEditingController(text: widget.model!.dropPlace!.id!.toString());
    pickLong = TextEditingController(text: widget.model!.pickPlace!.lng!);
    pickLatitude = TextEditingController(text: widget.model!.pickPlace!.lat!);
    pickupPlaceId =
        TextEditingController(text: widget.model!.pickPlace!.id!.toString());
    pickUpContactName =
        TextEditingController(text: widget.model!.pickUpContactName!);
    // if(widget.type!='Hospital'){
    pickUpContactNumber = TextEditingController(
        text: widget.model!.pickUpPhoneNumber!.substring(4));
    if (widget.model!.dropPhoneNumber!.isNotEmpty) {
      dropContactNumber = TextEditingController(
          text: widget.model!.dropPhoneNumber!.substring(4));
    }

    // }
    dropContactName =
        TextEditingController(text: widget.model!.dropContactName!);
    numberOfHorses =
        TextEditingController(text: widget.model!.numberOfHorses.toString());
    DateTime parsedPickDate = DateTime.parse(widget.model!.pickUpDate!);
    if (widget.model!.returnDate != null) {
      if (widget.model!.returnDate!.isNotEmpty) {
        DateTime parsedDropDate = DateTime.parse(widget.model!.returnDate!);
        DateFormat format = DateFormat('dd MMM yyyy');
        String dropDateString = format.format(parsedDropDate);
        expectedDate = TextEditingController(text: dropDateString);
        exDropDate = DateTime.parse(widget.model!.returnDate!);
        expectedTimePicked =
            TextEditingController(text: widget.model!.returnTime);
      }
    } else {}

    DateFormat format = DateFormat('dd MMM yyyy');
    String dateString = format.format(parsedPickDate);

    pickDate = DateTime.parse(widget.model!.pickUpDate!);
    dateTime = DateTime.parse(widget.model!.pickUpDate!);
    expectedPickDate = DateTime.now().add(const Duration(days: 1));
    expectedDateTime = DateTime.now().add(const Duration(days: 1));
    date = TextEditingController(text: dateString);

    timePicked = TextEditingController(text: widget.model!.pickUpTime);
    time = DateTime.utc(0, 0, 0, 15, 0);
    expectedTime = DateTime.utc(0, 0, 0, 15, 0);

    selectedTrip = widget.type;

    super.initState();
  }

  bool? isEmailVerified = false;
  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 0)) {
      currentBackPressTime = now;
      return Future.value(true);
    }
    return Future.value(true);
  }

  TransportCubit cubit = TransportCubit();

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
    isEmailVerified = ModalRoute.of(context)?.settings.arguments as bool?;
    expectedDateTime = pickDate.add(const Duration(days: 1));
    isEmailVerified ??= false;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(10.0.h),
          child: UpdateShippingHeader(
            title: widget.type == 'Hospital'
                ? "Edit Hospital Transport"
                : widget.type == 'Show'
                    ? "Edit Show Transport"
                    : "Edit Local Transport",
            thirdOptionTitle: 'Cancel',
            onPressThirdOption: () {
              deleteDialog(
                  context: context,
                  deleteButton: BlocConsumer<TransportCubit, TransportState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is RemoveTripSuccessfully) {
                        RebiMessage.success(
                            msg: state.message, context: context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavigation(
                                      selectedIndex: 1,
                                    )));
                      } else if (state is RemoveTripError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      }
                    },
                    builder: (context, state) {
                      if (state is RemoveTripLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.red,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(AppColors.red),
                          ),
                        );
                      }
                      return RebiButton(
                          height: 35,
                          backgroundColor: AppColors.red,
                          onPressed: () {
                            _onPressDelete();
                          },
                          child: Text(
                            "I'm sure",
                            style: AppStyles.buttonStyle,
                          ));
                    },
                  ),
                  title: "Are you sure you want to cancel this trip");
            },
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
                          widget.type == 'hospital' ||
                                  widget.type == 'Hospital' ||
                                  widget.type == 'Show'
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
                            lat: pickLatitude,
                            hintText: 'Pickup Location',
                            lng: pickLong,
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
                                DateFormat inputFormat =
                                    DateFormat("dd MMM yyyy");
                                DateTime setUpdatedDate =
                                    inputFormat.parse(value!);
                                pickDate = setUpdatedDate;
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
                          Visibility(
                            visible: widget.type == 'Show' ? false : true,
                            child: Column(
                              children: [
                                widget.type == 'hospital' ||
                                        widget.type == 'Hospital'
                                    ? SelectPlaceWidget(
                                        placeName: dropLocation,
                                        hintText: 'Drop Location',
                                        lat: dropLatitude,
                                        lng: dropLong,
                                        selectedPlaceId: dropPlaceId,
                                        changeTrue: changeToTrueValue,
                                        category: widget.type == 'hospital' ||
                                                widget.type == 'Hospital'
                                            ? "Hospital"
                                            : "Normal",
                                        changeFalse: changeToFalseValue,
                                      )
                                    : SelectPlaceWidget(
                                        placeName: dropLocation,
                                        hintText: 'Drop Location',
                                        lat: dropLatitude,
                                        lng: dropLong,
                                        selectedPlaceId: dropPlaceId,
                                        changeTrue: changeToTrueValue,
                                        category: widget.type == 'hospital' ||
                                                widget.type == 'Hospital'
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
                              ],
                            ),
                          ),
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
                          widget.type == 'hospital' || widget.type == 'Hospital'
                              ? const SizedBox()
                              : Visibility(
                                  visible:
                                      selectedTrip == 'OneWay' || selectedTrip=='Show' ? false : true,
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
                              if (widget.type == 'Show') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditShowHorsesScreen(
                                      id: widget.model!.id,
                                      dropPlaceId: int.parse(dropPlaceId.text),
                                      tripServiceDataModel:
                                          TripServiceDataModel(
                                              pickupLocation:
                                                  pickUpLocation.text,
                                              tripType: 'Show',
                                              trip: 'Show',
                                              pickupContactName:
                                                  pickUpContactName.text,
                                              pickupContactNumber:
                                                  pickUpCountryCode.text +
                                                      pickUpContactNumber.text,
                                              pickupDate: pickDate,
                                              pickupTime: timePicked!.text,
                                              dropContactName:
                                                  dropContactName.text,
                                              dropContactNumber:
                                                  dropContactNumber.text,
                                              horsesNumber: numberOfHorses.text,
                                              showingDate: ''),
                                      pickupPlaceId:
                                          int.parse(pickupPlaceId.text),
                                    ),
                                  ),
                                );
                              } else {}
                              pickPhoneNumber = pickUpCountryCode.text +
                                  pickUpContactNumber.text;

                              dropPhoneNumber =
                                  dropCountryCode.text + dropContactNumber.text;
                              if (widget.type == 'hospital' ||
                                  widget.type == 'Hospital') {
                                if (_formKey.currentState!.validate() &&
                                    numberOfHorses.text.isNotEmpty) {
                                  TripServiceDataModel tripServiceModel =
                                      TripServiceDataModel(
                                    expectedTime: expectedTimePicked?.text,
                                    expectedDate: exDropDate,
                                    pickupLocationUrl: 'pickUpLocationUrl.text',
                                    pickupContactName: pickUpContactName.text,
                                    pickupContactNumber: pickPhoneNumber!,
                                    showingDate: date!.text,
                                    trip: 'hospital',
                                    dropContactName: dropContactName.text,
                                    dropContactNumber: dropCountryCode.text +
                                        dropContactNumber.text,
                                    hospitalName: selectedHospital,
                                    horsesNumber: numberOfHorses.text,
                                    tripType: selectedTrip ?? "Hospital",
                                    pickupDate: pickDate,
                                    pickupTime: timePicked!.text,
                                    pickupLocation: pickUpLocation.text,
                                  );
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChoseTripHorseScreen(
                                                edit: true,
                                                note: widget.model!.notes,
                                                id: widget.model!.id,
                                                tripServiceDataModel:
                                                    tripServiceModel,
                                                pickupPlaceId: int.parse(
                                                    pickupPlaceId.text),
                                                dropPlaceId:
                                                    int.parse(dropPlaceId.text),
                                              )));
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
                                    pickupLocationUrl: 'pickUpLocationUrl.text',
                                    dropOffLocationUrl:
                                        'dropOfLocationUrl.text',
                                    expectedTime: expectedTimePicked?.text,
                                    expectedDate: exDropDate,
                                    pickupContactName: pickUpContactName.text,
                                    pickupContactNumber: pickPhoneNumber!,
                                    trip: 'local',
                                    showingDate: date!.text,
                                    dropContactName: dropContactName.text,
                                    dropContactNumber: dropPhoneNumber!,
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
                                                  edit: true,
                                                  id: widget.model!.id,
                                                  note: widget.model!.notes,
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
                                                  edit: true,
                                                  note: widget.model!.notes,
                                                  id: widget.model!.id,
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

  _onPressDelete() {
    cubit.removeTrip(widget.model!.id!);
  }
}
