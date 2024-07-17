import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/equine_info/data/add_new_stable_request_model.dart';
import 'package:proequine/features/equine_info/data/add_seccondary_stable_model.dart';
import 'package:proequine/features/equine_info/data/add_secondary_stable_request_model.dart';
import 'package:proequine/features/equine_info/domain/equine_info_cubit.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../stables/presentation/widgets/stables_widget.dart';
import '../../../manage_account/data/basic_account_management_route.dart';
import '../../../nav_bar/domain/navbar_cubit.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';

class AddSecondaryStableScreen extends StatefulWidget {
  const AddSecondaryStableScreen({Key? key}) : super(key: key);

  @override
  State<AddSecondaryStableScreen> createState() =>
      _AddSecondaryStableScreenState();
}

class _AddSecondaryStableScreenState extends State<AddSecondaryStableScreen> {
  // final UserCubit cubit = UserCubit();

  String? selectedEmirate;
  late final TextEditingController _secondaryStableName;
  late final TextEditingController stable;
  late final TextEditingController stableId;
  late final TextEditingController _secondaryStableLocation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isChooseToAddStable = false;
  EquineInfoCubit cubit = EquineInfoCubit();

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

  @override
  void initState() {
    AppSharedPreferences.firstTime = true;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');
    _secondaryStableName = TextEditingController();
    _secondaryStableLocation = TextEditingController();
    stable = TextEditingController();
    stableId = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _secondaryStableLocation.dispose();
    _secondaryStableName.dispose();
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
            title: "Secondary Stable",
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
                              const SizedBox(
                                height: 15,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Stable",
                                    style: AppStyles.profileBlackTitles),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SelectStableWidget(
                                stableName: stable,
                                stableId: stableId,
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
                                      "in order to update your secondary stable - you need to submit this form and wait for the request approval",
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
                                    controller: _secondaryStableName,
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
                                          _secondaryStableName.text);
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
                                    controller: _secondaryStableLocation,
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
                                          _secondaryStableLocation.text);
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
                        isChooseToAddStable
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: BlocConsumer<EquineInfoCubit,
                                    EquineInfoState>(
                                  bloc: cubit,
                                  listener: (context, state) {
                                    if (state is AddNewStableSuccessful) {
                                      Navigator.pushReplacementNamed(
                                          context, successScreen,
                                          arguments: BasicAccountManagementRoute(
                                              type: 'manageAccount',
                                              title:
                                                  'Add new stable request sent successfully.'));
                                    } else if (state
                                        is AddNewStableError) {
                                      RebiMessage.error(
                                          msg: state.message!,
                                          context: context);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AddNewStableError) {
                                      return const LoadingCircularWidget();
                                    }
                                    return RebiButton(
                                      backgroundColor:
                                          (stable.text.isNotEmpty &&
                                                      stable.text !=
                                                          'Add your stable') ||
                                                  (selectedEmirate != null &&
                                                      _secondaryStableName
                                                          .text.isNotEmpty &&
                                                      _secondaryStableLocation
                                                          .text.isNotEmpty)
                                              ? AppColors.yellow
                                              : AppColors.formsLabel,
                                      onPressed: () {
                                        if ((stable.text.isNotEmpty &&
                                                stable.text !=
                                                    'Add your stable') ||
                                            (selectedEmirate != null &&
                                                _secondaryStableLocation
                                                    .text.isNotEmpty &&
                                                _secondaryStableName
                                                    .text.isNotEmpty)) {
                                          onPressAddNew();
                                        } else {
                                          RebiMessage.error(
                                              msg:
                                                  'Select secondary stable',
                                              context: context);
                                        }
                                      },
                                      child: Text("Save", style: AppStyles.buttonStyle,),
                                    );
                                  },
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: BlocConsumer<EquineInfoCubit,
                                    EquineInfoState>(
                                  bloc: cubit,
                                  listener: (context, state) {
                                    if (state is AddSecondaryStableSuccessful) {
                                      Navigator.pushReplacementNamed(
                                          context, successScreen,
                                          arguments: BasicAccountManagementRoute(
                                              type: 'manageAccount',
                                              title: 'New stable added successfully'));
                                    } else if (state
                                        is AddSecondaryStableError) {
                                      RebiMessage.error(
                                          msg: state.message!,
                                          context: context);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AddSecondaryStableLoading) {
                                      return const LoadingCircularWidget();
                                    }
                                    return RebiButton(
                                      backgroundColor:
                                          (stable.text.isNotEmpty &&
                                                      stable.text !=
                                                          'Add Your Stable') ||
                                                  (selectedEmirate != null &&
                                                      _secondaryStableName
                                                          .text.isNotEmpty &&
                                                      _secondaryStableLocation
                                                          .text.isNotEmpty)
                                              ? AppColors.yellow
                                              : AppColors.formsLabel,
                                      onPressed: () {
                                        if ((stable.text.isNotEmpty &&
                                                stable.text !=
                                                    'Add Your Stable') ||
                                            (selectedEmirate != null &&
                                                _secondaryStableLocation
                                                    .text.isNotEmpty &&
                                                _secondaryStableName
                                                    .text.isNotEmpty)) {
                                          onPressAddSecondary();
                                        } else {
                                          RebiMessage.error(
                                              msg:
                                                  'Select secondary stable',
                                              context: context);
                                        }
                                      },
                                      child:  Text("Save", style: AppStyles.buttonStyle,),
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
            );
          },
        ),
      ),
    );
  }

  onPressAddSecondary() {
    cubit.addSecondaryStable(

        AddSecondaryStableModel(
          id:int.parse(stableId.text),
          name: _secondaryStableName.text,
          pinLocation: _secondaryStableLocation.text,
          emirate: selectedEmirate,
        ));
  }
  onPressAddNew() {
    cubit.addNewStable(
    AddNewStablesRequestModel(
      isVerified: false,
      name: _secondaryStableName.text,
      pinLocation: _secondaryStableLocation.text,
      emirate: selectedEmirate,
    ));
  }
}
