import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/home/data/shipping_service_model.dart';
import 'package:proequine/features/shipping/data/create_shipping_request_model.dart';
import 'package:proequine/features/shipping/data/edit_shipping_request_model.dart';
import 'package:proequine/features/shipping/data/user_shipping_response_model.dart';
import 'package:proequine/features/shipping/domain/shipping_cubit.dart';

import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../widgets/select_shipping_horse_widget.dart';
import 'confirm_horses_screen.dart';

class EditChoseShippingHorseScreen extends StatefulWidget {
  final ShippingServiceModel? serviceModel;
  final ShippingModel shippingModel;
  final List<ShippingHorses>? shippingHorses;
  final String pickUpCountry;
  final String dropCountry;
  bool isSelective = false;

  EditChoseShippingHorseScreen(
      {Key? key,
      this.serviceModel,
      this.isSelective = false,
      required this.pickUpCountry,
      required this.dropCountry,
      required this.shippingModel,
      this.shippingHorses})
      : super(key: key);

  @override
  State<EditChoseShippingHorseScreen> createState() =>
      _EditChoseShippingHorseScreenState();
}

class _EditChoseShippingHorseScreenState
    extends State<EditChoseShippingHorseScreen> {
  List<TextEditingController> newHorsesControllers = [];
  TextEditingController note = TextEditingController();

  List<ShippingHorses> selectedHorsesIds = [];
  ShippingCubit cubit = ShippingCubit();

  List<TextEditingController> horsesControllers = [];
  Map<String, String> horses = {};

  @override
  void initState() {
    // selectedHorsesIds = widget.shippingHorses;
    super.initState();
    var controllersTexts = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber),
        (counter) => "Select a horse");
    for (var str in controllersTexts) {
      var textEditingController = TextEditingController(text: str);
      horsesControllers.add(textEditingController);
    }

    for (int i = 0; i < widget.shippingModel.numberOfHorses!; i++) {
      horsesControllers.add(TextEditingController());
      // horsesControllers[i].text = widget.shippingModel.horses[i].horseId.toString();
      // Initialize text based on object property
    }

    var newHorsesText = List<String>.generate(
        int.parse(widget.serviceModel!.horsesNumber), (counter) => "");
    for (var str in newHorsesText) {
      var textEditingController = TextEditingController(text: str);
      newHorsesControllers.add(textEditingController);
    }

    Print(widget.shippingModel.pickUpCountry);
    Print(widget.pickUpCountry);

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
    var myCubit = context.watch<ShippingCubit>();
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
                  widget.shippingModel.status != 'Pending'
                      ? BlocConsumer<ShippingCubit, ShippingState>(
                          bloc: cubit,
                          listener: (context, state) {
                            if (state is EditShippingSuccessfully) {
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
                            } else if (state is EditShippingError) {
                              RebiMessage.error(
                                  msg: state.message!, context: context);
                            }
                          },
                          builder: (context, state) {
                            if (state is EditShippingLoading) {
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
                                  } else {}
                                },
                                child: Text(
                                  "Next",
                                  style: AppStyles.buttonStyle,
                                ),
                              ),
                            );
                          },
                        )
                      : BlocConsumer<ShippingCubit, ShippingState>(
                          bloc: cubit,
                          listener: (context, state) {
                            if (state is EditShippingSuccessfully) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              myCubit.getAllShippingRequests(limit: 1000);
                              RebiMessage.success(
                                  msg:
                                      "Request has been updated.",
                                  context: context);
                            } else if (state is EditShippingError) {
                              RebiMessage.error(
                                  msg: state.message!, context: context);
                            }
                          },
                          builder: (context, state) {
                            if (state is EditShippingLoading) {
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
                                  } else {}
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
    cubit.editShipping(EditShippingRequestModel(
        id: widget.shippingModel.id,
        shippingHorses: selectedHorsesIds,
        type: widget.serviceModel!.serviceType,
        placeId: int.parse(widget.serviceModel!.placeId.toString()),
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
}
