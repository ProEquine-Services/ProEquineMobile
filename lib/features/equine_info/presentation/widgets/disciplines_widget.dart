import 'package:flutter/material.dart';
import 'package:proequine/features/user/domain/user_cubit.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../home/presentation/widgets/hospital_bottom_sheet.dart';

// ignore: must_be_immutable
class DisciplinesWidget extends StatefulWidget {
  late TextEditingController? discipline;
  late TextEditingController? disciplineId;


  DisciplinesWidget(
      {Key? key, required this.discipline, required this.disciplineId})
      : super(key: key);

  @override
  State<DisciplinesWidget> createState() => _DisciplinesWidgetState();
}

class _DisciplinesWidgetState extends State<DisciplinesWidget> {
  @override
  void initState() {
    widget.discipline = TextEditingController(text: widget.discipline!.text);
    super.initState();
  }

  UserCubit cubit = UserCubit();
  String? selectedInterests;

  @override
  Widget build(BuildContext context) {
    return RebiInput(
      hintText: "Discipline",
      controller: widget.discipline,
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
            title: "Disciplines",
            content: SingleChildScrollView(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: interests.length,
                    separatorBuilder: (context, index) {
                      return const CustomDivider();
                    },
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedInterests = interests[index];
                            Navigator.pop(context);
                            widget.discipline!.text = interests[index];
                            widget.disciplineId!.text = '${index+1}';

                            // Print("Selected stable ${stables[index]}");
                            Print("disipline Name $selectedInterests");
                          });
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text(interests[index])],
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
        return Validator.requiredValidator(widget.discipline!.text);
      },
    );
  }
}
