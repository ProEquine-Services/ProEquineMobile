import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/home/data/trip_service_data_model.dart';
import 'package:proequine/features/home/presentation/screens/chose_horses_shows_screen.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/phone_number_field_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../shipping/data/selective_service_response_model.dart';
import '../../../shipping/domain/shipping_cubit.dart';
import '../widgets/select_date_time_widget.dart';
import '../widgets/select_place_widget.dart';

class JoinShowScreen extends StatefulWidget {
  final SelectiveServiceModel model;

  const JoinShowScreen({super.key, required this.model});

  @override
  State<JoinShowScreen> createState() => _JoinShowScreenState();
}

class _JoinShowScreenState extends State<JoinShowScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController pickUpContactName = TextEditingController();
  TextEditingController numberOfHorses = TextEditingController();
  TextEditingController pickUpContactNumber = TextEditingController();
  TextEditingController pickupPlaceId = TextEditingController();

  TextEditingController pickUpCountryCode = TextEditingController(text: '+971');

  TextEditingController dropLocation = TextEditingController();
  TextEditingController dropContactName = TextEditingController();
  TextEditingController dropContactNumber = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController long = TextEditingController();
  String? selectedEquipment;
  DateTime? time;
  TextEditingController? date;
  TextEditingController? expectedDate;
  late DateTime dateTime;
  late DateTime pickDate;
  late TextEditingController? timePicked;

  @override
  void initState() {
    initializeDateFormatting();
    pickDate = DateTime.now();

    dateTime = DateTime.now();
    date = TextEditingController();
    expectedDate = TextEditingController();
    timePicked = TextEditingController();

    time = DateTime.utc(0, 0, 0, 15, 0);

    super.initState();
  }

  String? formatted;

  @override
  void dispose() {
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

  ShippingCubit cubit = ShippingCubit();

  @override
  Widget build(BuildContext context) {
    String formatDate(DateTime date) {
      // Define the date format
      final dateFormat = DateFormat("MMMM d, yyyy");
      // Format the date
      final formattedDate = dateFormat.format(date);
      return formattedDate;
    }

    String formatStartDate(DateTime date) {
      // Define the date format
      final dateFormat = DateFormat("MMMM d,");
      // Format the date
      final formattedDate = dateFormat.format(date);
      return formattedDate;
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Show Transport",
            style: TextStyle(
                fontSize: 17,
                fontFamily: "notosan",
                fontWeight: FontWeight.w600,
                color: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                    ? Colors.white
                    : AppColors.blackLight)),
        centerTitle: true,
        backgroundColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
            ? Colors.white
            : AppColors.white,
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
                    Container(
                        width: double.infinity,
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.model.title!,
                                style: const TextStyle(
                                    color: AppColors.blackLight,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(AppIcons.mapPin),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.model.place?.code ??
                                        'Not identifire',
                                    style: AppStyles.bookingContent,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Transform.translate(
                                      offset: const Offset(0.0, 3.0),
                                      child: SvgPicture.asset(
                                        AppIcons.dateIcon,
                                        color: AppColors.gold,
                                      )),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    formatStartDate(DateTime.parse(
                                        widget.model.startDate!)),
                                    style: AppStyles.bookingContent,
                                  ),
                                  Transform.translate(
                                      offset: const Offset(0.0, -5.0),
                                      child: const Text(' - ')),
                                  Text(
                                    formatDate(
                                        DateTime.parse(widget.model.endDate!)),
                                    style: AppStyles.bookingContent,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        SelectPlaceWidget(
                          hintText: 'Pickup Location',
                          placeName: dropLocation,
                          lat: latitude,
                          lng: long,
                          selectedPlaceId: pickupPlaceId,
                          changeTrue: changeToTrueValue,
                          category: "Normal",
                          changeFalse: changeToFalseValue,
                        ),
                        SelectDateAndTimeWidget(
                            time: time!,
                            to: DateTime.parse(widget.model.endDate!),
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
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: RebiButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChoseShowHorsesScreen(
                                    id: widget.model.id,
                                    tripServiceDataModel: TripServiceDataModel(
                                        pickupLocation: pickUpLocation.text,
                                        tripType: 'Show',
                                        trip: 'Show',
                                        pickupContactName:
                                            pickUpContactName.text,
                                        showingDate: widget.model.startDate!,
                                        pickupContactNumber:
                                            pickUpCountryCode.text +
                                                pickUpContactNumber.text,
                                        pickupDate: dateTime,
                                        pickupTime: timePicked!.text,
                                        dropContactName: dropContactName.text,
                                        dropContactNumber:
                                            dropContactNumber.text,
                                        horsesNumber: numberOfHorses.text),
                                    pickupPlaceId:
                                        int.parse(pickupPlaceId.text),
                                  ),
                                ),
                              );
                            } else {
                              RebiMessage.error(
                                  msg: 'Some data are missing.',
                                  context: context);
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
}
