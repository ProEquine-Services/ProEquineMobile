import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/rebi_message.dart';
import 'package:proequine_dev/core/utils/secure_storage/secure_storage_helper.dart';
import 'package:proequine_dev/core/widgets/loading_widget.dart';
import 'package:proequine_dev/core/widgets/rebi_button.dart';
import 'package:proequine_dev/features/uncompleted_customers/domain/exist_customer_cubit.dart';
import 'package:proequine_dev/features/uncompleted_customers/presentation/screens/exist_customer_login_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/custom_header.dart';

class ExistCustomerErrorScreen extends StatefulWidget {
  final String? phoneNumber;
  final bool isPhoneGenerated;
  final bool isEmailGenerated;
  final String? email;
  final String? userId;

  const ExistCustomerErrorScreen(
      {super.key,
      this.phoneNumber,
      this.email,
      this.userId,
      required this.isPhoneGenerated,
      required this.isEmailGenerated});

  @override
  State<ExistCustomerErrorScreen> createState() =>
      _ExistCustomerErrorScreenState();
}

class _ExistCustomerErrorScreenState extends State<ExistCustomerErrorScreen> {
  ExistCustomerCubit cubit = ExistCustomerCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
            title: "",
            isThereBackButton: true,
            isThereChangeWithNavigate: false,
            isThereThirdOption: false),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "Your Account is All Set! We’re excited to welcome you to ProEquine.",
                        style: AppStyles.mainTitle2),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        "To complete the setup, we just need a quick confirmation from you to ensure it’s really you.",
                        style: AppStyles.descriptions),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("The account credential will be sent to ",
                            style: AppStyles.descriptions),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      widget.isPhoneGenerated != true
                          ? Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Phone Number",
                                      style: AppStyles.descriptions),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      widget.phoneNumber!
                                          .replaceRange(4, 9, '*****'),
                                      style: AppStyles.descriptions),
                                )
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.isEmailGenerated != true
                          ? Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Email",
                                      style: AppStyles.descriptions),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(maskEmail(widget.email!),
                                      style: AppStyles.descriptions),
                                ),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: BlocConsumer<ExistCustomerCubit, ExistCustomerState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is SendCredentialsSuccessfully) {
                    RebiMessage.success(msg: state.message!, context: context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExistCustomerLoginScreen(
                              isEmailGenerated: widget.isEmailGenerated,
                                isPhoneGenerated: widget.isPhoneGenerated,
                                phoneNumber: widget.phoneNumber!)));
                  } else if (state is SendCredentialsError) {
                    RebiMessage.error(msg: state.message!, context: context);
                  }
                },
                builder: (context, state) {
                  if (state is SendCredentialsLoading) {
                    return const LoadingCircularWidget();
                  }
                  return RebiButton(
                    onPressed: () async {
                      final String? userId = await SecureStorage().getUserId();
                      cubit.sendCredentials(int.parse(userId!));
                    },
                    child: const Text("Send Credentials"),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
