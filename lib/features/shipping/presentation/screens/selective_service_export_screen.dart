import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/utils/rebi_message.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';

import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/phone_number_field_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../home/presentation/widgets/select_place_widget.dart';
import '../../data/selective_service_response_model.dart';
import '../../domain/shipping_cubit.dart';
import '../widgets/shipping_icon_widget.dart';
import 'export_second_step_screen.dart';

class SelectiveServiceExportScreen extends StatefulWidget {
  final SelectiveServiceModel model;

  const SelectiveServiceExportScreen({super.key, required this.model});

  @override
  State<SelectiveServiceExportScreen> createState() =>
      _SelectiveServiceExportScreenState();
}

class _SelectiveServiceExportScreenState
    extends State<SelectiveServiceExportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController pickUpLocation = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController pickUpContactName = TextEditingController();
  TextEditingController numberOfHorses = TextEditingController();
  TextEditingController pickUpContactNumber = TextEditingController();
  TextEditingController pickUpCountryCode = TextEditingController(text: '+971');

  TextEditingController dropLocation = TextEditingController();
  TextEditingController dropContactName = TextEditingController();
  TextEditingController dropContactNumber = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController long = TextEditingController();
  String? selectedEquipment;

  @override
  void initState() {
    initializeDateFormatting();
    // if (widget.isFromEditing) {}

    super.initState();
  }

  String? formatted;

  @override
  void dispose() {
    super.dispose();
  }

  bool isChoseAddPlace = false;
  TextEditingController placeId = TextEditingController();

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

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Export",
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${widget.model.title}',
                                    style: AppStyles.bookingContent,
                                  ),
                                  Text(
                                    widget.model.selectiveCode.toString(),
                                    style: AppStyles.bookingContent,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.model.fromCountry!,
                                    style: AppStyles.bookingContent,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const ShippingIconWidget(
                                    type: 'Export',
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.model.toCountry!,
                                    style: AppStyles.bookingContent,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    formatDate(DateTime.parse(
                                        widget.model.startDate!)),
                                    style: AppStyles.bookingContent,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
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
                            placeName: pickUpLocation,
                            lat: latitude,
                            hintText: 'Pickup Location',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: RebiButton(
                          onPressed: () {
                            if(_formKey.currentState!.validate() && selectedEquipment!=null){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ExportSecondStepScreen(
                                            selectiveId: widget.model.id,
                                            isFromEditing: true,
                                            // shippingId: shippingId,

                                            selectedEquipment: selectedEquipment!,
                                            importCountry: 'United Arab Emirates',
                                            estimatedDate: widget.model.startDate,
                                            exportCountry: widget.model.toCountry,

                                            pickupContactName:
                                            pickUpContactName.text,
                                            placeId: int.parse(placeId.text),
                                            pickupContactNumber:
                                            pickUpCountryCode.text +
                                                pickUpContactNumber.text.replaceAll(' ', ''),
                                            numberOfHorses: numberOfHorses.text,
                                          )));
                            }else {
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
}
