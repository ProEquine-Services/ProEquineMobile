import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proequine_dev/core/utils/extensions.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/date_time_picker.dart';
import '../../../../core/widgets/rebi_input.dart';

class SelectDateAndTimeWidget extends StatefulWidget {
  TextEditingController dateController = TextEditingController();
  DateTime time;
  DateTime from;
  DateTime? to;
  DateTime pickedDate;
  final FormFieldValidator<String> validator;
  TextEditingController timeController = TextEditingController();

  SelectDateAndTimeWidget(
      {Key? key,

      required this.time,
      required this.from, this.to,
      required this.timeController,
      required this.validator,
      required this.pickedDate,
        // this.isForReturn=false,
      required this.dateController,})
      : super(key: key);

  @override
  State<SelectDateAndTimeWidget> createState() =>
      _SelectDateAndTimeWidgetState();
}

class _SelectDateAndTimeWidgetState extends State<SelectDateAndTimeWidget> {
  DateTime focusedDay = DateTime.now();
  late DateTime dateTime;
  late DateTime pickDate;
  @override
  void initState() {
    initializeDateFormatting();
    pickDate = DateTime.now();
    dateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding, vertical: 6),
      child: StatefulBuilder(
        builder: (context,setState) {
          return Row(
            children: [
              Expanded(
                child: RebiInput(
                  hintText: 'Pickup date'.tra,
                  controller: widget.dateController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                  onTap: () {
                    selectDate(
                      context: context,
                      from: widget.from,
                      to: widget.to??DateTime(2025, 1, 1),
                      isSupportChangingYears: false,
                      selectedOurDay: dateTime,
                      controller: widget.dateController,
                      focusDay: focusedDay,
                    );
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  isOptional: false,
                  color: AppColors.formsLabel,
                  readOnly: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  obscureText: false,
                  validator: widget.validator,

                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: RebiInput(
                  hintText: widget.timeController.text.isEmpty
                      ? 'Pickup time'
                      : widget.timeController.text,
                  controller: widget.timeController,
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      confirmText: "Confirm".tra,
                      context: context,
                      cancelText: "Cancel".tra,
                      initialEntryMode: TimePickerEntryMode.dial,
                      initialTime:
                          TimeOfDay.fromDateTime(DateTime.utc(0, 0, 0, 15, 0)),
                    );

                    Print(pickedTime);

                    if (pickedTime != null) {
                      widget.time = pickedTime.toDateTime();
                      if (context.mounted) {}
                      String parsedTime = pickedTime.format(context);

                      setState(() {
                        widget.timeController.text = parsedTime;
                      });
                    } else {}
                  },
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                  isOptional: false,
                  readOnly: true,
                  validator: (value) {
                    return  Validator.requiredValidator(widget.timeController.text);
                  },
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
