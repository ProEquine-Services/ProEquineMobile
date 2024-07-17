import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/widgets/custom_error_widget.dart';
import 'package:proequine/core/widgets/loading_widget.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_header.dart';
import '../widgets/privacy_bottom_sheet.dart';
import '../../../../core/widgets/terms_bottom_sheet.dart';
import '../../../../core/widgets/profile_list_tile_widget.dart';

class LegalScreen extends StatefulWidget {
  const LegalScreen({super.key});

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  ManageAccountCubit cubit = ManageAccountCubit();

  @override
  void initState() {
    super.initState();

    cubit.getConfiguration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Legal",
          isThereBackButton: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: BlocBuilder<ManageAccountCubit, ManageAccountState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is GetConfigurationSuccessfully) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    ProfileListTileWidget(
                      title: "Terms & Conditions",
                      onTap: () {
                        showTermsBottomSheet(
                            context: context,
                            content: state.responseModel!.terms!);
                      },
                      notificationList: false,
                      isThereNewNotification: false,
                    ),
                    ProfileListTileWidget(
                      title: "Privacy Policy",
                      onTap: () {
                        showPrivacyBottomSheet(
                            context: context,
                            content: state.responseModel!.privacyPolicyText!);
                      },
                      notificationList: false,
                      isThereNewNotification: false,
                    ),
                  ],
                );
              } else if (state is GetConfigurationError) {
                return CustomErrorWidget(onRetry: () {
                  cubit.getConfiguration();
                });
              } else if (state is GetConfigurationLoading) {
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: LoadingCircularWidget(),
                    )
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
