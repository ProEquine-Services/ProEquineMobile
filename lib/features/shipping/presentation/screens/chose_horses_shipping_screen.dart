import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/utils/rebi_message.dart';
import 'package:proequine_dev/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine_dev/core/widgets/divider.dart';
import 'package:proequine_dev/core/widgets/loading_widget.dart';
import 'package:proequine_dev/core/widgets/rebi_button.dart';
import 'package:proequine_dev/features/home/data/shipping_service_model.dart';
import 'package:proequine_dev/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:proequine_dev/features/shipping/data/create_shipping_request_model.dart';
import 'package:proequine_dev/features/shipping/data/join_selective_service_request_model.dart';
import 'package:proequine_dev/features/shipping/domain/shipping_cubit.dart';

import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/select_shipping_horse_widget.dart';
import 'confirm_horses_screen.dart';

class ChoseShippingHorseScreen extends StatefulWidget {
  final ShippingServiceModel? serviceModel;
  final String pickUpCountry;
  final int? selectiveServiceId;
  final String dropCountry;
  bool isItFromEditing = false;

  ChoseShippingHorseScreen(
      {Key? key,
      this.serviceModel,
      this.isItFromEditing = false,
      required this.pickUpCountry,
      required this.dropCountry,
      this.selectiveServiceId})
      : super(key: key);

  @override
  State<ChoseShippingHorseScreen> createState() =>
      _ChoseShippingHorseScreenState();
}

class _ChoseShippingHorseScreenState extends State<ChoseShippingHorseScreen> {
  List<TextEditingController> newHorsesControllers = [];
  TextEditingController note = TextEditingController();

  List<ShippingHorses> selectedHorsesIds = [];
  ShippingCubit cubit = ShippingCubit();

  List<TextEditingController> horsesControllers = [];
  Map<String, String> horses = {};

  @override
  void initState() {
    super.initState();
    Print('the select status is ${widget.isItFromEditing}');
    var controllersTexts = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber),
        (counter) => "Select a horse");
    for (var str in controllersTexts) {
      var textEditingController = TextEditingController(text: str);
      horsesControllers.add(textEditingController);
    }

    var newHorsesText = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber), (counter) => "");
    for (var str in newHorsesText) {
      var textEditingController = TextEditingController(text: str);
      newHorsesControllers.add(textEditingController);
    }
    AppSharedPreferences.firstTime = true;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');
    super.initState();

    horsesNumbers = int.parse(widget.serviceModel!.horsesNumber);
    Print(" Horses Numbers is $horsesNumbers");
  }

  @override
  void dispose() {
    super.dispose();
    for (TextEditingController textEditingController in horsesControllers) {
      textEditingController.dispose();
    }
    for (TextEditingController textEditingController in newHorsesControllers) {
      textEditingController.dispose();
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  int? horsesNumbers;

  @override
  Widget build(BuildContext context) {
    List<bool> isChoseNewHorse = List<bool>.generate(
        int.parse(widget.serviceModel!.horsesNumber), (counter) => false);
    List<String> selectedHorse = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber), (counter) => "");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Shipping",
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
                        return SelectShippingHorseWidget(
                            formKey: _formKey,
                            currentIndex: index,
                            horsesIds: selectedHorsesIds,
                            horseId: horsesControllers[index],
                            horseName: horsesControllers[index]);
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
                  const SizedBox(
                    height: 20,
                  ),
                  widget.isItFromEditing
                      ? BlocConsumer<ShippingCubit, ShippingState>(
                          bloc: cubit,
                          listener: (context, state) {
                            if (state is JoinSelectiveServiceSuccessfully) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavigation(
                                            selectedIndex: 2,
                                          )));
                            } else if (state is JoinSelectiveServiceError) {
                              RebiMessage.error(
                                  msg: state.message!, context: context);
                            }
                          },
                          builder: (context, state) {
                            if (state is JoinSelectiveServiceLoading) {
                              return const LoadingCircularWidget();
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: kPadding,
                              ),
                              child: RebiButton(
                                backgroundColor: AppColors.yellow,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _onPressSubmit();
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: AppStyles.buttonStyle,
                                ),
                              ),
                            );
                          },
                        )
                      : BlocConsumer<ShippingCubit, ShippingState>(
                          bloc: cubit,
                          listener: (context, state) {
                            if (state is CreateShippingSuccessfully) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConfirmHorsesScreen(
                                            shippingId: state.responseModel.id!,
                                            selectedCountry:
                                                state.responseModel.type ==
                                                        'Import'
                                                    ? state.responseModel
                                                        .pickUpCountry!
                                                    : state.responseModel
                                                        .dropCountry!,
                                            serviceModel: widget.serviceModel,
                                          )));
                            } else if (state is CreateShippingError) {
                              RebiMessage.error(
                                  msg: state.message!, context: context);
                            }
                          },
                          builder: (context, state) {
                            if (state is CreateShippingLoading) {
                              return const LoadingCircularWidget();
                            }
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: kPadding,
                              ),
                              child: RebiButton(
                                backgroundColor: AppColors.yellow,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {

                                    onPressNext();
                                  }
                                },
                                child: Text(
                                  "Next",
                                  style: AppStyles.buttonStyle,
                                ),
                              ),
                            );
                          },
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

  onPressNext() {
    cubit.createShipping(CreateShippingRequestModel(
        shippingHorses: selectedHorsesIds,
        type: widget.serviceModel!.serviceType,
        placeId: widget.serviceModel!.placeId,
        dropPhoneNumber: widget.serviceModel!.dropPhoneNumber,
        dropContactName: widget.serviceModel!.dropContactName,
        pickUpContactName: widget.serviceModel!.pickupContactName,
        pickUpPhoneNumber: widget.serviceModel!.pickupContactNumber,
        pickUpCountry: widget.pickUpCountry,
        dropCountry: widget.dropCountry,
        numberOfHorses: int.parse(widget.serviceModel!.horsesNumber),
        pickUpDate:
            widget.serviceModel!.shipmentEstimatedDate.toIso8601String(),
        tackAndEquipment: widget.serviceModel!.equipment,
        notes: note.text,
        chooseLocation: widget.serviceModel!.location));
  }

  _onPressSubmit() {
    cubit.joinSelectiveService(JoinSelectiveServiceRequestModel(
        id: widget.selectiveServiceId,
        horses: selectedHorsesIds,
        placeId: widget.serviceModel!.placeId,
        dropPhoneNumber: widget.serviceModel!.dropPhoneNumber,
        dropContactName: widget.serviceModel!.dropContactName,
        pickUpContactName: widget.serviceModel!.pickupContactName,
        pickUpPhoneNumber: widget.serviceModel!.pickupContactNumber,
        numberOfHorses: int.parse(widget.serviceModel!.horsesNumber),
        tackAndEquipment: widget.serviceModel!.equipment,
        notes: note.text,
        chooseLocation: widget.serviceModel!.location));
  }
}
