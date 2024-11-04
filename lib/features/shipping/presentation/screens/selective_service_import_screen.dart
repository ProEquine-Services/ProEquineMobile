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
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/phone_number_field_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../data/create_shipping_request_model.dart';
import '../../data/selective_service_response_model.dart';
import '../../domain/shipping_cubit.dart';
import '../widgets/chose_location_widget.dart';
import '../widgets/shipping_icon_widget.dart';
import 'import_second_step_screen.dart';

class SelectiveServiceImportScreen extends StatefulWidget {
  final SelectiveServiceModel model;
  const SelectiveServiceImportScreen({super.key, required this.model});

  @override
  State<SelectiveServiceImportScreen> createState() => _SelectiveServiceImportScreenState();
}

class _SelectiveServiceImportScreenState extends State<SelectiveServiceImportScreen> {
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
        title: Text("Import",
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
          padding:  const EdgeInsets.symmetric(horizontal: kPadding),
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
                        padding: const EdgeInsets.symmetric(horizontal: kPadding,vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  widget.model.toCountry!,
                                  style: AppStyles.bookingContent,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const ShippingIconWidget(
                                  type: 'Import',
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.model.fromCountry!,
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
                                  formatDate(DateTime.parse(widget.model.startDate!)),
                                  style: AppStyles.bookingContent,
                                ),

                              ],
                            )
                          ],
                        ),
                      )
                    ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: kPadding),
                          child: DropDownWidget(
                            items: equipments,
                            selected: selectedEquipment,
                            onChanged: (gender) {
                              setState(() {
                                selectedEquipment = gender;
                                Print('Tack & Equipment $selectedEquipment');
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: RebiButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() && selectedEquipment != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImportSecondStepScreen(
                                    isFromEditing: true,
                                      selectiveId: widget.model.id,
                                      selectedEquipment: selectedEquipment!,
                                      importCountry: widget.model.fromCountry,
                                      estimatedDate: widget.model.startDate,
                                      pickupContactName: pickUpContactName.text,
                                      pickupContactNumber:
                                      pickUpCountryCode.text +
                                          pickUpContactNumber.text.replaceAll(' ', ''),
                                      numberOfHorses: numberOfHorses.text,
                                      location: ChooseLocation(
                                          lat: latitude.text,
                                          lng: long.text,
                                          name: dropLocation.text)),
                                ),
                              );
                            }else {
                              RebiMessage.error(msg: 'Some data are missing.', context: context);
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
    );;
  }
}
