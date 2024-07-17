import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/utils/Printer.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/delete_popup.dart';
import 'package:proequine/core/widgets/update_shipping_header.dart';
import 'package:proequine/features/home/data/get_all_places_response_model.dart';
import 'package:proequine/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:proequine/features/shipping/data/edit_shipping_request_model.dart';
import 'package:proequine/features/shipping/data/user_shipping_response_model.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../data/create_shipping_request_model.dart';
import '../../domain/shipping_cubit.dart';
import '../widgets/chose_location_widget.dart';
import 'edit_second_step_import_screen.dart';

class EditImportScreen extends StatefulWidget {
  final ShippingModel model;
  final String estimatedDate;
  bool isFromEditing;

  EditImportScreen({
    super.key,
    this.isFromEditing = false,
    required this.model,
    required this.estimatedDate,
  });

  @override
  State<EditImportScreen> createState() => _EditImportScreenState();
}

class _EditImportScreenState extends State<EditImportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pickUpContactName = TextEditingController();
  TextEditingController pickupCountry = TextEditingController();
  TextEditingController dropOfLocationUrl = TextEditingController();
  TextEditingController numberOfHorses = TextEditingController();
  late TextEditingController pickUpContactNumber;
  TextEditingController pickUpCountryCode = TextEditingController(text: '+971');

  late TextEditingController dropLocation;
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

  String? selectedEquipment;
  String? selectedCountryIso2;
  String? estimatedDateFormatted;

  @override
  void initState() {
    initializeDateFormatting();

    if (widget.isFromEditing) {}
    selectedEquipment = widget.model.tackAndEquipment;
    DateTime parsedDate = DateTime.parse(widget.estimatedDate);

    DateFormat format = DateFormat('dd MMM yyyy');
    String dateString = format.format(parsedDate);


    pickDate = DateTime.parse(widget.estimatedDate);
    dateTime = DateTime.parse(widget.estimatedDate);
    estimatedDate = TextEditingController(text: dateString);
    dropLocation =
        TextEditingController(text: widget.model.chooseLocation!.name!);
        latitude = TextEditingController(text: widget.model.chooseLocation!.lat!);
        long= TextEditingController(text: widget.model.chooseLocation!.lng!);
    pickupCountry = TextEditingController(text: widget.model.pickUpCountry);
    pickUpContactName =
        TextEditingController(text: widget.model.pickUpContactName);
    pickUpContactNumber =
        TextEditingController(text: widget.model.pickUpPhoneNumber);
    placeId = TextEditingController(text: widget.model.placeId.toString());
    numberOfHorses =
        TextEditingController(text: widget.model.numberOfHorses.toString());

    // dropCountryCode = TextEditingController(text: widget.model.pickUpContactName);

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
    var myCubit = context.watch<ShippingCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.0.h),
        child: UpdateShippingHeader(
          title: 'Shipping Import',
          thirdOptionTitle: 'Cancel',
          onPressThirdOption: () {
            deleteDialog(
                context: context,
                deleteButton: BlocConsumer<ShippingCubit, ShippingState>(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state is RemoveShippingSuccessfully) {
                      RebiMessage.success(msg: state.message, context: context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BottomNavigation(
                                    selectedIndex: 2,
                                  )));
                    } else if (state is RemoveShippingError) {
                      RebiMessage.error(msg: state.message!, context: context);
                    }
                  },
                  builder: (context, state) {
                    if (state is RemoveShippingLoading) {
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
                title: "Are you sure you want to cancel this shipment");
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 6),
                          child: RebiInput(
                            hintText: 'Shipping Estimated Date '.tra,
                            controller: estimatedDate,
                            isItDisable: widget.model.isBelongToSelective!,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            onTap: () {
                              if (widget.model.isBelongToSelective!) {
                              } else {
                                selectDate(
                                  context: context,
                                  from: DateTime.now(),
                                  to: DateTime(2025, 1, 1),
                                  isSupportChangingYears: false,
                                  selectedOurDay: dateTime,
                                  controller: estimatedDate!,
                                  focusDay: focusedDay,
                                );
                              }
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
                              DateTime setUpdatedDate =
                                  inputFormat.parse(value!);
                              pickDate = setUpdatedDate;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 7),
                          child: RebiInput(
                            hintText: 'Importing country'.tra,
                            controller: pickupCountry,
                            isItDisable: widget.model.isBelongToSelective!,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            onTap: () {
                              if (widget.model.isBelongToSelective!) {
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

                                      setState(() {
                                        pickupCountry.text = country.name;
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
                              return Validator.countryCodeValidator(
                                  pickUpCountryCode.text);
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: kPadding, vertical: 6),
                          child: RebiInput(
                            hintText: 'Pickup Contact Number'.tra,
                            controller: pickUpContactNumber,
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
                              // return Validator.requiredValidator(
                              // dropContactName.text);
                            },
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
                            onChanged: (gender) {
                              setState(() {
                                selectedEquipment = gender;
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
                        if (state is EditShippingSuccessfully) {
                          myCubit.getAllShippingRequests(limit: 10);
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
                                  phoneNumber = pickUpCountryCode.text +
                                      pickUpContactNumber.text;
                                  if (widget.isFromEditing) {}

                                  _onPressSave();
                                  Print(latitude.text);
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
                            Print(
                                ' The Name is ${widget.model.dropContactName!}');
                            if (_formKey.currentState!.validate()) {
                              phoneNumber = pickUpCountryCode.text +
                                  pickUpContactNumber.text;
                              if (widget.isFromEditing) {
                                Print("laaat ${widget.model.chooseLocation!.lng}");
                                Print(latitude.text);
                                // DateFormat formatter =
                                //     DateFormat('dd MMM yyyy');
                                // formatted =
                                //     formatter.format(widget.estimatedDate!);
                              }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditImportSecondStepScreen(
                                            status: widget.model.status,
                                              isFromEditing: widget
                                                  .model.isBelongToSelective!,
                                              horses: widget.model.horses,
                                              shippingId: widget.model.id,
                                              place: widget.model.place??Place(),
                                              dropContactName:
                                                  widget.model.dropContactName,
                                              dropContactNumber:
                                                  widget.model.dropPhoneNumber,
                                              selectedEquipment:
                                                  selectedEquipment!,
                                              importCountry: pickupCountry.text,
                                              notes: widget.model.notes,
                                              estimatedDate:
                                                  pickDate.toIso8601String(),
                                              pickupContactName:
                                                  pickUpContactName.text,
                                              pickupContactNumber:
                                                  pickUpContactNumber.text,
                                              numberOfHorses:
                                                  numberOfHorses.text,
                                              location: ChooseLocation(
                                                  lat: latitude.text,
                                                  lng: long.text,
                                                  name: dropLocation.text))));
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
    Print('pick up date is $pickDate');
    cubit.editShipping(
      EditShippingRequestModel(
        id: widget.model.id,
        type: 'Import',
        placeId: int.parse(placeId.text),
        pickUpContactName: pickUpContactName.text,
        dropPhoneNumber: widget.model.dropPhoneNumber,
        dropContactName: widget.model.dropContactName,
        pickUpPhoneNumber: pickUpContactNumber.text,
        pickUpCountry: pickupCountry.text,
        dropCountry: 'United Arab Emirates',
        notes: widget.model.notes,
        numberOfHorses: int.parse(numberOfHorses.text),
        pickUpDate: pickDate.toIso8601String(),
        tackAndEquipment: selectedEquipment,
        chooseLocation: ChooseLocation(
            lat: latitude.text, lng: long.text, name: dropLocation.text),
      ),
    );
  }

  _onPressDelete() {
    cubit.removeShipping(widget.model.id!);
  }
}
