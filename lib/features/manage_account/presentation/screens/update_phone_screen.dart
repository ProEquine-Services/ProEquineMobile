import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/constants/routes/routes.dart';
import 'package:proequine/features/manage_account/domain/manage_account_cubit.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/phone_number_field_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../data/edit_phone_request_model.dart';

class UpdatePhoneScreen extends StatelessWidget {
  UpdatePhoneScreen({Key? key}) : super(key: key);

  final TextEditingController _phone = TextEditingController();
  final TextEditingController _countryCode =
      TextEditingController(text: "+971");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ManageAccountCubit cubit = ManageAccountCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0.h),
        child: CustomHeader(
          title: "Update Main Number",
          isThereBackButton: true,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Main number ", style: AppStyles.mainTitle),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPadding),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("used for verification, notifications and calls",
                    style: AppStyles.descriptions),
              ),
            ),
            const SizedBox(height: 14,),
            PhoneNumberFieldWidget(countryCode: _countryCode, phoneNumber: _phone),

            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(kPadding),
              child: BlocConsumer<ManageAccountCubit, ManageAccountState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is SendPhoneLoading) {
                    return const LoadingCircularWidget();
                  }
                  return RebiButton(
                      onPressed: () {

                        if (_formKey.currentState!.validate()) {
                          FocusManager.instance.primaryFocus?.unfocus();
                          onSendPhone();
                        } else {}
                      },
                      child:  Text("Update", style: AppStyles.buttonStyle,));
                },
                listener: (context, state) {
                  if (state is SendPhoneSuccessful) {
                    Navigator.pushReplacementNamed(context, verifyUpdatePhone,
                        arguments: _countryCode.text + _phone.text);

                  } else if (state is SendPhoneError) {
                    RebiMessage.error(msg: state.message!, context: context);
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  onSendPhone() {
    return cubit.sendPhoneNumber(
      EditPhoneRequestModel(
        phoneNumber: _countryCode.text + _phone.text,
      )

    );
  }
}
