import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/rebi_message.dart';
import '../../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../../core/utils/validator.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/rebi_input.dart';
import '../../../../core/widgets/shimmer.dart';
import '../../../horses/data/user_and_associated_horses_response_model.dart';
import '../../../support/presentation/widgets/support_loading_shimmer.dart';
import '../../data/save_bank_account_request_model.dart';
import '../../domain/bank_transfer_cubit.dart';
import '../widgets/bank_transfer_widget.dart';
import 'bank_deposit_screen.dart';
import 'edit_transfer_summary_screen.dart';

class BankTransfersScreen extends StatefulWidget {
  const BankTransfersScreen({super.key});

  @override
  State<BankTransfersScreen> createState() => _BankTransfersScreenState();
}

class _BankTransfersScreenState extends State<BankTransfersScreen> {
  TextEditingController bankName = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController iban = TextEditingController();
  TextEditingController swiftCode = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<BankTransferCubit>().getAllBankTransfers(limit: 1000);
    super.initState();
  }

  BankTransferCubit cubit = BankTransferCubit();
  Account account = Account();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Bank Transfer",
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionIcon: const Icon(
            Icons.more_vert,
            color: AppColors.yellow,
          ),
          onPressThirdOption: () {
            showGlobalBottomSheet(
                context: context,
                title: "Bank Details",
                thirdOption: InkWell(
                  onTap: () {
                    showGlobalBottomSheet(
                        height: 80.0.h,
                        context: context,
                        title: "Edit",
                        thirdOption: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                                color: AppColors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'notosan'),
                          ),
                        ),
                        content: SizedBox(
                          height: 80.0.h,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                BlocBuilder<BankTransferCubit,
                                    BankTransferState>(
                                  bloc: cubit,
                                  builder: (context, state) {
                                    if (state is GetBankAccountSuccessfully) {
                                      bankName.text = state.model!.bankName!;
                                      swiftCode.text = state.model!.swiftCode!;
                                      accountHolderName.text =
                                          state.model!.accountHolderName!;
                                      iban.text = state.model!.iBAN!;
                                      return Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: RebiInput(
                                              hintText: 'Bank Name',
                                              controller: bankName,
                                              keyboardType: TextInputType.name,
                                              textInputAction:
                                                  TextInputAction.done,
                                              autoValidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              scrollPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 100),
                                              isOptional: false,
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
                                                        bankName.text);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: RebiInput(
                                              hintText: 'Swift Code',
                                              controller: swiftCode,
                                              keyboardType: TextInputType.name,
                                              textInputAction:
                                                  TextInputAction.done,
                                              autoValidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              scrollPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 100),
                                              isOptional: false,
                                              color: AppColors.formsLabel,
                                              readOnly: false,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 13),
                                              obscureText: false,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'SWIFT code is required';
                                                }
                                                if (value.length != 8 &&
                                                    value.length != 11) {
                                                  return 'SWIFT code must be either 8 or 11 characters long';
                                                }
                                                if (!RegExp(
                                                        r'^[A-Z0-9]{8}(?:[A-Z0-9]{3})?$')
                                                    .hasMatch(value)) {
                                                  return 'SWIFT code must contain only letters and digits';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: RebiInput(
                                              hintText: 'Account Holder Name',
                                              controller: accountHolderName,
                                              keyboardType: TextInputType.name,
                                              textInputAction:
                                                  TextInputAction.done,
                                              autoValidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              scrollPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 100),
                                              isOptional: false,
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
                                                        accountHolderName.text);
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: RebiInput(
                                              hintText: 'Iban',
                                              controller: iban,
                                              keyboardType: TextInputType.name,
                                              textInputAction:
                                                  TextInputAction.done,
                                              autoValidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              scrollPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 100),
                                              isOptional: false,
                                              color: AppColors.formsLabel,
                                              readOnly: false,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20,
                                                      vertical: 13),
                                              obscureText: false,
                                              validator: (value) {
                                                // Check if the input is empty
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'IBAN is required';
                                                }

                                                // Check if the input length is between 22 and 34 characters
                                                if (value.length < 22 ||
                                                    value.length > 34) {
                                                  return 'IBAN must be between 22 and 34 characters';
                                                }

                                                // Ensure that the input contains only letters and digits
                                                if (!RegExp(r'^[a-zA-Z0-9]+$')
                                                    .hasMatch(value)) {
                                                  return 'IBAN must contain only letters and digits';
                                                }

                                                return null;
                                              },
                                            ),
                                          ),
                                          // const Spacer(),
                                        ],
                                      );
                                    } else if (state is GetBankAccountError) {
                                      return CustomErrorWidget(onRetry: () {
                                        cubit.getBankAccount();
                                      });
                                    } else if (state is GetBankAccountLoading) {
                                      return const Shimmer(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: kPadding),
                                          child: ShimmerLoading(
                                            isLoading: true,
                                            child: SizedBox(
                                              height: 250,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  },
                                ),
                                BlocConsumer<BankTransferCubit,
                                    BankTransferState>(
                                  bloc: cubit,
                                  listener: (context, state) {
                                    if (state is SaveBankAccountError) {
                                      RebiMessage.error(
                                          msg: state.message!,
                                          context: context);
                                    } else if (state
                                        is SaveBankAccountSuccessful) {
                                      RebiMessage.success(
                                          msg: state.message!,
                                          context: context);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is SaveBankAccountLoading) {
                                      return const LoadingCircularWidget();
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: RebiButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              {
                                                _onPressSaveBank();
                                              }
                                            } else {}
                                          },
                                          child: const Text("Save")),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ));
                  },
                  child: const Text(
                    "Edit",
                    style: TextStyle(
                        color: AppColors.yellow,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'notosan'),
                  ),
                ),
                content: SizedBox(
                  height: 70.0.h,
                  child: Column(
                    children: [
                      BlocBuilder<BankTransferCubit, BankTransferState>(
                        bloc: cubit..getBankAccount(),
                        builder: (context, state) {
                          if (state is GetBankAccountSuccessfully) {
                            return Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    // height:200,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      border: Border.all(
                                        color: AppColors.borderColor,
                                      ),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: kPadding, vertical: 20),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Bank Name",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF6B7280),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'notosan'),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    state.model!.bankName!,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF232F39),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'notosan'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: CustomDivider()),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Swift Code",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF6B7280),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'notosan'),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    state.model!.swiftCode!,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF232F39),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'notosan'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: CustomDivider()),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "Account Holder Name",
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF6B7280),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'notosan'),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    state.model!
                                                        .accountHolderName!,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF232F39),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'notosan'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Padding(
                                              padding: EdgeInsets.all(2.0),
                                              child: CustomDivider()),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    "IBAN",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF6B7280),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'notosan'),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    state.model!.iBAN!,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF232F39),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: 'notosan'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // const Spacer(),
                                // Padding(
                                //   padding: const EdgeInsets.symmetric(
                                //       horizontal: kPadding, vertical: 40),
                                //   child: RebiButton(
                                //       onPressed: () {
                                //         Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //                 builder: (context) =>
                                //                 const EditBankDetailsScreen()));
                                //       },
                                //       child: const Text("Edit")),
                                // )
                              ],
                            );
                          } else if (state is GetBankAccountError) {
                            return CustomErrorWidget(onRetry: () {
                              cubit.getBankAccount();
                            });
                          } else if (state is GetBankAccountLoading) {
                            return const Shimmer(
                              child: Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: kPadding),
                                child: ShimmerLoading(
                                  isLoading: true,
                                  child: SizedBox(
                                    height: 250,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      )
                    ],
                  ),
                ));
          },
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: BlocBuilder<BankTransferCubit, BankTransferState>(
              bloc: context.read<BankTransferCubit>(),
              builder: (context, state) {
                if (state is GetAllBankTransfersSuccessful) {
                  String formatDate(DateTime date) {
                    // Define the date format
                    final dateFormat = DateFormat("MMMM d, yyyy - hh:mm a");
                    // Format the date
                    final formattedDate = dateFormat.format(date);
                    return formattedDate;
                  }

                  if (state.count == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 200,
                          ),
                          Center(
                              child: SvgPicture.asset(AppIcons.emptyTransfers)),
                          const SizedBox(
                            height: 100,
                          ),
                          const Text(
                            'It seems you havent initiated any transfers yet',
                            style: TextStyle(
                              color: Color(0xFF232F39),
                              fontSize: 28.26,
                              fontFamily: 'Noto Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding),
                            child: RebiButton(
                                onPressed: () async {
                                  String? userId =
                                      await SecureStorage().getUserId();
                                  if (context.mounted) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BankDepositScreen(
                                                  userId: int.parse(userId!),
                                                )));
                                  }
                                },
                                child: const Text("New Transfer")),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        SingleChildScrollView(
                          child: SizedBox(
                            height: 75.0.h,
                            child: ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: state.count,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kPadding, vertical: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (state.responseModel[index].status !=
                                            'Pending') {
                                          showGlobalBottomSheet(
                                              context: context,
                                              title: "Bank transfer Details",
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: kPadding,
                                                        vertical: 10),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    border: Border.all(
                                                      color:
                                                          AppColors.borderColor,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: kPadding,
                                                        vertical: 20),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  "Reference Number",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF6B7280),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          'notosan'),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  "Include it in your transfer notes",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF6B7280),
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          'notosan'),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  state
                                                                      .responseModel[
                                                                          index]
                                                                      .referenceNumber
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0xFF232F39),
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontFamily:
                                                                          'notosan'),
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      await Clipboard.setData(ClipboardData(
                                                                          text: state
                                                                              .responseModel[index]
                                                                              .referenceNumber
                                                                              .toString()));

                                                                      // copied successfully
                                                                      RebiMessage.success(
                                                                          msg:
                                                                              "copied successfully",
                                                                          context:
                                                                              context);
                                                                    },
                                                                    child: SvgPicture.asset(
                                                                        AppIcons
                                                                            .copyIcon)),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.0),
                                                            child:
                                                                CustomDivider()),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Date & Time",
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF6B7280),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'notosan'),
                                                            ),
                                                            Text(
                                                              formatDate(DateTime
                                                                  .parse(state
                                                                      .responseModel[
                                                                          index]
                                                                      .createdAt!)),
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xFF232F39),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'notosan'),
                                                            ),
                                                          ],
                                                        ),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.0),
                                                            child:
                                                                CustomDivider()),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Status",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF6B7280),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'notosan'),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              state
                                                                  .responseModel[
                                                                      index]
                                                                  .status!,
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xFF232F39),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'notosan'),
                                                            ),
                                                          ],
                                                        ),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.0),
                                                            child:
                                                                CustomDivider()),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Transfer Type",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF6B7280),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'notosan'),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              state
                                                                  .responseModel[
                                                                      index]
                                                                  .transferType!,
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0xFF232F39),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'notosan'),
                                                            ),
                                                          ],
                                                        ),
                                                        const Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    2.0),
                                                            child:
                                                                CustomDivider()),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              "Amount",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xFF6B7280),
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'notosan'),
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              '${state.responseModel[index].amount.toString()} AED',
                                                              style: const TextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .gold,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'notosan'),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ));
                                        } else {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditTransferSummaryScreen(
                                                          responseModel: state
                                                                  .responseModel[
                                                              index])));
                                        }
                                      },
                                      child: BankTransferWidget(
                                        amount: state
                                            .responseModel[index].amount
                                            .toString(),
                                        date: formatDate(DateTime.parse(state
                                            .responseModel[index].createdAt!)),
                                        status:
                                            state.responseModel[index].status ??
                                                'Pending',
                                        type: state
                                            .responseModel[index].transferType,
                                        referenceNumber: state
                                            .responseModel[index]
                                            .referenceNumber,
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: kPadding),
                          child: RebiButton(
                              onPressed: () async {
                                String? userId =
                                    await SecureStorage().getUserId();
                                if (context.mounted) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BankDepositScreen(
                                                userId: int.parse(userId!),
                                              )));
                                }
                              },
                              child: const Text("New Transfer")),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    );
                  }
                }
                if (state is GetAllBankTransfersError) {
                  return CustomErrorWidget(onRetry: () {
                    cubit.getAllBankTransfers(limit: 100);
                  });
                } else if (state is GetAllBankTransfersLoading) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: SupportLoadingWidget()),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        );
      }),
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
