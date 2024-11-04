import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../data/save_bank_account_request_model.dart';
import '../../domain/bank_transfer_cubit.dart';

class EditBankDetailsScreen extends StatefulWidget {
  const EditBankDetailsScreen({super.key});

  @override
  State<EditBankDetailsScreen> createState() => _EditBankDetailsScreenState();
}

class _EditBankDetailsScreenState extends State<EditBankDetailsScreen> {
  BankTransferCubit cubit = BankTransferCubit();
  TextEditingController bankName = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController iban = TextEditingController();
  TextEditingController swiftCode = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    cubit.getBankAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<BankTransferCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Edit Bank Details",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPadding, vertical: 10),
              child: RebiInput(
                hintText: 'Bank Name',
                controller: bankName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                scrollPadding: const EdgeInsets.only(bottom: 100),
                isOptional: false,
                color: AppColors.formsLabel,
                readOnly: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                obscureText: false,
                validator: (value) {
                  return Validator.requiredValidator(bankName.text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPadding, vertical: 10),
              child: RebiInput(
                hintText: 'Swift Code',
                controller: swiftCode,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                scrollPadding: const EdgeInsets.only(bottom: 100),
                isOptional: false,
                color: AppColors.formsLabel,
                readOnly: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'SWIFT code is required';
                  }
                  if (value.length != 8 && value.length != 11) {
                    return 'SWIFT code must be either 8 or 11 characters long';
                  }
                  if (!RegExp(r'^[A-Z0-9]{8}(?:[A-Z0-9]{3})?$').hasMatch(value)) {
                    return 'SWIFT code must contain only letters and digits';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPadding, vertical: 10),
              child: RebiInput(
                hintText: 'Account Holder Name',
                controller: accountHolderName,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                scrollPadding: const EdgeInsets.only(bottom: 100),
                isOptional: false,
                color: AppColors.formsLabel,
                readOnly: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                obscureText: false,
                validator: (value) {
                  return Validator.requiredValidator(accountHolderName.text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: kPadding, vertical: 10),
              child: RebiInput(
                hintText: 'Iban',
                controller: iban,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                scrollPadding: const EdgeInsets.only(bottom: 100),
                isOptional: false,
                color: AppColors.formsLabel,
                readOnly: false,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                obscureText: false,
                validator: (value) {
                  // Check if the input is empty
                  if (value == null || value.isEmpty) {
                    return 'IBAN is required';
                  }

                  // Check if the input length is between 22 and 34 characters
                  if (value.length < 22 || value.length > 34) {
                    return 'IBAN must be between 22 and 34 characters';
                  }

                  // Ensure that the input contains only letters and digits
                  if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                    return 'IBAN must contain only letters and digits';
                  }else {
                    return null;
                  }
                },
              ),
            ),
            const Spacer(),
            BlocConsumer<BankTransferCubit, BankTransferState>(
              bloc: cubit,
              listener: (context, state) {
                if (state is SaveBankAccountError) {
                  RebiMessage.error(msg: state.message!, context: context);
                } else if (state is SaveBankAccountSuccessful) {
                  RebiMessage.success(msg: state.message!, context: context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => BankTransfersScreen()));
                  myCubit.getBankAccount();

                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is SaveBankAccountLoading) {
                  return const LoadingCircularWidget();
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 20),
                  child: RebiButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          {
                            _onPressSaveBank();
                          }
                        } else {}
                      },
                      child: const Text("Save")),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _onPressSaveBank() async {
    String? userId = await SecureStorage().getUserId();
    cubit.saveBankAccount(SaveBankAccountRequestModel(
        userId: int.parse(userId!),
        bankName: bankName.text,
        accountHolderName: accountHolderName.text,
        swiftCode: swiftCode.text,
        iBAN: iban.text));
  }
}
