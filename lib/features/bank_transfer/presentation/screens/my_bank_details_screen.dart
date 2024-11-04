import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../../core/widgets/shimmer.dart';
import '../../domain/bank_transfer_cubit.dart';
import 'edit_bank_details_screen.dart';

class MyBankDetailsScreen extends StatefulWidget {
  const MyBankDetailsScreen({super.key});

  @override
  State<MyBankDetailsScreen> createState() => _MyBankDetailsScreenState();
}

class _MyBankDetailsScreenState extends State<MyBankDetailsScreen> {
  BankTransferCubit cubit = BankTransferCubit();

  @override
  void initState() {
    BlocProvider.of<BankTransferCubit>(context).getBankAccount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myCubit= context.watch<BankTransferCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.h),
        child: CustomHeader(
          title: "Bank Details",
          isThereBackButton: true,
          isThereChangeWithNavigate: true,
          onPressBack: (){
            Navigator.pop(context);
            myCubit.getAllBankTransfers(limit: 1000);
          },
        ),
      ),
      body: BlocBuilder<BankTransferCubit, BankTransferState>(
        bloc: context.read<BankTransferCubit>(),
        builder: (context, state) {
          if (state is GetBankAccountSuccessfully) {

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.borderColor,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kPadding, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Bank Account Name",
                                    style: TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'notosan'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.model!.bankName!,
                                    style: const TextStyle(
                                        color: Color(0xFF232F39),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Swift Code",
                                    style: TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'notosan'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.model!.swiftCode!,
                                    style: const TextStyle(
                                        color: Color(0xFF232F39),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Account Holder Name",
                                    style: TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'notosan'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.model!.accountHolderName!,
                                    style: const TextStyle(
                                        color: Color(0xFF232F39),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "IBAN",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Color(0xFF6B7280),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'notosan'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    state.model!.iBAN!,
                                    style: const TextStyle(
                                        color: Color(0xFF232F39),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 40),
                  child: RebiButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const EditBankDetailsScreen()));
                      },
                      child: const Text("Edit")),
                )
              ],
            );
          } else if (state is GetBankAccountError) {
            return CustomErrorWidget(onRetry: () {
              cubit.getBankAccount();
            });
          } else if (state is GetBankAccountLoading) {
            return const Shimmer(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kPadding),
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
    );
  }
}
