import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';

import '../../../../core/widgets/custom_error_widget.dart';
import '../../../../core/widgets/shimmer.dart';
import '../../../bank_transfer/data/all_bank_transfers_response_model.dart';
import '../../domain/wallet_cubit.dart';

class WalletCardWidget extends StatefulWidget {
  Account bankAccountDetails;

  WalletCardWidget({
    Key? key,
    required this.bankAccountDetails,
  }) : super(key: key);

  @override
  State<WalletCardWidget> createState() => _WalletCardWidgetState();
}

class _WalletCardWidgetState extends State<WalletCardWidget> {
  @override
  void initState() {
    // context.read<WalletCubit>().getAllTransactions(limit: 10);
    super.initState();
  }

  WalletCubit cubit = WalletCubit();
  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFDFD9C9)),
        color: Colors.white,
      ),
      child: BlocConsumer<WalletCubit, WalletState>(
        bloc: cubit..getWallet(),
        listener: (context, state) {
          if (state is GetWalletSuccessfully) {

            // myCubit.isRegisteredWithZoho= state.model.user?.isRegisterdInZoho;
            widget.bankAccountDetails = Account(
              bankName: state.model.bankName,

              iBAN: state.model.iBAN,
              accountHolderName: state.model.accountHolderName,
              swiftCode: state.model.swiftCode,
              accountNumber: state.model.accountNumber,
            );

            // context.read<WalletCubit>().getAllTransactions(
            //     limit: 10,
            //     loadMore: false,
            //     isRefreshing: false);
          }
        },
        builder: (context, state) {
          if (state is GetWalletError) {
            return CustomErrorWidget(
                errorMessage: "Something wrong, Please try again!".tra,
                onRetry: () {
                  cubit.getWallet();
                });
          } else if (state is GetWalletLoading) {
            return Shimmer(
              child: ShimmerLoading(
                isLoading: true,
                child: Container(
                  height: 22.0.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.grey,
                  ),
                ),
              ),
            );
          } else if (state is GetWalletSuccessfully) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  child: Column(
                    children: [
                      Text(
                        'Total Balance'.tra,
                        style: const TextStyle(
                          color: AppColors.blackLight,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              state.model.totalAmount.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: AppColors.gold,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "AED".tra,
                            style: const TextStyle(
                                color: AppColors.gold,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // const CustomDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kPadding, vertical: 10),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 10),
                            child: Column(
                              children: [
                                Text(
                                  'Available Balance'.tra,
                                  style: const TextStyle(
                                    color: AppColors.blackLight,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          state.model.availableAmount
                                              .toString(),
                                          style: const TextStyle(
                                            color: AppColors.green,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          "AED".tra,
                                          style: const TextStyle(
                                              color: AppColors.green,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: VerticalDivider(
                            color: AppColors.greyLight,
                            indent: 1,
                            endIndent: 1,
                            thickness: 1,
                            width: 5,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 10),
                            child: Column(
                              children: [
                                Text(
                                  'Blocked Balance'.tra,
                                  style: const TextStyle(
                                    color: AppColors.blackLight,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        state.model.blockedAmount.toString(),
                                        style: const TextStyle(
                                          color: AppColors.grey,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "AED".tra,
                                        style: const TextStyle(
                                            color: AppColors.greyLight,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return Container(
            color: Colors.red,
          );
        },
      ),
    );
  }
}
