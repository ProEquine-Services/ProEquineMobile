import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/horses/presentation/widgets/horses_form_widget.dart';
import 'package:proequine/features/transports/data/update_local_transport_request_model.dart';
import 'package:proequine/features/transports/domain/transport_cubit.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../home/data/trip_service_data_model.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';

class EditShowHorsesScreen extends StatefulWidget {
  final int? id;
  final int? transportId;
  final TripServiceDataModel tripServiceDataModel;
  final String? note;
  final int? pickupPlaceId;
  final int? dropPlaceId;

  const EditShowHorsesScreen(
      {Key? key,
      required this.tripServiceDataModel,
      this.transportId,
      required this.pickupPlaceId,
      required this.dropPlaceId,
      this.note,
      this.id})
      : super(key: key);

  @override
  State<EditShowHorsesScreen> createState() => _EditShowHorsesScreenState();
}

class _EditShowHorsesScreenState extends State<EditShowHorsesScreen> {
  List<TextEditingController> horsesNameControllers = [];
  TextEditingController note = TextEditingController();

  List<int> selectedHorse = [];
  List<TextEditingController> horsesControllers = [];
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

  TransportCubit cubit = TransportCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Show Transport",
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
                    child: BlocConsumer<TransportCubit, TransportState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is UpdateLocalTransportSuccessfully) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BottomNavigation(
                                        selectedIndex: 1,
                                      )));
                        } else if (state is UpdateLocalTransportError) {
                          RebiMessage.error(
                              msg: state.message!, context: context);
                        }
                      },
                      builder: (context, state) {
                        if (state is UpdateLocalTransportLoading) {
                          return const LoadingCircularWidget();
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kPadding,
                          ),
                          child: RebiButton(
                            backgroundColor: AppColors.yellow,
                            onPressed: () {
                              _onPressSubmit();
                            },
                            child: Text(
                              "Submit",
                              style: AppStyles.buttonStyle,
                            ),
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

  _onPressSubmit() {
    cubit.updateTransport(UpdateTransportRequestModel(
      id: widget.id,
      horseIds: selectedHorse,
      pickUpLocation: widget.pickupPlaceId,
      type: 'Show',
      pickUpDate: widget.tripServiceDataModel.pickupDate.toIso8601String(),
      pickUpTime: widget.tripServiceDataModel.pickupTime,
      pickUpContactName: widget.tripServiceDataModel.pickupContactName,
      pickUpPhoneNumber: widget.tripServiceDataModel.pickupContactNumber,
      numberOfHorses: int.parse(widget.tripServiceDataModel.horsesNumber),
      dropLocation: widget.dropPlaceId,
      notes: note.text,
    ));
  }
}
