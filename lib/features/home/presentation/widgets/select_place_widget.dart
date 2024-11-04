import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../data/new_place_response_model.dart';
import '../../domain/cubits/home_cubit.dart';
import '../screens/saved_places_screen.dart';
import 'hospital_bottom_sheet.dart';

class SelectPlaceWidget extends StatefulWidget {
  TextEditingController lat = TextEditingController();
  final String hintText;
  TextEditingController? lng = TextEditingController();
  String category;
  TextEditingController placeName = TextEditingController();
  TextEditingController selectedPlaceId = TextEditingController();
  VoidCallback? changeTrue;
  VoidCallback? changeFalse;

  SelectPlaceWidget({
    Key? key,
    required this.lat,
    required this.changeFalse,
    required this.changeTrue,
    required this.selectedPlaceId,
    required this.lng,
    required this.placeName,
    required this.category, required this.hintText,
  }) : super(key: key);

  @override
  State<SelectPlaceWidget> createState() => _SelectPlaceWidgetState();
}

class _SelectPlaceWidgetState extends State<SelectPlaceWidget> {
  TextEditingController selectedPlaceName = TextEditingController();

  HomeCubit cubit = HomeCubit();
  AddNewPlaceResponseModel? result;
  String? selectedPlace;
  Timer? debounce;

  _onSearchChanged(String query) {
    if (debounce?.isActive ?? false) debounce?.cancel();
    debounce = Timer(const Duration(milliseconds: 500), () {
      cubit.getAllPlaces(
          limit: 1000, fullName: query, category: widget.category);
    });
  }

  String? name;

  @override
  void initState() {
    Print(widget.category);
    // BlocProvider.of<HomeCubit>(context).getAllPlaces(
    //   limit: 1000,
    //     category: widget.category
    // );
    super.initState();
  }

  @override
  void dispose() {
    // BlocProvider.of<HomeCubit>(context).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPadding,vertical: 7),
      child: RebiInput(
        hintText: widget.hintText,
        controller: widget.placeName,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {

          });
        },
        textInputAction: TextInputAction.done,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        isOptional: false,
        color: AppColors.formsLabel,
        onTap: () {
          showHospitalsAndPlacesBottomSheet(
            context: context,
            title: "Select Place",
            searchBar: TextField(
              onSubmitted: (value) {
                cubit.getAllPlaces(
                    limit: 1000, fullName: value, category: widget.category);
              },
              onChanged: (value) {
                setState(() {
                  name = value;
                });
                _onSearchChanged(value);
              },
              controller: selectedPlaceName,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8.0),
                hintText: 'Search by name'.tra,
                hintStyle: const TextStyle(fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: AppColors.grey),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.gold),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            content: BlocConsumer<HomeCubit, HomeState>(
              bloc: cubit
                ..getAllPlaces(
                    limit: 1000, category: widget.category, fullName: name),
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is GetAllPlacesSuccessfully) {
                  if (state.places.isEmpty) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Center(
                          child: Text("No Places"),
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
                              itemCount: state.places.length,
                              separatorBuilder: (context, index) {
                                if (state.places.isEmpty) {
                                  return Container();
                                } else {
                                  return const CustomDivider();
                                }
                              },
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedPlace =
                                            state.places[index].name;
                                        if (state.places[index].name ==
                                            'My Places') {
                                          widget.changeTrue!.call();
                                          Navigator.pop(context);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UserPlacesScreen(
                                                        category:
                                                        widget.category,
                                                      ))).then((value) {
                                            setState(() {
                                              result = value;
                                              widget.placeName.text =
                                              result!.name!;

                                              widget.selectedPlaceId.text =
                                                  result!.id.toString();
                                              Print(result!.id);
                                            });
                                          });
                                        } else {
                                          widget.changeFalse!.call();
                                          Navigator.pop(context);
                                          Print('result!.id');
                                          setState(() {
                                            widget.selectedPlaceId.text = state
                                                .places[index].id!
                                                .toString();
                                            Print(widget.selectedPlaceId.text);
                                            Print(state
                                                .places[index].id!
                                                .toString());
                                          });


                                          Print(widget.changeFalse);
                                        }

                                        widget.placeName.text =
                                        state.places[index].name!;
                                      });
                                    },
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.places[index].name ==
                                                  'My Places'
                                                  ? 'My Places'
                                                  : '${state.places[index]
                                                  .code!} - ${state
                                                  .places[index].name!}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: state.places[index]
                                                      .name ==
                                                      'My Places'
                                                      ? AppColors.gold
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
                } else if (state is GetAllPlacesLoading) {
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
          return Validator.requiredValidator(widget.placeName.text);
        },
      ),
    );
  }
}
