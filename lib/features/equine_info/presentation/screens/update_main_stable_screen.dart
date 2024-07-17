import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../stables/data/chose_stable_request_model.dart';
import '../../../stables/domain/stable_cubit.dart';
import '../../../stables/presentation/widgets/stables_widget.dart';
import '../../../manage_account/data/basic_account_management_route.dart';

class UpdateMainStableScreen extends StatefulWidget {
  final String mainStable;
  final int stableId;

  const UpdateMainStableScreen(
      {Key? key, required this.mainStable, required this.stableId})
      : super(key: key);

  @override
  State<UpdateMainStableScreen> createState() => _UpdateMainStableScreenState();
}

class _UpdateMainStableScreenState extends State<UpdateMainStableScreen> {
  StableCubit cubit = StableCubit();

  // final UserCubit cubit = UserCubit();
  void changeToTrueValue() {
    setState(() {
      isChooseToAddStable = true;
    });
  }

  void changeToFalseValue() {
    setState(() {
      isChooseToAddStable = false;
    });
  }

  String? selectedMainStable;
  String? selectedEmirate;
  late final TextEditingController _mainStableName;
  late final TextEditingController _mainStableLocation;
  late TextEditingController stableId;
  late final TextEditingController stable;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isChooseToAddStable = false;

  @override
  void initState() {
    AppSharedPreferences.firstTime = true;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');
    _mainStableLocation = TextEditingController();
    stableId = TextEditingController(text: widget.stableId.toString());
    _mainStableName = TextEditingController();
    stable = TextEditingController(text: widget.mainStable);
    selectedMainStable = widget.mainStable;
    super.initState();
  }

  @override
  void dispose() {
    _mainStableLocation.dispose();
    _mainStableName.dispose();
    stableId.dispose();
    stable.dispose();
    // cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
            title: "Update Main Stable",
            isThereBackButton: true,
            isThereChangeWithNavigate: false,
            isThereThirdOption: false),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Chose Your main Stable",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "This feature is available in UAE only.",
                                    style: AppStyles.descriptions),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SelectStableWidget(
                                stableId: stableId,
                                stableName: stable,
                                changeTrue: changeToTrueValue,
                                changeFalse: changeToFalseValue,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible: isChooseToAddStable,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Add Your Stable ",
                                      style: AppStyles.mainTitle2),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: isChooseToAddStable,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      "in order to update your main discipline - you need to submit this form and wait for the request approval",
                                      style: AppStyles.descriptions),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: isChooseToAddStable,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: RebiInput(
                                    hintText: 'Stable Name'.tra,
                                    controller: _mainStableName,
                                    scrollPadding:
                                        const EdgeInsets.only(bottom: 100),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    isOptional: false,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    color: AppColors.formsLabel,
                                    readOnly: false,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 13),
                                    obscureText: false,
                                    validator: (value) {
                                      return Validator.requiredValidator(
                                          _mainStableName.text);
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isChooseToAddStable,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: RebiInput(
                                    hintText: 'Location'.tra,
                                    controller: _mainStableLocation,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    scrollPadding:
                                        const EdgeInsets.only(bottom: 100),
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    autoValidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    isOptional: false,
                                    color: AppColors.formsLabel,
                                    readOnly: false,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 13),
                                    obscureText: false,
                                    validator: (value) {
                                      return Validator.requiredValidator(
                                          _mainStableLocation.text);
                                    },
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: isChooseToAddStable,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7),
                                  child: DropDownWidget(
                                    items: emirate,
                                    selected: selectedEmirate,
                                    onChanged: (selectedEmi) {
                                      setState(() {
                                        selectedEmirate = selectedEmi;
                                        Print(
                                            'selected Emirate $selectedEmirate');
                                      });
                                    },
                                    validator: (value) {
                                      // return Validator.requiredValidator(selectedNumber);
                                    },
                                    hint: 'Emirate',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: _buildChooseStableConsumer(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildChooseStableConsumer() {
    return BlocConsumer<StableCubit, StableState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is ChoseStableLoading) {
            return const LoadingCircularWidget();
          }
          {
            final isButtonEnabled =
                (stable.text.isNotEmpty && stable.text != 'Add Main Stable') ||
                    (selectedEmirate != null &&
                        _mainStableName.text.isNotEmpty &&
                        _mainStableLocation.text.isNotEmpty);
            return RebiButton(
              backgroundColor:
                  isButtonEnabled ? AppColors.yellow : AppColors.formsLabel,
              onPressed: () {
                if ((stable.text.isNotEmpty &&
                        stable.text != 'Add Main Stable') ||
                    (selectedEmirate != null &&
                        _mainStableName.text.isNotEmpty &&
                        _mainStableLocation.text.isNotEmpty)) {
                  _onPressConfirm();
                } else {
                  Print("chose add stable $isChooseToAddStable");
                  RebiMessage.error(
                      msg: 'Select main stable', context: context);
                }
              },
              child: Text(
                "Next",
                style: AppStyles.buttonStyle,
              ),
            );
          }
        },
        listener: (context, state) {
          if (state is ChoseStableSuccessful) {
            Navigator.pushReplacementNamed(context, successScreen,
                arguments: BasicAccountManagementRoute(
                    type: 'manageAccount',
                    title: isChooseToAddStable
                        ? "Request submitted successfully."
                        : "Main stable updated successfully"));
          } else if (state is ChoseStableError) {
            RebiMessage.error(msg: state.message!, context: context);
          }
        });
  }

  _onPressConfirm() {
    return cubit
      ..choseStable(ChoseMainStableRequestModel(
        id: int.parse(stableId.text),
        isUpdated: true,
        name: isChooseToAddStable ? _mainStableName.text : stable.text,
        emirate: selectedEmirate,
        pinLocation: _mainStableLocation.text,
      ));
  }
}
