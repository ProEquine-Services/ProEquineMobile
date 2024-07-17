import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/rebi_input.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors/app_colors.dart';
import '../constants/constants.dart';
import '../utils/validator.dart';

class PhoneNumberFieldWidget extends StatefulWidget {
  TextEditingController countryCode = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  // final FormFieldValidator<String> countryCodeValidator;
  // final FormFieldValidator<String> phoneNumberValidator;

  PhoneNumberFieldWidget(
      {Key? key,
      required this.countryCode,
      required this.phoneNumber,
      // required this.countryCodeValidator,
      // required this.phoneNumberValidator

      })
      : super(key: key);

  @override
  State<PhoneNumberFieldWidget> createState() => _PhoneNumberFieldWidgetState();
}

class _PhoneNumberFieldWidgetState extends State<PhoneNumberFieldWidget> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 7),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: RebiInput(
              hintText: 'CC'.tra,
              controller: widget.countryCode,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              onTap: () {
                showCountryPicker(
                  context: context,
                  showPhoneCode: true,
                  countryListTheme: CountryListThemeData(
                    flagSize: 25,
                    backgroundColor: AppColors.backgroundColorLight,
                    textStyle: const TextStyle(
                        fontSize: 16, color: AppColors.blackLight),
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
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFFDBD4C3),
                          width: 0.50,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        borderSide: BorderSide(
                          color: Color(0xFFDBD4C3),
                          width: 0.50,
                        ),
                      ),
                    ),
                  ),
                  onSelect: (Country country) =>
                  widget.countryCode.text = '+${country.phoneCode}',
                );
              },
              isOptional: false,
              color: AppColors.formsLabel,
              readOnly: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              obscureText: false,
              validator: (value) {
                return Validator.countryCodeValidator(
                    widget.countryCode.text);
              },
              // validator: widget.countryCodeValidator,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 3,
            child: RebiInput(
              hintText: '50 1234567'.tra,
              controller: widget.phoneNumber,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              isOptional: false,
              color: AppColors.formsLabel,
              readOnly: false,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              obscureText: false,
              validator: (value) {
                return Validator.phoneValidator(widget.phoneNumber.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
