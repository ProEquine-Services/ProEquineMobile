import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/stables/data/chose_stable_request_model.dart';
import 'package:proequine/features/stables/domain/stable_cubit.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../widgets/stables_widget.dart';
import '../../../nav_bar/domain/navbar_cubit.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../../user/domain/user_cubit.dart';
import '../../../user/presentation/widgets/register_header.dart';

class ChoseStableScreen extends StatefulWidget {
  const ChoseStableScreen({Key? key}) : super(key: key);

  @override
  State<ChoseStableScreen> createState() => _ChoseStableScreenState();
}

class _ChoseStableScreenState extends State<ChoseStableScreen> {
  final StableCubit cubit = StableCubit();

  String? selectedEmirate;
  late final TextEditingController _mainStableName;
  late final TextEditingController stable;
  late final TextEditingController stableId;
  late final TextEditingController _mainStableLocation;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isChooseToAddStable = false;

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
    Print("stables two ${context.read<UserCubit>().stablesNames}");
    // Print("stables  ${context.read<UserCubit>().stablesNames}");
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');
    _mainStableLocation = TextEditingController();
    stable = TextEditingController();
    stableId = TextEditingController();
    _mainStableName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _mainStableLocation.dispose();
    _mainStableName.dispose();
    stable.dispose();
    stableId.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BlocProvider.of<NavbarCubit>(context).onWillPop(context),
      child: Scaffold(
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraint) {
              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: StatefulBuilder(builder: (context, setState) {
                      return IntrinsicHeight(
                        child: Column(
                          children: [
                            RegistrationHeader(isThereBackButton: false),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding),
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
                                        "This feature is available in UAE only , once its added we will update your profile ",
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
                                  Builder(builder: (context) {
                                    if (isChooseToAddStable) {
                                      return Column(
                                        children: [
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
                                                  style:
                                                      AppStyles.descriptions),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Visibility(
                                            visible: isChooseToAddStable,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7),
                                              child: RebiInput(
                                                hintText: 'Stable Name'.tra,
                                                controller: _mainStableName,
                                                scrollPadding:
                                                    const EdgeInsets.only(
                                                        bottom: 100),
                                                keyboardType:
                                                    TextInputType.name,
                                                textInputAction:
                                                    TextInputAction.done,
                                                autoValidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                isOptional: false,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                color: AppColors.formsLabel,
                                                readOnly: false,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 13),
                                                obscureText: false,
                                                validator: (value) {
                                                  return Validator
                                                      .requiredValidator(
                                                          _mainStableName.text);
                                                },
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isChooseToAddStable,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7),
                                              child: RebiInput(
                                                hintText: 'Location'.tra,
                                                controller: _mainStableLocation,
                                                scrollPadding:
                                                    const EdgeInsets.only(
                                                        bottom: 100),
                                                keyboardType: TextInputType.url,
                                                textInputAction:
                                                    TextInputAction.done,
                                                autoValidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                isOptional: false,
                                                color: AppColors.formsLabel,
                                                onChanged: (value) {
                                                  setState(() {});
                                                },
                                                readOnly: false,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 13),
                                                obscureText: false,
                                                validator: (value) {
                                                  return Validator
                                                      .requiredValidator(
                                                          _mainStableLocation
                                                              .text);
                                                },
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: isChooseToAddStable,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 7),
                                              child: DropDownWidget(
                                                items: emirate,
                                                selected: selectedEmirate,
                                                onChanged: (selectedEmi) {
                                                  setState(() {
                                                    selectedEmirate =
                                                        selectedEmi;
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
                                      );
                                    }
                                    return Container();
                                  }),
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
                      );
                    }),
                  ),
                ),
              );
            },
          ),
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
                        stable.text != 'Add your stable') ||
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BottomNavigation()));
          } else if (state is ChoseStableError) {
            RebiMessage.error(msg: state.message!, context: context);
          }
        });
  }

  _onPressConfirm() {
    return cubit
      ..choseStable(ChoseMainStableRequestModel(
        id: isChooseToAddStable ? -1 : int.parse(stableId.text),
        isUpdated: false,
        name: isChooseToAddStable ? _mainStableName.text : stable.text,
        // stableName: isChooseToAddStable?_mainStableName.text:stable.text,
        // isNewStable: isChooseToAddStable,
        emirate: selectedEmirate,
        pinLocation: _mainStableLocation.text,
        // personId: int.parse(AppSharedPreferences.personId)
      ));
  }
}
