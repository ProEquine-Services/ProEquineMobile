import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/features/invoices/domain/invoices_cubit.dart';
import 'package:proequine/features/wallet/domain/wallet_cubit.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../widgets/payment_card.dart';
import 'main_wallet_screen.dart';

class SuccessPaymentScreen extends StatefulWidget {
  final String refNumber;
  final String paymentTime;
  final String paymentAmount;
  final bool invoiceTopUp;

  const SuccessPaymentScreen(
      {Key? key,
      required this.refNumber,
      required this.paymentTime,
      this.invoiceTopUp = false,
      required this.paymentAmount})
      : super(key: key);

  @override
  State<SuccessPaymentScreen> createState() => _SuccessPaymentScreenState();
}

class _SuccessPaymentScreenState extends State<SuccessPaymentScreen> {
  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    String formattedDateTime = DateFormat('d MMM - h:mm a').format(dateTime);

    return formattedDateTime;
  }

  WalletCubit cubit = WalletCubit();

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<InvoicesCubit>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kPadding),
          child: BlocBuilder<WalletCubit, WalletState>(
            bloc: cubit..getPaymentDetails(),
            builder: (context, state) {
              if (state is PaymentDetailsSuccessfully) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    PaymentCard(
                      content: Column(
                        children: [
                          Center(
                              child: SvgPicture.asset(AppIcons.successPayment)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Deposit Success!'.tra,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF474747),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Time'.tra,
                                    style: const TextStyle(
                                      color: Color(0xFF707070),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    formatDateTime(state.model!.time!),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: AppColors.blackLight,
                                    ),
                                  ),
                                ],
                              )),

                          const SizedBox(
                            height: 8,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: kPadding),
                            child: CustomDivider(),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Amount'.tra,
                                    style: const TextStyle(
                                      color: Color(0xFF707070),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.model!.amount!.toString(),
                                    style: const TextStyle(
                                      color: AppColors.gold,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: kPadding),
                            child: CustomDivider(),
                          ),
                          // const DashesLineWidget(color: AppColors.lightGrey),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Fees'.tra,
                                    style: const TextStyle(
                                      color: Color(0xFF707070),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.model!.fees!.toString(),
                                    style: const TextStyle(
                                      color: AppColors.gold,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: kPadding),
                            child: CustomDivider(),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Deposit Amount',
                                    style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.model!.depositAmount!.toString(),
                                    style: const TextStyle(
                                      color: AppColors.gold,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )),

                          const SizedBox(
                            height: 5,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: kPadding),
                            child: CustomDivider(),
                          ),
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kPadding),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'New Wallet Amount',
                                    style: TextStyle(
                                      color: Color(0xFF707070),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    state.model!.newWalletAmount!.toString(),
                                    style: const TextStyle(
                                      color: AppColors.gold,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: !widget.invoiceTopUp,
                      child: RebiButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MainWalletScreen()));
                          },
                          child: Text("Wallet".tra)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    widget.invoiceTopUp
                        ? RebiButton(
                            onPressed: () {
                              Navigator.pop(context);
                              myCubit.getAllInvoices(limit: 1000);
                            },
                            child: Text(
                              "Unpaid Invoices".tra,
                              style: AppStyles.buttonTitle,
                            ))
                        : RebiButton(
                            isBackButton: true,
                            backgroundColor: AppColors.backgroundColorLight,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const BottomNavigation(
                                            selectedIndex: 0,
                                          )));
                            },
                            child: Text(
                              "Home".tra,
                              style: const TextStyle(color: AppColors.gold),
                            )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
