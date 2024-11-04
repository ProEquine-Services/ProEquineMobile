import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/utils/rebi_message.dart';
import 'package:proequine_dev/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine_dev/core/widgets/divider.dart';
import 'package:proequine_dev/core/widgets/loading_widget.dart';
import 'package:proequine_dev/core/widgets/rebi_button.dart';
import 'package:proequine_dev/features/transports/data/create_transport_request_model.dart';
import 'package:proequine_dev/features/transports/data/update_local_transport_request_model.dart';
import 'package:proequine_dev/features/transports/presentation/screens/local_summary.dart';
import 'package:proequine_dev/features/horses/presentation/widgets/horses_form_widget.dart';
import 'package:proequine_dev/features/transports/domain/transport_cubit.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/validate_horse_functions.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../home/data/trip_service_data_model.dart';

class ChoseTripHorseScreen extends StatefulWidget {
  final int? id;
  final TripServiceDataModel tripServiceDataModel;
  final String? note;
  final int? pickupPlaceId;
  final int? dropPlaceId;
  final bool edit;
  final String? status;

  const ChoseTripHorseScreen(
      {Key? key,
      required this.tripServiceDataModel,
      required this.pickupPlaceId,
      this.note,
      required this.dropPlaceId, this.status,
      this.edit = false,
      this.id})
      : super(key: key);

  @override
  State<ChoseTripHorseScreen> createState() => _ChoseTripHorseScreenState();
}

class _ChoseTripHorseScreenState extends State<ChoseTripHorseScreen> {
  List<TextEditingController> horsesNameControllers = [];
  TextEditingController note = TextEditingController();

  List<int> selectedHorse = [];

  List<TextEditingController> horsesControllers = [];
  TransportCubit cubit = TransportCubit();
  Map<String, String> horses = {};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? horsesNumbers;

  @override
  void initState() {
    var controllersTexts = List<String>.generate(
        int.parse(widget.tripServiceDataModel.horsesNumber),
        (counter) => "Select a horse");
    for (var str in controllersTexts) {
      var textEditingController = TextEditingController(text: str);
      horsesControllers.add(textEditingController);
    }

    var newHorsesText = List<String>.generate(
        int.parse(widget.tripServiceDataModel.horsesNumber), (counter) => "");
    for (var str in newHorsesText) {
      var textEditingController = TextEditingController(text: str);
      horsesNameControllers.add(textEditingController);
    }
    AppSharedPreferences.firstTime = true;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');

    super.initState();
    note.text = widget.note ?? '';

    horsesNumbers = int.parse(widget.tripServiceDataModel.horsesNumber);
    Print(" Horses Numbers is $horsesNumbers");
  }

  @override
  void dispose() {
    for (var controller in horsesControllers) {
      controller.dispose();
    }
    for (var newController in horsesNameControllers) {
      newController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: widget.tripServiceDataModel.trip == 'hospital' ||
                  widget.tripServiceDataModel.trip == 'Hospital'
              ? "Hospital Transport"
              : "Local Transport",
          isThereBackButton: true,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: horsesNumbers! > 2 ? 120.h : 85.0.h,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const CustomDivider();
                      },
                      itemCount: horsesNumbers!,
                      itemBuilder: (context, index) {
                        return SelectHorseFormWidget(
                            currentIndex: index,
                            horsesIds: selectedHorse,
                            horseId: horsesControllers[index],
                            horseName: horsesNameControllers[index]);
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 7, horizontal: kPadding),
                    child: RebiInput(
                      hintText: 'Notes'.tra,
                      controller: note,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      textInputAction: TextInputAction.done,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      isOptional: true,
                      readOnly: false,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      obscureText: false,
                      validator: (value) {
                        // return Validator.requiredValidator(note.text);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kPadding,
                    ),
                    child: widget.edit
                        ? BlocConsumer<TransportCubit, TransportState>(
                            bloc: cubit,
                            listener: (context, state) {
                              if (state is UpdateLocalTransportSuccessfully) {
                                // RebiMessage.success(
                                //     msg: "Local Transport has been Registered Succe", context: context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LocalSummary(
                                              tripId: state.responseModel.id!,
                                              edit: true,
                                              tripServiceDataModel:
                                                  state.responseModel,
                                            )));
                              } else if (state is UpdateLocalTransportError) {
                                Print(widget.tripServiceDataModel.tripType);
                                RebiMessage.error(
                                    msg: state.message!, context: context);
                              }
                            },
                            builder: (context, state) {
                              if (state is UpdateLocalTransportLoading) {
                                return const LoadingCircularWidget();
                              }
                              return RebiButton(
                                backgroundColor: AppColors.yellow,
                                onPressed: () {
                                  Print("Selected horses $selectedHorse");

                                  if (_formKey.currentState!.validate() &&
                                      validateHorses(horsesControllers)) {
                                    cubit.updateTransport(
                                        UpdateTransportRequestModel(
                                      id: widget.id,
                                      horseIds: selectedHorse,
                                      type: widget.tripServiceDataModel.trip ==
                                              'hospital'
                                          ? "Hospital"
                                          : widget
                                              .tripServiceDataModel.tripType,
                                      pickUpTime: widget
                                          .tripServiceDataModel.pickupTime,
                                      pickUpDate: widget
                                          .tripServiceDataModel.pickupDate
                                          .toIso8601String(),
                                      pickUpLocation: widget.pickupPlaceId,
                                      pickUpPhoneNumber: widget
                                          .tripServiceDataModel
                                          .pickupContactNumber,
                                      dropLocation: widget.dropPlaceId,
                                      pickUpContactName: widget
                                          .tripServiceDataModel
                                          .pickupContactName,
                                      dropPhoneNumber: widget
                                          .tripServiceDataModel
                                          .dropContactNumber,
                                      dropContactName: widget
                                          .tripServiceDataModel.dropContactName,
                                      numberOfHorses: selectedHorse.length,
                                      returnDate: widget
                                              .tripServiceDataModel.expectedDate
                                              ?.toIso8601String() ??
                                          '',
                                      returnTime: widget.tripServiceDataModel
                                              .expectedTime ??
                                          '',
                                      notes: note.text,
                                    ));
                                  } else {
                                    RebiMessage.error(
                                        msg:
                                            "Select a horse",
                                        context: context);
                                  }
                                },
                                child: Text(
                                  "Next",
                                  style: AppStyles.buttonStyle,
                                ),
                              );
                            },
                          )
                        : BlocConsumer<TransportCubit, TransportState>(
                            bloc: cubit,
                            listener: (context, state) {
                              if (state is CreateLocalTransportSuccessfully) {
                                // RebiMessage.success(
                                //     msg: "Local Transport has been Registered Succe", context: context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LocalSummary(
                                              tripId: state.responseModel.id!,
                                              tripServiceDataModel:
                                                  state.responseModel,
                                            )));
                              } else if (state is CreateLocalTransportError) {
                                Print(widget.tripServiceDataModel.tripType);
                                RebiMessage.error(
                                    msg: state.message!, context: context);
                              }
                            },
                            builder: (context, state) {
                              if (state is CreateLocalTransportLoading) {
                                return const LoadingCircularWidget();
                              }
                              return RebiButton(
                                backgroundColor: AppColors.yellow,
                                onPressed: () {
                                  Print("Selected horses $selectedHorse");

                                  if (_formKey.currentState!.validate() &&
                                      validateHorses(horsesControllers)) {
                                    cubit.createTransport(
                                        CreateTransportRequestModel(
                                      horseIds: selectedHorse,
                                      type: widget.tripServiceDataModel.trip ==
                                              'hospital'
                                          ? "Hospital"
                                          : widget
                                              .tripServiceDataModel.tripType,
                                      pickUpTime: widget
                                          .tripServiceDataModel.pickupTime,
                                      pickUpDate: widget
                                          .tripServiceDataModel.pickupDate
                                          .toIso8601String(),
                                      pickUpLocation: widget.pickupPlaceId,
                                      pickUpPhoneNumber: widget
                                          .tripServiceDataModel
                                          .pickupContactNumber,
                                      dropLocation: widget.dropPlaceId,
                                      pickUpContactName: widget
                                          .tripServiceDataModel
                                          .pickupContactName,
                                      dropPhoneNumber: widget
                                          .tripServiceDataModel
                                          .dropContactNumber,
                                      dropContactName: widget
                                          .tripServiceDataModel.dropContactName,
                                      numberOfHorses: selectedHorse.length,
                                      returnDate: widget
                                              .tripServiceDataModel.expectedDate
                                              ?.toIso8601String() ??
                                          '',
                                      returnTime: widget.tripServiceDataModel
                                              .expectedTime ??
                                          '',
                                      notes: note.text,
                                    ));
                                  } else {
                                    RebiMessage.error(
                                        msg:
                                            "Please select a horse for each field.",
                                        context: context);
                                  }
                                },
                                child: Text(
                                  "Next",
                                  style: AppStyles.buttonStyle,
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
