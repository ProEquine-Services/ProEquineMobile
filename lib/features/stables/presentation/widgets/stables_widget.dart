import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/widgets/loading_widget.dart';
import 'package:proequine_dev/features/stables/domain/stable_cubit.dart';

import '../../../../../../core/constants/colors/app_colors.dart';
import '../../../../../../core/utils/Printer.dart';
import '../../../../../../core/utils/validator.dart';
import '../../../../../../core/widgets/divider.dart';
import '../../../../../../core/widgets/rebi_input.dart';
import '../../../home/presentation/widgets/hospital_bottom_sheet.dart';
import '../../data/get_stables_response_model.dart';

class SelectStableWidget extends StatefulWidget {
  TextEditingController stableName = TextEditingController();
  TextEditingController stableId = TextEditingController();
  VoidCallback? changeTrue;
  VoidCallback? changeFalse;
  bool readOnly = false;

  SelectStableWidget({
    Key? key,
    required this.stableName,
    required this.stableId,
    this.changeFalse,
    this.readOnly = false,
    this.changeTrue,
  }) : super(key: key);

  @override
  State<SelectStableWidget> createState() => _SelectStableWidgetState();
}

class _SelectStableWidgetState extends State<SelectStableWidget> {
  Stable? selectedStable;

  StableCubit cubit = StableCubit();
  Timer? debounce;
  TextEditingController selectedStableName = TextEditingController();
  TextEditingController selectedStableId = TextEditingController();

  _onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      BlocProvider.of<StableCubit>(context).getAllStables(
        limit: 1000,
        fullName: query,
      );

      // do something with query
    });
  }

  @override
  void initState() {
    BlocProvider.of<StableCubit>(context).getAllStables(
      limit: 1000,
    );
    super.initState();
  }

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
            searchBar: TextField(
              onSubmitted: (value) {
                cubit.getAllStables(
                  limit: 1000,
                  fullName: value,
                );
              },
              onChanged: _onSearchChanged,
              controller: selectedStableName,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8.0),
                hintText: 'Search..'.tra,
                hintStyle: const TextStyle(fontSize: 16),
                prefixIcon: const Icon(Icons.search, color: AppColors.yellow),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            content: BlocConsumer<StableCubit, StableState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is GetAllStablesSuccessfully) {
                  if (state.stables.isEmpty) {
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
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.stables.length,
                              separatorBuilder: (context, index) {
                                if (state.stables.isEmpty) {
                                  return Container();
                                } else {
                                  return const CustomDivider();
                                }
                              },
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedStable = state.stables[index];
                                        if (state.stables[index].name ==
                                            'Add your stable') {
                                          widget.changeTrue!.call();
                                          Navigator.pop(context);
                                        } else {
                                          widget.changeFalse!.call();
                                          Navigator.pop(context);

                                          // Print(widget.changeFalse);
                                        }

                                        widget.stableName.text =
                                            state.stables[index].name!;
                                        widget.stableId.text =
                                            state.stables[index].id!.toString();
                                        Print("Stable Name $selectedStable");
                                      });
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.stables[index].name!,
                                              style: TextStyle(
                                                fontSize: 16,
                                                  color:
                                                      state.stables[index].name ==
                                                              'Add your stable'
                                                          ? AppColors.yellow
                                                          : AppColors.blackLight),
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                              }),
                        ],
                      ),
                    );
                  }
                } else if (state is GetAllStablesLoading) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Transform.translate(
                        offset:const Offset(0.0, 200),
                        child: const Center(
                          child: LoadingCircularWidget(),
                        ),
                      )
                    ],
                  );
                } return Container();
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
