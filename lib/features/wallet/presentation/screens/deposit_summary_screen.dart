import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/features/wallet/presentation/screens/failed_payment_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../domain/wallet_cubit.dart';

class DepositSummaryScreen extends StatefulWidget {
  final String totalAmount;
  final String serviceFee;
  final String amount;
  final bool invoiceTopUp;

  const DepositSummaryScreen(
      {Key? key,
      required this.totalAmount,
      required this.serviceFee,
      this.invoiceTopUp = false,
      required this.amount})
      : super(key: key);

  @override
  State<DepositSummaryScreen> createState() => _DepositSummaryScreenState();
}

class _DepositSummaryScreenState extends State<DepositSummaryScreen> {
  WalletCubit cubit = WalletCubit();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.h),
        child: CustomHeader(
          title: "Deposit Summary".tra,
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: kPadding, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount :".tra,
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.18,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.amount,
                          style: const TextStyle(
                            color: Color(0xFFC48636),
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.18,
                          ),
                        ),
                      ],
                    ),
                    const CustomDivider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Service Fee :".tra,
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.18,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          widget.serviceFee,
                          style: const TextStyle(
                            color: Color(0xFFC48636),
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.18,
                          ),
                        ),
                      ],
                    ),
                    const CustomDivider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Deposit Amount".tra,
                          style: const TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.18,
                          ),
                        ),
                        Text(
                          widget.totalAmount,
                          style: const TextStyle(
                            color: Color(0xFFC48636),
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              BlocConsumer<WalletCubit, WalletState>(
                bloc: cubit,
                listener: (context, state) {
                  if (state is StripePaymentError) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FailedPaymentScreen(
                                paymentTime: DateTime.now().toString(),
                                paymentAmount: widget.totalAmount)));
                  } else if (state is StripePaymentSuccessfully) {}
                },
                builder: (context, state) {
                  if (state is StripePaymentLoading) {
                    return const LoadingCircularWidget();
                  }
                  return RebiButton(
                    onPressed: () {
                      onPressCharge(
                          double.parse(widget.amount).toInt(), context);
                    },
                    child: Text(
                      "Top up".tra,
                      style: const TextStyle(
                        fontFamily: "din",
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  onPressCharge(int amount, BuildContext context) async {
    await cubit.makePayment(amount, context, '${10}',
        '${double.parse(widget.amount).toInt()}', widget.amount,widget.invoiceTopUp);
  }
}
