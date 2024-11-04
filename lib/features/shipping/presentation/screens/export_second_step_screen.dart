import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/constants/colors/app_colors.dart';
import 'package:proequine_dev/core/constants/constants.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/home/data/shipping_service_model.dart';
import 'package:proequine_dev/features/shipping/data/edit_shipping_request_model.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';

import '../../../../core/widgets/phone_number_field_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../data/create_shipping_request_model.dart';
import '../../domain/shipping_cubit.dart';
import '../widgets/chose_location_widget.dart';
import 'chose_horses_shipping_screen.dart';

class ExportSecondStepScreen extends StatefulWidget {
  bool isFromEditing;

  String? exportCountry;
  int? selectiveId;
  final String? pickupContactName;
  final int? shippingId;
  final int? placeId;
  final String? pickupContactNumber;
  final String? numberOfHorses;
  final String? selectedEquipment;

  String? importCountry;

  String? estimatedDate;

  ExportSecondStepScreen({
    this.isFromEditing = false,
    this.exportCountry,
    this.selectiveId,
    this.importCountry,
    this.placeId,
    this.shippingId,
    this.estimatedDate,
    super.key,
    this.pickupContactName,
    this.pickupContactNumber,
    this.numberOfHorses,
    this.selectedEquipment,
  });

  @override
  ExportSecondStepScreenState createState() => ExportSecondStepScreenState();
}

class ExportSecondStepScreenState extends State<ExportSecondStepScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController dropLocation = TextEditingController();
  TextEditingController dropContactName = TextEditingController();
  TextEditingController dropContactNumber = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController long = TextEditingController();
  TextEditingController exportingCountry = TextEditingController();
  TextEditingController exportingCountryCode = TextEditingController();
  TextEditingController placeId = TextEditingController();
  TextEditingController dropCountryCode = TextEditingController(text: '+971');

  String? selectedCountryIso2;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
                            'Abroad Address',
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
                              hintText: 'Exporting country'.tra,
                              controller: exportingCountry,
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
                                      exportingCountry.text = country.name;
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
                                return Validator.requiredValidator(
                                    exportingCountry.text);
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
                    widget.isFromEditing
                        ? const SizedBox()
                        : widget.shippingId != null
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _onPressEditShipping();
                                          }
                                        },
                                        child: const Text(
                                          "Save as draft",
                                          style: TextStyle(
                                            color: Color(0xFF232F39),
                                            fontSize: 14,
                                            fontFamily: 'Noto Sans',
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline,
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
                                          if (_formKey.currentState!
                                              .validate()) {
                                            phoneNumber =
                                                dropContactNumber.text +
                                                    dropContactNumber.text.replaceAll(' ', '');
                                            if (widget.isFromEditing) {}
                                            _onPressSave();
                                          }
                                        },
                                        child: const Text(
                                          "Save as draft",
                                          style: TextStyle(
                                            color: Color(0xFF232F39),
                                            fontSize: 14,
                                            fontFamily: 'Noto Sans',
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline,
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
                                              isItFromEditing: true,
                                              selectiveServiceId:
                                                  widget.selectiveId,
                                              pickUpCountry:
                                                  'United Arab Emirates',
                                              dropCountry:
                                                  widget.exportCountry!,
                                              serviceModel: ShippingServiceModel(
                                                  placeId: widget.placeId,
                                                  location: ChooseLocation(
                                                      lat: latitude.text,
                                                      lng: long.text,
                                                      name: dropLocation.text),
                                                  equipment:
                                                      widget.selectedEquipment,
                                                  dropContactName:
                                                      dropContactName.text,
                                                  dropPhoneNumber:
                                                      dropCountryCode.text +
                                                          dropContactNumber
                                                              .text.replaceAll(' ', ''),
                                                  pickupContactName:
                                                      widget.pickupContactName!,
                                                  pickupLocation:
                                                      widget.importCountry!,
                                                  horsesNumber:
                                                      widget.numberOfHorses!,
                                                  pickupContactNumber: widget
                                                      .pickupContactNumber!,
                                                  shipmentEstimatedDate:
                                                      DateTime.parse(widget
                                                          .estimatedDate!),
                                                  selectedCountry: widget
                                                          .isFromEditing
                                                      ? widget.importCountry!
                                                      : selectedCountryIso2 ??
                                                          'AE',
                                                  serviceType: 'Export'),
                                            )));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChoseShippingHorseScreen(
                                              pickUpCountry:
                                                  'United Arab Emirates',
                                              dropCountry:
                                                  exportingCountry.text,
                                              serviceModel: ShippingServiceModel(
                                                  placeId: widget.placeId,
                                                  location: ChooseLocation(
                                                      lat: latitude.text,
                                                      lng: long.text,
                                                      name: dropLocation.text),
                                                  equipment:
                                                      widget.selectedEquipment,
                                                  dropContactName:
                                                      dropContactName.text,
                                                  dropPhoneNumber:
                                                      dropCountryCode.text +
                                                          dropContactNumber
                                                              .text.replaceAll(' ', ''),
                                                  pickupContactName:
                                                      widget.pickupContactName!,
                                                  pickupLocation:
                                                      widget.importCountry!,
                                                  horsesNumber:
                                                      widget.numberOfHorses!,
                                                  pickupContactNumber: widget
                                                      .pickupContactNumber!.replaceAll(' ', ''),
                                                  shipmentEstimatedDate:
                                                      DateTime.parse(widget
                                                          .estimatedDate!),
                                                  selectedCountry: widget
                                                          .isFromEditing
                                                      ? widget.importCountry!
                                                      : selectedCountryIso2 ??
                                                          'AE',
                                                  serviceType: 'Export'),
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
      type: 'Export',
      placeId: widget.placeId,
      pickUpContactName: widget.pickupContactName,
      pickUpPhoneNumber: widget.pickupContactNumber!.replaceAll(' ', ''),
      dropContactName: dropContactName.text,
      dropPhoneNumber: dropContactNumber.text.replaceAll(' ', ''),
      chooseLocation: ChooseLocation(
          lat: latitude.text, lng: long.text, name: dropLocation.text),
      dropCountry: exportingCountry.text,
      pickUpCountry: 'United Arab Emirates',
      numberOfHorses: int.parse(widget.numberOfHorses!),
      pickUpDate: widget.estimatedDate,
      tackAndEquipment: widget.selectedEquipment,
    ));
  }

  _onPressEditShipping() {
    cubit.editShipping(EditShippingRequestModel(
      id: widget.shippingId,
      type: 'Export',
      placeId: widget.placeId,
      pickUpContactName: widget.pickupContactName,
      pickUpPhoneNumber: widget.pickupContactNumber!.replaceAll(' ', ''),
      dropContactName: dropContactName.text,
      dropPhoneNumber: dropContactNumber.text.replaceAll(' ', ''),
      chooseLocation: ChooseLocation(
          lat: latitude.text, lng: long.text, name: dropLocation.text),
      dropCountry: exportingCountry.text,
      pickUpCountry: 'United Arab Emirates',
      numberOfHorses: int.parse(widget.numberOfHorses!),
      pickUpDate: widget.estimatedDate,
      tackAndEquipment: widget.selectedEquipment,
    ));
  }
}
