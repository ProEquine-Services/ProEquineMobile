import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../home/data/trip_service_data_model.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../../shipping/data/create_shipping_request_model.dart';
import '../../../shipping/data/join_selective_service_request_model.dart';
import '../../../shipping/domain/shipping_cubit.dart';
import '../../../shipping/presentation/widgets/select_shipping_horse_widget.dart';

class ChoseShowHorsesScreen extends StatefulWidget {
  final int? id;
  final int? transportId;
  final TripServiceDataModel tripServiceDataModel;
  final String? note;
  final int? pickupPlaceId;
  bool updateRequest;

   ChoseShowHorsesScreen({Key? key,
    required this.tripServiceDataModel,
    this.updateRequest=false,
    this.transportId,
    required this.pickupPlaceId, this.note,
    this.id})
      : super(key: key);

  @override
  State<ChoseShowHorsesScreen> createState() => _ChoseShowHorsesScreenState();
}

class _ChoseShowHorsesScreenState extends State<ChoseShowHorsesScreen> {
  List<TextEditingController> horsesNameControllers = [];
  TextEditingController note = TextEditingController();

  List<ShippingHorses> selectedHorsesIds = [];
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

  ShippingCubit cubit = ShippingCubit();

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
                        return SelectShippingHorseWidget(
                          formKey: _formKey,
                          withoutDetails: true,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: kPadding,
                    ),
                    child: BlocConsumer<ShippingCubit, ShippingState>(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is JoinSelectiveServiceSuccessfully) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavigation(
                                        selectedIndex: 1,
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
                            horizontal: 0,
                          ),
                          child: RebiButton(
                            backgroundColor: AppColors.yellow,
                            onPressed: () {
                              _onPressSubmit();
                            },
                            child: const Text(
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
    cubit.joinSelectiveService(JoinSelectiveServiceRequestModel(
      id: widget.id,
      horses: selectedHorsesIds,
      placeId: widget.pickupPlaceId,
      pickupDate: widget.tripServiceDataModel.pickupDate.toIso8601String(),
      pickupTime: widget.tripServiceDataModel.pickupTime,
      pickUpContactName: widget.tripServiceDataModel.pickupContactName,
      pickUpPhoneNumber: widget.tripServiceDataModel.pickupContactNumber,
      numberOfHorses: int.parse(widget.tripServiceDataModel.horsesNumber),
      notes: note.text,));
  }
}
