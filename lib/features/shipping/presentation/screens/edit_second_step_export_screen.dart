import 'package:country_picker/country_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine/core/constants/colors/app_colors.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/home/data/get_all_places_response_model.dart';
import 'package:proequine/features/home/data/shipping_service_model.dart';
import 'package:proequine/features/shipping/data/edit_shipping_request_model.dart';
import 'package:proequine/features/shipping/data/user_shipping_response_model.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';

import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../data/create_shipping_request_model.dart';
import '../../domain/shipping_cubit.dart';
import '../widgets/chose_location_widget.dart';
import 'edit_chose_horses_screen.dart';

class EditExportSecondStepScreen extends StatefulWidget {
  final ShippingServiceModel model;
  final Place place;
  final String exportingCountry;
  final String status;
  final int shippingId;
  bool isSelective;

  EditExportSecondStepScreen(
      {super.key,
      this.isSelective = false,
      required this.model,
      required this.exportingCountry,
      required this.status,
      required this.place,
      required this.shippingId});

  @override
  EditExportSecondStepScreenState createState() =>
      EditExportSecondStepScreenState();
}

class EditExportSecondStepScreenState
    extends State<EditExportSecondStepScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController dropLocation;
  late TextEditingController dropContactName;
  late TextEditingController dropContactNumber;
  late TextEditingController latitude;
  late TextEditingController long;
  late TextEditingController exportingCountry;



  String convertToTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);
    return time;
  }

  String? selectedCountryIso2;

  @override
  void initState() {
    initializeDateFormatting();
    dropLocation = TextEditingController(text: widget.model.location?.name??'');
    latitude = TextEditingController(text: widget.model.location?.lat??'');
    long = TextEditingController(text: widget.model.location?.lng??'');
    dropContactNumber =
        TextEditingController(text: widget.model.dropPhoneNumber??'');
    dropContactName =
        TextEditingController(text: widget.model.dropContactName??'');
    exportingCountry = TextEditingController(text: widget.exportingCountry??'');

    super.initState();
  }

  String? formatted;

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
    var myCubit = context.watch<ShippingCubit>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Edit Shipping Export",
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
                        Padding(
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
                              if (widget.isSelective) {
                              } else {
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
                              }
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 6),
                          child: RebiInput(
                            hintText: 'Drop Contact Number'.tra,
                            controller: dropContactNumber,
                            keyboardType: TextInputType.number,
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
                                  dropContactNumber.text);
                            },
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    BlocConsumer<ShippingCubit, ShippingState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is EditShippingSuccessfully) {
                          myCubit.getAllShippingRequests(limit: 100);
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
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
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
                            if (_formKey.currentState!.validate()) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditChoseShippingHorseScreen(
                                            shippingModel: ShippingModel(
                                              status: widget.status,
                                              id: widget.shippingId,
                                              place: widget.place,
                                              dropPhoneNumber:
                                                  dropContactNumber.text,
                                              dropContactName:
                                                  dropContactName.text,
                                              tackAndEquipment:
                                                  widget.model.equipment,
                                              chooseLocation:
                                              ChooseLocation(lat: latitude.text,lng: long.text,name: dropLocation.text),
                                              placeId: widget.model.placeId,
                                              pickUpContactName: widget
                                                  .model.pickupContactName,
                                              numberOfHorses: int.parse(
                                                  widget.model.horsesNumber),
                                              pickUpPhoneNumber: widget
                                                  .model.pickupContactNumber,
                                              pickUpDate: widget
                                                  .model.shipmentEstimatedDate
                                                  .toIso8601String(),
                                            ),
                                            pickUpCountry:
                                                'United Arab Emirates',
                                            dropCountry:
                                            exportingCountry.text,
                                            serviceModel: ShippingServiceModel(
                                                equipment:
                                                    widget.model.equipment,
                                                placeId: widget.place.id,
                                                location: ChooseLocation(lat: latitude.text,lng: long.text,name: dropLocation.text),
                                                dropContactName:
                                                    dropContactName.text,
                                                dropPhoneNumber:
                                                    dropContactNumber.text,
                                                pickupContactName: widget
                                                    .model.pickupContactName,
                                                pickupLocation:
                                                    widget.model.pickupLocation,
                                                horsesNumber:
                                                    widget.model.horsesNumber,
                                                pickupContactNumber: widget
                                                    .model.pickupContactNumber,
                                                shipmentEstimatedDate: widget.model.shipmentEstimatedDate,
                                                selectedCountry:
                                                    selectedCountryIso2 ?? 'AE',
                                                serviceType: 'Export'),
                                          )));
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
    cubit.editShipping(EditShippingRequestModel(
      id: widget.shippingId,
      type: 'Export',
      placeId: widget.model.placeId,
      pickUpContactName: widget.model.pickupContactName,
      pickUpPhoneNumber: widget.model.pickupContactNumber,
      dropContactName: dropContactName.text,
      dropPhoneNumber: dropContactNumber.text,
      dropCountry: exportingCountry.text,
      pickUpCountry: 'United Arab Emirates',
      numberOfHorses: int.parse(widget.model.horsesNumber),
      pickUpDate: widget.model.shipmentEstimatedDate.toIso8601String(),
      tackAndEquipment: widget.model.equipment,
      chooseLocation: ChooseLocation(
          lng: long.text, lat: latitude.text, name: dropLocation.text),
    ));
  }
}
