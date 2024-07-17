import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../constants/colors/app_colors.dart';
import '../constants/thems/app_styles.dart';
import '../utils/Printer.dart';
import '../utils/sharedpreferences/SharedPreferencesHelper.dart';

void selectDate({
  BuildContext? context,
  bool isSupportChangingYears = false,
  int? selectedYear,
  required DateTime selectedOurDay,
  required DateTime focusDay,
  required DateTime from,
  required DateTime to,
  TextEditingController? yearController,
  final GlobalKey<FormState>? yearKey,
  required final TextEditingController controller,
}) async {
  showDialog<DateTime>(
      context: context!,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 21.0.h),
                child: Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  insetPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  backgroundColor:
                      AppSharedPreferences.getTheme == 'ThemeCubitMode.dark'
                          ? AppColors.formsBackground
                          : AppColors.formsBackgroundLight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isSupportChangingYears
                          ? SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.keyboard_arrow_left,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        int minYear = 1950;
                                        int maxYear = 2023;
                                        if (selectedYear! - 1 >= minYear &&
                                            selectedYear! - 1 <= maxYear) {
                                          setState(() {
                                            selectedYear = selectedYear! - 1;
                                            selectedOurDay = DateTime(
                                                selectedYear!,
                                                selectedOurDay.month,
                                                selectedOurDay.day);
                                          });
                                        } // update `_focusedDay` here as well
                                      });
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  AppSharedPreferences
                                                              .getTheme ==
                                                          'ThemeCubitMode.dark'
                                                      ? AppColors
                                                          .formsBackground
                                                      : AppColors
                                                          .backgroundColorLight,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              insetPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 15),
                                              elevation: 5,
                                              title: const Text(
                                                'Edit Year',
                                                style: TextStyle(
                                                    color: AppColors.gold),
                                              ),
                                              content: Form(
                                                key: yearKey,
                                                child: TextFormField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                            RegExp(r'[0-9]')),
                                                    LengthLimitingTextInputFormatter(
                                                        4),
                                                  ],
                                                  keyboardAppearance:
                                                      AppSharedPreferences
                                                                  .getTheme ==
                                                              'ThemeCubitMode.dark'
                                                          ? Brightness.dark
                                                          : Brightness.light,
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  controller: yearController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  validator: (value) {
                                                    if (value != null ||
                                                        value != '') {
                                                      int? inputtedYear =
                                                          value != null ||
                                                                  value != ''
                                                              ? int.tryParse(
                                                                  value!)
                                                              : 2;
                                                      if (value == '' ||
                                                          inputtedYear! <
                                                              1950 ||
                                                          inputtedYear > 2023) {
                                                        return 'Enter your correct year';
                                                      }
                                                    }
                                                  },
                                                  onChanged: (text) {
                                                    int minYear = 1950;
                                                    int maxYear = 2023;
                                                    if (text.isNotEmpty) {
                                                      final year =
                                                          int.tryParse(text);
                                                      if (year != null &&
                                                          year >= minYear &&
                                                          year <= maxYear) {
                                                        setState(() {
                                                          selectedOurDay =
                                                              DateTime(
                                                                  year,
                                                                  selectedOurDay
                                                                      .month,
                                                                  selectedOurDay
                                                                      .day);
                                                        });
                                                      }
                                                    }
                                                  },
                                                  style: const TextStyle(
                                                    fontFamily: "notosan",

                                                    // fontFamily: AppStyles.montserrat,
                                                    decoration:
                                                        TextDecoration.none,
                                                  ),
                                                  decoration: InputDecoration(
                                                    errorStyle: const TextStyle(
                                                        color: AppColors.red,
                                                        fontSize: 11,
                                                        height: 1.0,
                                                        fontFamily: 'notosan'),
                                                    errorMaxLines: 4,
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  AppColors.red,
                                                              width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10.0,
                                                      ),
                                                    ),
                                                    hintText: 'Select Year',
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .blackLight),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    if (yearKey!.currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        final year =
                                                            int.tryParse(
                                                                yearController!
                                                                    .text);
                                                        if (year != null) {
                                                          selectedOurDay =
                                                              DateTime(
                                                                  year,
                                                                  selectedOurDay
                                                                      .month,
                                                                  selectedOurDay
                                                                      .day);
                                                          selectedYear = year;
                                                        }
                                                      });
                                                    }

                                                    Navigator.pop(
                                                        context, selectedYear);
                                                  },
                                                  child: const Text(
                                                    'Confirm',
                                                    style: TextStyle(
                                                        color: AppColors.gold),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ); // update `_focusedDay` here as well
                                      });
                                    },
                                    child: Text(
                                      '$selectedYear',
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.keyboard_arrow_right,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        int minYear = 1950;
                                        int maxYear = 2023;
                                        if (selectedYear! + 1 >= minYear &&
                                            selectedYear! + 1 <= maxYear) {
                                          setState(() {
                                            selectedYear = selectedYear! + 1;
                                            selectedOurDay = DateTime(
                                                selectedYear!,
                                                selectedOurDay.month,
                                                selectedOurDay.day);
                                          });
                                        } // update `_focusedDay` here as well
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(
                              height: 0.1,
                            ),
                      TableCalendar(
                        onPageChanged: (date) {
                          selectedYear = date.year;
                          focusDay; // update `_focusedDay` here as well
                        },
                        shouldFillViewport: false,
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          rightChevronMargin: const EdgeInsets.only(right: 10),
                          //
                          leftChevronIcon: const Icon(
                            Icons.chevron_left,
                            color: AppColors.gold,
                          ),
                          rightChevronIcon: const Icon(
                            Icons.chevron_right,
                            color: AppColors.gold,
                          ),

                          titleCentered: true,
                          titleTextStyle: const TextStyle(
                            color: AppColors.blackLight,
                            fontSize: 20,
                            fontFamily: 'notosan',
                          ),
                          titleTextFormatter: (date, locale) {
                            return DateFormat(
                                    'MMMM-yyyy')
                                .format(date);
                          },
                        ),
                        daysOfWeekHeight: 40,
                        calendarBuilders: CalendarBuilders(
                            outsideBuilder: (context, date, newDate) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }),
                        calendarStyle: CalendarStyle(
                          tableBorder: TableBorder(
                              borderRadius: BorderRadius.circular(12)),
                          selectedTextStyle: const TextStyle(
                              fontFamily: 'notosan',
                              fontSize: 13,
                              color: Colors.white),
                          selectedDecoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.gold,
                          ),
                          todayDecoration: BoxDecoration(
                              color: AppSharedPreferences.getTheme ==
                                      'ThemeCubitMode.dark'
                                  ? AppColors.borderColor
                                  : AppColors.blackLight,
                              shape: BoxShape.circle),
                          weekendTextStyle: const TextStyle(
                            fontFamily: 'notosan',
                            fontSize: 14,
                          ),
                          outsideDaysVisible: false,
                          defaultTextStyle: const TextStyle(
                            fontFamily: 'notosan',
                            fontSize: 14,
                          ),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(
                            fontSize: 15,
                            color: AppSharedPreferences.getTheme ==
                                    'ThemeCubitMode.dark'
                                ? AppColors.borderColor
                                : AppColors.blackLight,
                            fontFamily: 'notosan',
                          ),
                          weekendStyle: TextStyle(
                              fontSize: 15,
                              color: AppSharedPreferences.getTheme ==
                                      'ThemeCubitMode.dark'
                                  ? AppColors.borderColor
                                  : AppColors.blackLight,
                              fontFamily: 'notosan',
                              inherit: false),
                          // dowTextFormatter:(date, locale) =>  DateFormat(days['d']).format(date),
                        ),
                        focusedDay: selectedOurDay,
                        firstDay: from,
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        lastDay: to,
                        selectedDayPredicate: (day) {
                          return isSameDay(selectedOurDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            selectedOurDay = selectedDay;
                            selectedYear = selectedDay.year;

                            focusDay = focusedDay;
                            controller.text = selectedOurDay.toString();
                            DateFormat formatter = DateFormat('dd MMM yyyy');
                            final String formatted =
                                formatter.format(selectedOurDay);
                            controller.text =
                                formatted; // update `_focusedDay` here as well
                          });
                        },
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: RebiButton(
                            width: 90,
                            backgroundColor: AppColors.gold,

                            onPressed: () {
                              Print('selectedOurDay $selectedOurDay');
                              Navigator.pop(context, selectedOurDay);

                              controller.text = selectedOurDay.toString();
                              DateFormat formatter = DateFormat('dd MMM yyyy');
                              final String formatted =
                                  formatter.format(selectedOurDay);
                              controller.text = formatted;
                            },
                            child: Text(
                              'Confirm',
                              style: AppStyles.buttonStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
