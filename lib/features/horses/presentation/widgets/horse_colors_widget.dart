import 'package:flutter/material.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../home/presentation/widgets/hospital_bottom_sheet.dart';

class HorseColorsWidget extends StatefulWidget {
  TextEditingController? color;


  HorseColorsWidget(
      {Key? key, required this.color})
      : super(key: key);

  @override
  State<HorseColorsWidget> createState() => _HorseColorsWidgetState();
}

class _HorseColorsWidgetState extends State<HorseColorsWidget> {
  @override
  void initState() {
    // widget.color = TextEditingController(text: widget.color!.text);
    super.initState();
  }

  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    return RebiInput(
      hintText: "Color",
      controller: widget.color,
      keyboardType: TextInputType.name,
      onChanged: (value) {
        setState(() {});
      },
      textInputAction: TextInputAction.done,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      isOptional: false,
      color: AppColors.formsLabel,
      onTap: () {
        showHospitalsAndPlacesBottomSheet(
            context: context,
            title: "Color",
            content: SingleChildScrollView(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: horseColors.length,
                    separatorBuilder: (context, index) {
                      return const CustomDivider();
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedColor = horseColors[index];
                            Navigator.pop(context);
                            widget.color!.text = horseColors[index];


                            // Print("Selected stable ${stables[index]}");
                            Print("horseColor is $selectedColor");
                          });
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(horseColors[index])],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ));
      },
      readOnly: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      obscureText: false,
      validator: (value) {
        return Validator.requiredValidator(widget.color!.text);
      },
    );
  }
}
