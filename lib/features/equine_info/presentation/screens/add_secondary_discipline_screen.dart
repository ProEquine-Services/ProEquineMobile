import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/equine_info/data/add_secondary_discipline_request_model.dart';
import 'package:proequine/features/equine_info/domain/equine_info_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/routes/routes.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../manage_account/data/basic_account_management_route.dart';
import '../widgets/disciplines_widget.dart';

class AddSecondaryDisciplineScreen extends StatefulWidget {
  const AddSecondaryDisciplineScreen({Key? key}) : super(key: key);

  @override
  State<AddSecondaryDisciplineScreen> createState() =>
      _AddSecondaryDisciplineScreenState();
}

class _AddSecondaryDisciplineScreenState
    extends State<AddSecondaryDisciplineScreen> {
  late final TextEditingController _feId;
  late final TextEditingController discipline;
  late final TextEditingController disciplineId;
  late final TextEditingController _nationalId;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedDiscipline;
  EquineInfoCubit cubit = EquineInfoCubit();

  @override
  void initState() {
    _feId = TextEditingController();
    discipline = TextEditingController();
    disciplineId = TextEditingController();
    _nationalId = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _feId.dispose();
    discipline.dispose();
    disciplineId.dispose();
    _nationalId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
            title: "Secondary discipline",
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
                                child: Text("Discipline",
                                    style: AppStyles.profileBlackTitles),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              DisciplinesWidget(
                                discipline: discipline,
                                disciplineId: disciplineId,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: BlocConsumer<EquineInfoCubit, EquineInfoState>(
                            bloc: cubit,
                            listener: (context, state) {
                              if (state is AddSecondaryDisciplineSuccessful) {
                                Navigator.pushReplacementNamed(
                                    context, successScreen,
                                    arguments: BasicAccountManagementRoute(
                                        type: 'manageAccount',
                                        title:
                                            "Secondary Discipline Added Successfully"));
                              } else if (state is AddSecondaryDisciplineError) {
                                RebiMessage.error(
                                    msg: state.message!, context: context);
                              }
                            },
                            builder: (context, state) {
                              if (state is AddSecondaryDisciplineLoading) {
                                return const LoadingCircularWidget();
                              }
                              return RebiButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _onPressAdd();
                                  }
                                },
                                child: Text(
                                  "Submit",
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
            );
          },
        ),
      ),
    );
  }

  _onPressAdd() {
    cubit.addSecondaryDiscipline(AddSecondaryDisciplineRequestModel(
      disciplineId: int.parse(disciplineId.text),
    ));
  }
}
