import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/utils/rebi_message.dart';
import 'package:proequine_dev/core/widgets/loading_widget.dart';
import 'package:proequine_dev/features/support/presentation/widgets/support_custom_dialog.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/global_functions/global_statics_drop_down.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';

import '../../data/support_request_model.dart';
import '../../domain/support_cubit.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final TextEditingController referenceNumber = TextEditingController();

  final TextEditingController descriptionIssue = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SupportCubit cubit = SupportCubit();

  String? selectedSubject;

  String? selectedDivision;

  @override
  Widget build(BuildContext context) {
    var myCubit=context.watch<SupportCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
            title: "Contact Support",
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("How we can help you",
                                    style: AppStyles.mainTitle),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: DropDownWidget(
                                  items: supportSubject,
                                  selected: selectedSubject,
                                  onChanged: (subject) {
                                    setState(() {
                                      selectedSubject = subject;

                                      Print('selectedSubject $selectedSubject');
                                    });
                                  },
                                  validator: (value) {
                                    // return Validator.requiredValidator(selectedNumber);
                                  },
                                  hint: 'Subject',
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                child: DropDownWidget(
                                  items: supportDivision,
                                  selected: selectedDivision,
                                  onChanged: (division) {
                                    setState(() {
                                      selectedDivision = division;

                                      Print(
                                          'selectedDivision $selectedDivision');
                                    });
                                  },
                                  validator: (value) {
                                    // return Validator.requiredValidator(selectedNumber);
                                  },
                                  hint: 'Division',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: kPadding),
                          child: RebiInput(
                            hintText: 'Reference number if applicable'.tra,
                            controller: referenceNumber,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            isOptional: true,
                            readOnly: false,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            obscureText: false,
                            validator: (value) {

                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: kPadding),
                          child: RebiInput(
                            hintText: 'Your Inquiry'.tra,
                            controller: descriptionIssue,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            textInputAction: TextInputAction.done,
                            autoValidateMode:
                                AutovalidateMode.onUserInteraction,
                            isOptional: false,
                            readOnly: false,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            obscureText: false,
                            validator: (value) {
                              return Validator.requiredValidator(
                                  descriptionIssue.text);
                            },
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: BlocConsumer<SupportCubit, SupportState>(
                            bloc: cubit,
                            listener: (context, state) {
                              if (state is ContactSupportSuccessful) {
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const ThanksWidget()));
                                showThanksSupportDialog(
                                  reference: state.model!.reference!,
                                    context: context, onPressHome: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      myCubit.getAllRequests(limit: 1000);
                                });
                              } else if (state is ContactSupportError) {
                                RebiMessage.error(
                                    msg: state.message!, context: context);
                              }
                            },
                            builder: (context, state) {
                              if (state is ContactSupportLoading) {
                                return const LoadingCircularWidget();
                              }
                              return RebiButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() &&
                                        selectedDivision != null &&
                                        selectedSubject != null) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      onPressSend();
                                    } else if (selectedSubject == null) {
                                      RebiMessage.error(
                                          msg: "Select subject",
                                          context: context);
                                    } else if (selectedDivision == null) {
                                      RebiMessage.error(
                                          msg: "Select division",
                                          context: context);
                                    }
                                  },
                                  child: Text(
                                    "Send",
                                    style: AppStyles.buttonStyle,
                                  ));
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

  onPressSend() {
    return cubit.contactSupport(
      CreateSupportRequestModel(
        applicableReference: referenceNumber.text,
        subject: selectedSubject,
        division: selectedDivision,
        supportInquiry: descriptionIssue.text,
        sourceIsApp: true,
      ),
    );
  }
}
