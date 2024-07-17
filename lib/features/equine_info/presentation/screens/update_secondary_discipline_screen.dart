import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/delete_popup.dart';
import '../../../manage_account/data/basic_account_management_route.dart';
import '../../domain/equine_info_cubit.dart';
import '../widgets/disciplines_widget.dart';

class UpdateSecondaryDisciplineScreen extends StatefulWidget {
  final String secondaryDiscipline;

  final String? disciplineId;

  const UpdateSecondaryDisciplineScreen({
    Key? key,
    required this.secondaryDiscipline,
    this.disciplineId,
  }) : super(key: key);

  @override
  State<UpdateSecondaryDisciplineScreen> createState() =>
      _UpdateSecondaryDisciplineScreenState();
}

class _UpdateSecondaryDisciplineScreenState
    extends State<UpdateSecondaryDisciplineScreen> {
  late final TextEditingController discipline;
  late final TextEditingController disciplineId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  EquineInfoCubit cubit = EquineInfoCubit();

  String? selectedDiscipline;

  @override
  void initState() {
    disciplineId = TextEditingController();
    discipline = TextEditingController(text: widget.secondaryDiscipline);
    selectedDiscipline = widget.secondaryDiscipline;
    super.initState();
  }

  @override
  void dispose() {
    discipline.dispose();
    disciplineId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Secondary Discipline",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionTitle: 'Remove',
          isThereThirdOptionDelete: true,
          onPressThirdOption: () {
            deleteDialog(
                context: context,
                deleteButton: BlocConsumer<EquineInfoCubit, EquineInfoState>(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state is DeleteSecondaryDisciplineSuccessful) {
                      Navigator.pushReplacementNamed(context, successScreen,
                          arguments: BasicAccountManagementRoute(
                              type: 'manageAccount',
                              title:
                                  "Secondary discipline deleted successfully"));
                    } else if (state is DeleteSecondaryDisciplineError) {
                      RebiMessage.error(msg: state.message!, context: context);
                    }
                  },
                  builder: (context, state) {
                    if (state is DeleteSecondaryDisciplineLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.red,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(AppColors.red),
                        ),
                      );
                    }
                    return RebiButton(
                        height: 35,
                        backgroundColor: AppColors.red,
                        onPressed: () {
                          _onPressDelete();
                        },
                        child:  const Text(
                          "I'm sure",
                          style: TextStyle(fontSize: 15),

                        ));
                  },
                ),
                title: "Are you sure you want to delete this discipline");
          },
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Update Discipline",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "in order to update your main discipline - you need to submit this form and wait for the request approval",
                                    style: AppStyles.descriptions),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Discipline",
                                    style: AppStyles.profileBlackTitles),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              DisciplinesWidget(
                                disciplineId: disciplineId,
                                discipline: discipline,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
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


  _onPressDelete() {
    cubit.deleteSecondaryDiscipline(
      int.parse(widget.disciplineId!),
    );
  }
}
