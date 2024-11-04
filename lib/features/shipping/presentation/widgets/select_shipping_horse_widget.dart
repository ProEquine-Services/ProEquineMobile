import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine_dev/core/widgets/rebi_button.dart';
import 'package:proequine_dev/features/horses/domain/horse_cubit.dart';
import 'package:proequine_dev/features/horses/presentation/screens/add_horse_screen.dart';
import 'package:proequine_dev/features/shipping/data/create_shipping_request_model.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../home/presentation/widgets/hospital_bottom_sheet.dart';

class SelectShippingHorseWidget extends StatefulWidget {
  bool withoutDetails;
  final GlobalKey<FormState> formKey;
  TextEditingController horseName = TextEditingController();
  TextEditingController horseId = TextEditingController();
  List<ShippingHorses> horsesIds;

  int currentIndex;

  SelectShippingHorseWidget({
    Key? key,
    required this.horseId,
    this.withoutDetails = false,
    required this.formKey,
    required this.horseName,
    required this.horsesIds,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<SelectShippingHorseWidget> createState() =>
      _SelectShippingHorseWidgetState();
}

class _SelectShippingHorseWidgetState extends State<SelectShippingHorseWidget> {
  String? selectedOwner;
  String? selectedStaying;
  TextEditingController selectedHorseName = TextEditingController();

  HorseCubit cubit = HorseCubit();
  String? selectedHorse;
  Timer? debounce;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cubit = BlocProvider.of<HorseCubit>(context);
  }




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
    BlocProvider.of<HorseCubit>(context).getAllUserAndAssociatedHorse(
      limit: 1000,
    );
    super.initState();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        child: Column(
          children: [
            RebiInput(
              hintText: "Select Horse",
              controller: selectedHorseName,
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
                                        if (context.mounted) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddHorseScreen(
                                                          userId: int.parse(
                                                              userId!))));
                                        }
                                      },
                                      child: const Text("Add Horse")),
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
                                              selectedHorseName.text =
                                                  state.horses[index].name!;

                                              widget.horseName.text =
                                                  state.horses[index].name!;
                                              widget.horseId.text = state
                                                  .horses[index].id!
                                                  .toString();
                                              while (widget.horsesIds.length <=
                                                  widget.currentIndex) {
                                                widget.horsesIds.add(ShippingHorses(
                                                    horseId: 0,
                                                    ownerShip: '',
                                                    staying:
                                                        '')); // Add default value, you can change it as per requirement
                                              }
                                              Print(state.horses[index].name);
                                              widget.horsesIds[
                                                      widget.currentIndex] =
                                                  ShippingHorses(
                                                      horseId: state
                                                          .horses[index].id!,
                                                      ownerShip: selectedOwner,
                                                      staying: selectedStaying);

                                              Navigator.pop(context);

                                              Print(widget.horsesIds);
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
                return Validator.requiredValidator(selectedHorseName.text);
              },
            ),
            Visibility(
              visible:
                  !widget.withoutDetails && selectedHorseName.text.isNotEmpty
                      ? true
                      : false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Ownership",
                    style: AppStyles.summaryTitleStyle,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOwner = 'New Purchase';
                            widget.horsesIds[widget.currentIndex].ownerShip =
                                selectedOwner;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedOwner == 'New Purchase'
                                  ? AppColors.yellow
                                  : AppColors.borderColor,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.5),
                                topRight: Radius.circular(20.5),
                                bottomLeft: Radius.circular(20.5),
                                bottomRight: Radius.circular(20.5)),
                            color: selectedOwner == 'New Purchase'
                                ? AppColors.yellow
                                : AppColors.backgroundColorLight,
                          ),
                          child: Text(
                            "New Purchase",
                            style: TextStyle(
                              color: selectedOwner == 'New Purchase'
                                  ? AppColors.backgroundColorLight
                                  : AppColors.blackLight,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: "notosan",
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOwner = 'Returning';
                            widget.horsesIds[widget.currentIndex].ownerShip =
                                selectedOwner;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedOwner == 'Returning'
                                  ? AppColors.yellow
                                  : AppColors.borderColor,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.5),
                                topRight: Radius.circular(20.5),
                                bottomLeft: Radius.circular(20.5),
                                bottomRight: Radius.circular(20.5)),
                            color: selectedOwner == 'Returning'
                                ? AppColors.yellow
                                : AppColors.backgroundColorLight,
                          ),
                          child: Text(
                            "Returning",
                            style: TextStyle(
                              color: selectedOwner == 'Returning'
                                  ? AppColors.backgroundColorLight
                                  : AppColors.blackLight,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: "notosan",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Staying",
                    style: AppStyles.summaryTitleStyle,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedStaying = 'Permanent';
                            widget.horsesIds[widget.currentIndex].staying =
                                selectedStaying;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedStaying == 'Permanent'
                                  ? AppColors.yellow
                                  : AppColors.borderColor,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.5),
                                topRight: Radius.circular(20.5),
                                bottomLeft: Radius.circular(20.5),
                                bottomRight: Radius.circular(20.5)),
                            color: selectedStaying == 'Permanent'
                                ? AppColors.yellow
                                : AppColors.backgroundColorLight,
                          ),
                          child: Text(
                            "Permanent",
                            style: TextStyle(
                              color: selectedStaying == 'Permanent'
                                  ? AppColors.backgroundColorLight
                                  : AppColors.blackLight,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: "notosan",
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedStaying = 'Temporary';
                            widget.horsesIds[widget.currentIndex].staying =
                                selectedStaying;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedStaying == 'Temporary'
                                  ? AppColors.yellow
                                  : AppColors.borderColor,
                            ),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.5),
                                topRight: Radius.circular(20.5),
                                bottomLeft: Radius.circular(20.5),
                                bottomRight: Radius.circular(20.5)),
                            color: selectedStaying == 'Temporary'
                                ? AppColors.yellow
                                : AppColors.backgroundColorLight,
                          ),
                          child: Text(
                            "Temporary",
                            style: TextStyle(
                              color: selectedStaying == 'Temporary'
                                  ? AppColors.backgroundColorLight
                                  : AppColors.blackLight,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: "notosan",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
