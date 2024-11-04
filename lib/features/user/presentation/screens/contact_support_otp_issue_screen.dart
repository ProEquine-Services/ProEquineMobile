import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/core/utils/rebi_message.dart';
import 'package:proequine_dev/core/widgets/loading_widget.dart';
import 'package:proequine_dev/features/nav_bar/presentation/screens/bottomnavigation.dart';
import 'package:proequine_dev/features/user/presentation/screens/create_user_name_screen.dart';

import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../support/data/support_request_model.dart';
import '../../../support/domain/support_cubit.dart';

class ContactSupportOtpIssueScreen extends StatefulWidget {
  final String subject;
  final String division;

  const ContactSupportOtpIssueScreen(
      {super.key, required this.subject, required this.division});

  @override
  State<ContactSupportOtpIssueScreen> createState() =>
      _ContactSupportOtpIssueScreenState();
}

class _ContactSupportOtpIssueScreenState
    extends State<ContactSupportOtpIssueScreen> {
  final TextEditingController descriptionIssue = TextEditingController();
  late TextEditingController selectedSubject;

  late TextEditingController selectedDivision;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  SupportCubit cubit = SupportCubit();

  @override
  void initState() {
    selectedSubject = TextEditingController(text: widget.subject);
    selectedDivision = TextEditingController(text: widget.division);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                                child: Text("OTP Code Not Received?",
                                    style: AppStyles.mainTitle),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                "Our team will contact you soon to verify your account and resolve the issue.",
                                style: AppStyles.descriptions,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 7, horizontal: kPadding),
                          child: RebiInput(
                            hintText: 'Additional note (optional)'.tra,
                            controller: descriptionIssue,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            textInputAction: TextInputAction.done,
                            autoValidateMode:
                            AutovalidateMode.onUserInteraction,
                            isOptional: true,
                            readOnly: false,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            obscureText: false,
                            validator: (value) {},
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: BlocConsumer<SupportCubit, SupportState>(
                            bloc: cubit,
                            listener: (context, state) {
                              if (state is ContactSupportSuccessful) {
                                if (widget.division == 'OTP Email Issue') {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) =>
                                          const BottomNavigation(
                                            selectedSection: 0,)));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                          const CreateUserNameScreen()));
                                }
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
                                    onPressSend();
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
        subject: selectedSubject.text,
        division: selectedDivision.text,
        supportInquiry: descriptionIssue.text,
        sourceIsApp: true,
      ),
    );
  }
}
