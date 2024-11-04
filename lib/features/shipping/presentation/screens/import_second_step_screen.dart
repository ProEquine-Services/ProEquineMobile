import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine_dev/core/constants/colors/app_colors.dart';
import 'package:proequine_dev/core/constants/constants.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/home/data/shipping_service_model.dart';
import 'package:proequine_dev/features/shipping/data/edit_shipping_request_model.dart';

import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';

import '../../../../core/widgets/phone_number_field_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../home/presentation/widgets/select_place_widget.dart';
import '../../data/create_shipping_request_model.dart';
import '../../domain/shipping_cubit.dart';
import 'chose_horses_shipping_screen.dart';

class ImportSecondStepScreen extends StatefulWidget {
  bool isFromEditing;
  String? exportCountry;
  int? shippingId;
  int? selectiveId;
  final String? pickupContactName;
  final String? pickupContactNumber;
  final String? numberOfHorses;
  final String selectedEquipment;
  final ChooseLocation location;

  String? importCountry;

  String? estimatedDate;

  ImportSecondStepScreen({
    this.isFromEditing = false,
    this.exportCountry,
    this.shippingId,
    this.importCountry,
    this.selectiveId,
    this.estimatedDate,
    super.key,
    this.pickupContactName,
    this.pickupContactNumber,
    this.numberOfHorses,
    required this.selectedEquipment,
    required this.location,
  });

  @override
  ImportSecondStepScreenState createState() => ImportSecondStepScreenState();
}

class ImportSecondStepScreenState extends State<ImportSecondStepScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController dropLocation = TextEditingController();
  TextEditingController dropContactName = TextEditingController();
  TextEditingController dropContactNumber = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController long = TextEditingController();
  TextEditingController placeId = TextEditingController();
  TextEditingController dropCountryCode = TextEditingController(text: '+971');
  DateTime focusedDay = DateTime.now();
  TextEditingController? estimatedDate;

  late DateTime dateTime;
  late DateTime pickDate;

  String convertToTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return time;
  }

  String? selectedCountryIso2;

  @override
  void initState() {
    initializeDateFormatting();
    if (widget.isFromEditing) {}
    pickDate = DateTime.now();
    dateTime = DateTime.now();
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
                        SelectPlaceWidget(
                            placeName: dropLocation,
                            lat: latitude,
                            hintText: 'Drop Location',
                            lng: long,
                            selectedPlaceId: placeId,
                            changeTrue: changeToTrueValue,
                            changeFalse: changeToFalseValue,
                            category: "Normal"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 6),
                          child: RebiInput(
                            hintText: 'Drop contact name'.tra,
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
                    const Spacer(),
                    widget.isFromEditing?const SizedBox():widget.shippingId != null
                        ? BlocConsumer<ShippingCubit, ShippingState>(
                            bloc: cubit,
                            listener: (context, state) {
                              if (state is EditShippingSuccessfully) {
                                RebiMessage.success(
                                    msg: "Saved as draft successfully",
                                    context: context);
                              } else if (state is EditShippingError) {
                                RebiMessage.error(
                                    msg: state.message!, context: context);
                              }
                            },
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding),
                                child: TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        phoneNumber = dropContactNumber.text +
                                            dropContactNumber.text;
                                        if (widget.isFromEditing) {
                                        } else {
                                          _onPressSaveDraft();
                                        }
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
                          )
                        : BlocConsumer<ShippingCubit, ShippingState>(
                            bloc: cubit,
                            listener: (context, state) {
                              if (state is CreateShippingSuccessfully) {
                                RebiMessage.success(
                                    msg: "Saved as draft successfully",
                                    context: context);
                              } else if (state is CreateShippingError) {
                                RebiMessage.error(
                                    msg: state.message!, context: context);
                              }
                            },
                            builder: (context, state) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kPadding),
                                child: TextButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        phoneNumber = dropContactNumber.text +
                                            dropContactNumber.text;
                                        if (widget.isFromEditing) {
                                        } else {
                                          _onPressSave();
                                        }
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
                            if (_formKey.currentState!.validate()) {
                              if (widget.isFromEditing) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChoseShippingHorseScreen(
                                              selectiveServiceId: widget.selectiveId,
                                              isItFromEditing: true,
                                              pickUpCountry:
                                              widget.importCountry!,
                                              dropCountry: 'United Arab Emirates',
                                              serviceModel: ShippingServiceModel(
                                                  dropPhoneNumber:
                                                  dropCountryCode.text +
                                                      dropContactNumber.text.replaceAll(' ', ''),
                                                  dropContactName:
                                                  dropContactName.text,
                                                  equipment:
                                                  widget.selectedEquipment,
                                                  location: widget.location,
                                                  placeId:
                                                  int.parse(placeId.text),
                                                  pickupContactName:
                                                  widget.pickupContactName!,
                                                  pickupLocation:
                                                  widget.importCountry!,
                                                  horsesNumber:
                                                  widget.numberOfHorses!,
                                                  pickupContactNumber:
                                                  widget.pickupContactNumber!.replaceAll(' ', ''),
                                                  shipmentEstimatedDate: pickDate,
                                                  selectedCountry:
                                                  widget.isFromEditing
                                                      ? widget.importCountry!
                                                      : selectedCountryIso2 ??
                                                      'AE',
                                                  serviceType: 'Import'),
                                            )));
                              }else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChoseShippingHorseScreen(
                                            pickUpCountry:
                                                widget.importCountry!,
                                            dropCountry: 'United Arab Emirates',
                                            serviceModel: ShippingServiceModel(
                                                dropPhoneNumber:
                                                    dropCountryCode.text +
                                                        dropContactNumber.text.replaceAll(' ', ''),
                                                dropContactName:
                                                    dropContactName.text,
                                                equipment:
                                                    widget.selectedEquipment,
                                                location: widget.location,
                                                placeId:
                                                    int.parse(placeId.text),
                                                pickupContactName:
                                                    widget.pickupContactName!,
                                                pickupLocation:
                                                    widget.importCountry!,
                                                horsesNumber:
                                                    widget.numberOfHorses!,
                                                pickupContactNumber:
                                                    widget.pickupContactNumber!.replaceAll(' ', ''),
                                                shipmentEstimatedDate: pickDate,
                                                selectedCountry:
                                                    widget.isFromEditing
                                                        ? widget.importCountry!
                                                        : selectedCountryIso2 ??
                                                            'AE',
                                                serviceType: 'Import'),
                                          )));
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
    );
  }

  _onPressSave() {
    cubit.createShipping(CreateShippingRequestModel(
      type: 'Import',
      placeId: int.parse(placeId.text),
      pickUpContactName: widget.pickupContactName,
      pickUpPhoneNumber: widget.pickupContactNumber!.replaceAll(' ', ''),
      pickUpCountry: widget.importCountry,
      dropCountry: 'United Arab Emirates',
      numberOfHorses: int.parse(widget.numberOfHorses!),
      pickUpDate: widget.estimatedDate,
      tackAndEquipment: widget.selectedEquipment,
      chooseLocation: widget.location,
    ));
  }

  _onPressSaveDraft() {
    cubit.editShipping(EditShippingRequestModel(
      id: widget.shippingId,
      type: 'Import',
      placeId: int.parse(placeId.text),
      pickUpContactName: widget.pickupContactName,
      dropPhoneNumber: dropContactNumber.text,
      dropContactName: dropContactName.text,
      pickUpPhoneNumber: widget.pickupContactNumber,
      pickUpCountry: widget.importCountry,
      dropCountry: 'United Arab Emirates',
      numberOfHorses: int.parse(widget.numberOfHorses!),
      pickUpDate: widget.estimatedDate,
      tackAndEquipment: widget.selectedEquipment,
      chooseLocation: widget.location,
    ));
  }
}
