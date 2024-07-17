import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/equine_info/domain/equine_info_cubit.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../features/home/presentation/widgets/hospital_bottom_sheet.dart';

class UserStableWidget extends StatefulWidget {
  TextEditingController stableName = TextEditingController();
  TextEditingController stableId = TextEditingController();
  final int userId;

  bool readOnly = false;

  UserStableWidget({
    Key? key,
    required this.stableName,
    required this.stableId,
    this.readOnly = false, required this.userId,

  }) : super(key: key);

  @override
  State<UserStableWidget> createState() => _UserStableWidgetState();
}

class _UserStableWidgetState extends State<UserStableWidget> {

  EquineInfoCubit cubit = EquineInfoCubit();

  @override
  Widget build(BuildContext context) {
    return RebiInput(
      hintText: "Stable",
      controller: widget.stableName,
      keyboardType: TextInputType.name,
      onChanged: (value) {
        setState(() {});
      },
      textInputAction: TextInputAction.done,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      isOptional: false,
      color: AppColors.formsLabel,
      onTap: () {
        if (widget.readOnly) {
        } else {
          showHospitalsAndPlacesBottomSheet(
            context: context,
            title: "Stables",
            content: BlocBuilder<EquineInfoCubit, EquineInfoState>(
              bloc: cubit..getUserStables(widget.userId),

              builder: (context, state) {
                if (state is GetUserStablesSuccessful) {
                  return SingleChildScrollView(
                    child: StatefulBuilder(builder: (context, setState) {
                      if (state.model!.rows!.isNotEmpty) {
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.model!.rows!.length,
                          separatorBuilder: (context, index) {
                            return const CustomDivider();
                          },
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  widget.stableName.text = state
                                      .model!.rows![index].stable!
                                      .name!;
                                  widget.stableId.text = state
                                      .model!.rows![index].stableId!
                                      .toString();
                                  Print("Selected stable ${widget.stableName.text}");
                                  Navigator.pop(context);
                                  // Print("Stable Name $selectedStable");
                                });
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.model!.rows![index].stable!
                                          .name!,
                                      style: const TextStyle(
                                          color:
                                          AppColors.blackLight),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Center(
                              child: Text("No Stables"),
                            ),
                          ],
                        );
                      }
                    }),
                  );
                } else if (state is GetUserStablesLoading) {
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: LoadingCircularWidget(),
                      )
                    ],
                  );
                }else if (state is GetUserStablesError){
                  RebiMessage.error(msg: state.message!, context: context);
                }
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: LoadingCircularWidget(),
                    )
                  ],
                );
              },
            ),
          );
        }
      },
      readOnly: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      obscureText: false,
      validator: (value) {
        return Validator.requiredValidator(widget.stableName.text);
      },
    );
  }
}
