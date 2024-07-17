import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/horses/domain/horse_cubit.dart';
import 'package:proequine/features/horses/presentation/screens/add_horse_screen.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../home/presentation/widgets/hospital_bottom_sheet.dart';

class SelectHorseFormWidget extends StatefulWidget {
  TextEditingController horseName = TextEditingController();
  TextEditingController horseId = TextEditingController();
  List<int> horsesIds;
  int currentIndex;
  bool isFromEditing;

  SelectHorseFormWidget({
    Key? key,
    required this.horseId,
    this.isFromEditing = false,
    required this.horseName,
    required this.horsesIds,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<SelectHorseFormWidget> createState() => _SelectHorseFormWidgetState();
}

class _SelectHorseFormWidgetState extends State<SelectHorseFormWidget> {
  TextEditingController selectedHorseName = TextEditingController();

  HorseCubit cubit = HorseCubit();
  String? selectedHorse;
  Timer? debounce;

  _onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      BlocProvider.of<HorseCubit>(context).getAllUserAndAssociatedHorse(
        limit: 1000,
        name: query,
      );
    });
  }

  @override
  void initState() {
    if (widget.isFromEditing) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFromEditing
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: RebiInput(
              hintText: widget.horseName.text,
              controller: widget.horseName,
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
                  title: "Your Horses",
                  searchBar: TextField(
                    onSubmitted: (value) {
                      cubit.getAllUserAndAssociatedHorse(
                        limit: 1000,
                        name: value,
                      );
                    },
                    onChanged: _onSearchChanged,
                    controller: selectedHorseName,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      hintText: 'Search..'.tra,
                      hintStyle: const TextStyle(fontSize: 16),
                      prefixIcon:
                          const Icon(Icons.search, color: AppColors.yellow),
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
                  content: BlocConsumer<HorseCubit, HorseState>(
                    bloc: cubit..getAllUserAndAssociatedHorse(limit: 1000),
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is GetUserAndAssociatedHorsesSuccessfully) {
                        if (state.horses.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: RebiButton(
                                      onPressed: () async {
                                        final userId =
                                            await SecureStorage().getUserId();

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddHorseScreen(
                                                        userId: int.parse(
                                                            userId!))));
                                      },
                                      child: Text("Add Horse")),
                                ),
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.horses.length,
                                    separatorBuilder: (context, index) {
                                      if (state.horses.isEmpty) {
                                        return Container();
                                      } else {
                                        return const CustomDivider();
                                      }
                                    },
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedHorse =
                                                  state.horses[index].name;

                                              widget.horseName.text =
                                                  state.horses[index].name!;
                                              widget.horseId.text = state
                                                  .horses[index].id!
                                                  .toString();
                                              while (widget.horsesIds.length <=
                                                  widget.currentIndex) {
                                                widget.horsesIds.add(
                                                    0); // Add default value, you can change it as per requirement
                                              }
                                              Print(state.horses[index].name);
                                              widget.horsesIds[
                                                      widget.currentIndex] =
                                                  state.horses[index].id!;

                                              Navigator.pop(context);
                                            });
                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.horses[index].name!,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: AppColors
                                                            .blackLight),
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
                      } else if (state is GetUserAndAssociatedHorsesError) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.translate(
                              offset: const Offset(0.0, 200),
                              child: const Center(
                                child: LoadingCircularWidget(),
                              ),
                            )
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                );
              },
              readOnly: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              obscureText: false,
              validator: (value) {
                return Validator.requiredValidator(widget.horseName.text);
              },
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPadding),
            child: RebiInput(
              hintText: "Select Horse",
              controller: widget.horseName,
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
                  title: "Your Horses",
                  searchBar: TextField(
                    onSubmitted: (value) {
                      cubit.getAllUserAndAssociatedHorse(
                        limit: 1000,
                        name: value,
                      );
                    },
                    onChanged: _onSearchChanged,
                    controller: selectedHorseName,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8.0),
                      hintText: 'Search..'.tra,
                      hintStyle: const TextStyle(fontSize: 16),
                      prefixIcon:
                          const Icon(Icons.search, color: AppColors.yellow),
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
                  content: BlocConsumer<HorseCubit, HorseState>(
                    bloc: cubit..getAllUserAndAssociatedHorse(limit: 1000),
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is GetUserAndAssociatedHorsesSuccessfully) {
                        if (state.horses.isEmpty) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  child: RebiButton(
                                      onPressed: () async {
                                        final userId =
                                            await SecureStorage().getUserId();

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddHorseScreen(
                                                        userId: int.parse(
                                                            userId!))));
                                      },
                                      child: Text("Add Horse")),
                                ),
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: state.horses.length,
                                    separatorBuilder: (context, index) {
                                      if (state.horses.isEmpty) {
                                        return Container();
                                      } else {
                                        return const CustomDivider();
                                      }
                                    },
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedHorse =
                                                  state.horses[index].name;

                                              widget.horseName.text =
                                                  state.horses[index].name!;
                                              widget.horseId.text = state
                                                  .horses[index].id!
                                                  .toString();
                                              while (widget.horsesIds.length <=
                                                  widget.currentIndex) {
                                                widget.horsesIds.add(
                                                    0); // Add default value, you can change it as per requirement
                                              }
                                              Print(state.horses[index].name);
                                              widget.horsesIds[
                                                      widget.currentIndex] =
                                                  state.horses[index].id!;

                                              Navigator.pop(context);
                                            });
                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.horses[index].name!,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        color: AppColors
                                                            .blackLight),
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
                      } else if (state is GetUserAndAssociatedHorsesLoading) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Transform.translate(
                              offset: const Offset(0.0, 200),
                              child: const Center(
                                child: LoadingCircularWidget(),
                              ),
                            )
                          ],
                        );
                      }
                      return Container();
                    },
                  ),
                );
              },
              readOnly: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
              obscureText: false,
              validator: (value) {
                return Validator.requiredValidator(widget.horseName.text);
              },
            ),
          );
  }
}
