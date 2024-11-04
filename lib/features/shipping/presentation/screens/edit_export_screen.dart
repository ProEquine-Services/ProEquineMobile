import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:proequine_dev/core/utils/Printer.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/widgets/delete_popup.dart';
import 'package:proequine_dev/core/widgets/update_shipping_header.dart';
import 'package:proequine_dev/features/home/data/get_all_places_response_model.dart';
import 'package:proequine_dev/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:proequine_dev/features/shipping/data/edit_shipping_request_model.dart';
import 'package:proequine_dev/features/shipping/data/user_shipping_response_model.dart';
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
import '../../../home/data/shipping_service_model.dart';
import '../../../home/presentation/widgets/select_place_widget.dart';
import '../../data/create_shipping_request_model.dart';
import '../../domain/shipping_cubit.dart';
import 'edit_second_step_export_screen.dart';

class EditExportScreen extends StatefulWidget {
  final ShippingModel model;
  final String estimatedDate;
  bool isFromEditing;

  EditExportScreen({
    super.key,
    this.isFromEditing = false,
    required this.model,
    required this.estimatedDate,
  });

  @override
  State<EditExportScreen> createState() => _EditExportScreenState();
}

class _EditExportScreenState extends State<EditExportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pickUpContactName = TextEditingController();
  TextEditingController pickupCountry = TextEditingController();
  TextEditingController dropOfLocationUrl = TextEditingController();
  TextEditingController numberOfHorses = TextEditingController();
  late TextEditingController pickUpContactNumber;

  late TextEditingController pickupLocation;
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

  String? selectedEquipment;
  String? selectedCountryIso2;
  String? estimatedDateFormatted;

  @override
  void initState() {
    initializeDateFormatting();
    if (widget.isFromEditing) {}

    Print('Equipment issssss ${widget.model.tackAndEquipment}');

    pickupLocation = TextEditingController(text: widget.model.place!.name!);
    latitude = TextEditingController(text: widget.model.place!.lat!);
    long = TextEditingController(text: widget.model.place!.lng!);
    placeId.text = widget.model.place!.id!.toString();
    DateTime parsedDate = DateTime.parse(widget.estimatedDate);

    DateFormat format = DateFormat('dd MMM yyyy');
    String dateString = format.format(parsedDate);

    pickDate = DateTime.parse(widget.estimatedDate);
    dateTime = DateTime.parse(widget.estimatedDate);
    estimatedDate = TextEditingController(text: dateString);
    pickupCountry = TextEditingController(text: widget.model.pickUpCountry);
    pickUpContactName =
        TextEditingController(text: widget.model.pickUpContactName);
    pickUpContactNumber =
        TextEditingController(text: widget.model.pickUpPhoneNumber);
    placeId = TextEditingController(text: widget.model.placeId.toString());
    numberOfHorses =
        TextEditingController(text: widget.model.numberOfHorses.toString());
    selectedEquipment = widget.model.tackAndEquipment ?? 'No Tack';

    dropLocation = TextEditingController(text: widget.model.chooseLocation!.name);

    super.initState();
  }

  String? formatted;
  int? shippingId;

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
          title: 'Shipping Export',
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
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
                              color: widget.model.isBelongToSelective!
                                  ? AppColors.grey
                                  : AppColors.formsLabel,
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
                        ),
                        SelectPlaceWidget(
                            placeName: pickupLocation,
                            lat: latitude,
                            lng: long,
                            hintText: 'Pickup Location',
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
                        if (state is EditShippingSuccessfully) {
                          myCubit.getAllShippingRequests(limit: 10);
                          RebiMessage.success(
                              msg: "Saved as draft successfully",
                              context: context);

                          shippingId = state.responseModel.id!;
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
                            if (widget.isFromEditing) {}
                            Print(pickDate.toIso8601String());
                            Print(estimatedDate!.text.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EditExportSecondStepScreen(
                                          status: widget.model.status!,
                                          isSelective:
                                              widget.model.isBelongToSelective!,
                                          shippingId: widget.model.id!,
                                          place: Place(
                                              id: int.parse(placeId.text),
                                              name: pickupLocation.text,
                                              lat: latitude.text,
                                              lng: long.text),
                                          exportingCountry:
                                              widget.model.dropCountry!,
                                          model: ShippingServiceModel(
                                              placeId: int.parse(placeId.text) ,

                                              dropContactName:
                                                  widget.model.dropContactName!,
                                              dropPhoneNumber:
                                                  widget.model.dropPhoneNumber!,
                                              pickupContactName:
                                                  pickUpContactName.text,
                                              location:
                                                  widget.model.chooseLocation,
                                              pickupLocation:
                                                  widget.model.place!.name!,
                                              horsesNumber: numberOfHorses.text,
                                              pickupContactNumber:
                                                  pickUpContactNumber.text,
                                              shipmentEstimatedDate: pickDate,
                                              notes: widget.model.notes!,
                                              equipment: selectedEquipment,
                                              selectedCountry: widget
                                                      .isFromEditing
                                                  ? ''
                                                  : selectedCountryIso2 ?? "AE",
                                              serviceType: 'Export'),
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

  _onPressSave() {
    cubit.editShipping(EditShippingRequestModel(
        id: widget.model.id,
        type: 'Export',
        placeId: int.parse(placeId.text),
        pickUpContactName: pickUpContactName.text,
        pickUpPhoneNumber: pickUpContactNumber.text,
        pickUpCountry: "United Arab Emirates",
        numberOfHorses: int.parse(numberOfHorses.text),
        notes: widget.model.notes,
        dropCountry: widget.model.dropCountry,
        dropContactName: widget.model.dropContactName,
        dropPhoneNumber: widget.model.dropPhoneNumber,
        pickUpDate: pickDate.toIso8601String(),
        tackAndEquipment: selectedEquipment,
        chooseLocation: ChooseLocation(
            lat: latitude.text, lng: long.text, name:dropLocation.text )));
  }

  _onPressDelete() {
    cubit.removeShipping(widget.model.id!);
  }
}
