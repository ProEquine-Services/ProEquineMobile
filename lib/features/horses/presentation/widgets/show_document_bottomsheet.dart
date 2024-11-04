import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:proequine_dev/core/utils/extensions.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/rebi_input.dart';

void showDocumentBottomSheet({
  required BuildContext context,
  required bool isItEditing,
  required String title,
  required String buttonTitle,
  required GlobalKey<FormState> formKey,
  required Function onTap,
  required Widget dropDownWidget,
  required Widget uploadWidget,
  Widget? removeWidget,
  required Widget button,
  required TextEditingController docNumber,
  required TextEditingController docTitle,
  required TextEditingController registrationDate,
  required TextEditingController registrationDateInIso,
  required TextEditingController expiryDate,
  required TextEditingController expiryDateInIso,
  required DateTime selectedRegisterDay,
  required DateTime selectedExpiredDay,
  required int selectedYear,
  final GlobalKey<FormState>? yearKey,
  required TextEditingController yearController,
  required DateTime focusDay,
  required TextEditingController docNotes,
}) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
        ? AppColors.formsBackground
        : AppColors.backgroundColorLight,
    useSafeArea: false,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    builder: (BuildContext context) {
      return Form(
        key: formKey,
        child: Wrap(children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: kPadding, left: kPadding, right: kPadding),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Center(
                            child: Text(title,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: "notosan",
                                    fontWeight: FontWeight.w600,
                                    color: AppSharedPreferences.getTheme ==
                                            'ThemeCubitMode.dark'
                                        ? Colors.white
                                        : AppColors.blackLight)),
                          ),
                          isItEditing
                              ? removeWidget!
                              : IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    size: 18,
                                    color: AppColors.yellow,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: kPadding,
                      ),
                      Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'Doc Title'.tra,
                                  controller: docTitle,
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
                                        docTitle.text);
                                  },
                                ),
                              ),
                              dropDownWidget,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'Doc Number'.tra,
                                  controller: docNumber,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  isOptional: true,
                                  color: AppColors.formsLabel,
                                  readOnly: false,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {},
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'Registration Date'.tra,
                                  controller: registrationDate,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  onTap: () {
                                    selectDate(
                                        context: context,
                                        isSupportChangingYears: false,
                                        selectedOurDay: selectedRegisterDay,
                                        from: DateTime.utc(2020),
                                        to: DateTime.utc(2030),
                                        selectedYear: selectedYear,
                                        yearController: yearController,
                                        focusDay: focusDay,
                                        controller: registrationDate,
                                        yearKey: yearKey);
                                  },
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  isOptional: true,
                                  color: AppColors.formsLabel,
                                  readOnly: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      DateFormat inputFormat =
                                          DateFormat("dd MMM yyyy");
                                      DateTime dateTime =
                                          inputFormat.parse(value);
                                      selectedRegisterDay = dateTime;
                                      registrationDateInIso.text =
                                          selectedRegisterDay.toIso8601String();
                                    } else {}
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'Expiry Date'.tra,
                                  controller: expiryDate,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  onTap: () {
                                    selectDate(
                                        context: context,
                                        isSupportChangingYears: false,
                                        selectedOurDay: selectedRegisterDay
                                            .add(const Duration(days: 365)),
                                        from: selectedRegisterDay
                                            .add(const Duration(days: 365)),
                                        to: DateTime.utc(2030),
                                        selectedYear: selectedYear,
                                        yearController: yearController,
                                        focusDay: focusDay,
                                        controller: expiryDate,
                                        yearKey: yearKey);
                                  },
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  isOptional: true,
                                  color: AppColors.formsLabel,
                                  readOnly: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      DateFormat inputFormat =
                                          DateFormat("dd MMM yyyy");
                                      DateTime dateTime =
                                          inputFormat.parse(value!);
                                      selectedExpiredDay = dateTime;
                                      expiryDateInIso.text =
                                          selectedExpiredDay.toIso8601String();
                                      if (selectedExpiredDay
                                          .isBefore(selectedRegisterDay)) {
                                        RebiMessage.error(
                                            msg: "Please enter the expiry date",
                                            context: context);
                                      }
                                      return Validator.requiredValidator(
                                          expiryDate.text);
                                    } else {}
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: RebiInput(
                                  hintText: 'Doc Notes'.tra,
                                  controller: docNotes,
                                  keyboardType: TextInputType.text,
                                  maxLines: 5,
                                  textInputAction: TextInputAction.done,
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  isOptional: true,
                                  color: AppColors.formsLabel,
                                  readOnly: false,
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 13),
                                  obscureText: false,
                                  validator: (value) {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          uploadWidget,
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: button,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]),
      );
    },
  );
}
