import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../stables/presentation/widgets/stables_widget.dart';
import '../../../manage_account/data/basic_account_management_route.dart';
import '../../domain/equine_info_cubit.dart';

class DeleteSecondaryStableScreen extends StatefulWidget {
  final String secondaryStable;
  final int personStableId;

  const DeleteSecondaryStableScreen(
      {Key? key, required this.secondaryStable, required this.personStableId})
      : super(key: key);

  @override
  State<DeleteSecondaryStableScreen> createState() =>
      _DeleteSecondaryStableScreenState();
}

class _DeleteSecondaryStableScreenState
    extends State<DeleteSecondaryStableScreen> {
  String? selectedSecondaryStable;
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
    Print("stable id is ${widget.personStableId}");
    AppSharedPreferences.firstTime = true;
    Print('AppSharedPreferences.getEnvType${AppSharedPreferences.getEnvType}');
    _secondaryStableName = TextEditingController();
    _secondaryStableLocation = TextEditingController();
    stableId = TextEditingController();
    stable = TextEditingController(text: widget.secondaryStable);
    selectedSecondaryStable = widget.secondaryStable;
    super.initState();
  }

  @override
  void dispose() {
    _secondaryStableLocation.dispose();
    _secondaryStableName.dispose();
    stable.dispose();
    stableId.dispose();
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
          isThereThirdOption: false,
        ),
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
                                stableId: stableId,
                                readOnly: true,
                                stableName: stable,
                                changeTrue: changeToTrueValue,
                                changeFalse: changeToFalseValue,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: BlocConsumer<EquineInfoCubit, EquineInfoState>(
                            bloc: cubit,
                            listener: (context, state) {
                              if (state is DeleteSecondaryStableSuccessful) {
                                Navigator.pushReplacementNamed(
                                    context, successScreen,
                                    arguments: BasicAccountManagementRoute(
                                        type: 'manageAccount',
                                        title: state.message));
                              } else if (state is DeleteSecondaryStableError) {
                                RebiMessage.error(
                                    msg: state.message!, context: context);
                              }
                            },
                            builder: (context, state) {
                              if (state is DeleteSecondaryStableLoading) {
                                return const LoadingCircularWidget();
                              }
                              return RebiButton(
                                backgroundColor: (stable.text.isNotEmpty &&
                                            stable.text != 'Add Your Stable') ||
                                        (selectedEmirate != null &&
                                            _secondaryStableName
                                                .text.isNotEmpty &&
                                            _secondaryStableLocation
                                                .text.isNotEmpty)
                                    ? AppColors.yellow
                                    : AppColors.formsLabel,
                                onPressed: () {
                                  if ((stable.text.isNotEmpty &&
                                          stable.text != 'Add Your Stable') ||
                                      (selectedEmirate != null &&
                                          _secondaryStableLocation
                                              .text.isNotEmpty &&
                                          _secondaryStableName
                                              .text.isNotEmpty)) {
                                    onPressRemove();
                                  }
                                },
                                child: const Text("Remove", style: AppStyles.buttonStyle,),
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

  onPressRemove() {
    cubit.deleteSecondaryStable(
      widget.personStableId,
    );
  }
}
