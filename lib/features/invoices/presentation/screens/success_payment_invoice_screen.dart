import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:proequine_dev/core/utils/extensions.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/constants/thems/app_styles.dart';
import '../../../../core/widgets/divider.dart';
import '../../../../core/widgets/rebi_button.dart';
import '../../../nav_bar/presentation/screens/bottomnavigation.dart';
import '../../../wallet/domain/wallet_cubit.dart';
import '../../../wallet/presentation/widgets/payment_card.dart';
import '../../domain/invoices_cubit.dart';

class SuccessWalletPaymentInvoiceScreen extends StatefulWidget {
  final String paymentTime;
  final String paymentAmount;
  final String invoiceNumber;

  const SuccessWalletPaymentInvoiceScreen(
      {Key? key,
      required this.paymentTime,
      required this.paymentAmount,
      required this.invoiceNumber})
      : super(key: key);

  @override
  State<SuccessWalletPaymentInvoiceScreen> createState() =>
      _SuccessWalletPaymentInvoiceScreen();
}

class _SuccessWalletPaymentInvoiceScreen
    extends State<SuccessWalletPaymentInvoiceScreen> {
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
          child: Column(
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
                        child:
                            SvgPicture.asset(AppIcons.invoiceSuccessPayment)),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Invoice Payment'.tra,
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
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Invoice Number'.tra,
                              style: const TextStyle(
                                color: Color(0xFF707070),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.invoiceNumber,
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
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Invoice Date'.tra,
                              style: const TextStyle(
                                color: Color(0xFF707070),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.paymentTime,
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
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              widget.paymentAmount,
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
                        padding:
                            const EdgeInsets.symmetric(horizontal: kPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Paid Amount'.tra,
                              style: const TextStyle(
                                color: Color(0xFF707070),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.paymentAmount,
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
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: kPadding),
                        child: Center(
                          child: Text(
                            'Detailed invoice will be sent to the registered email address',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )),

                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              RebiButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             const UserInvoicesScreen()));
                    myCubit.getAllInvoices(limit: 1000);
                  },
                  child: Text(
                    "Unpaid Invoices".tra,
                    style: AppStyles.buttonTitle,
                  )),
              const SizedBox(
                height: 15,
              ),
              RebiButton(
                  isBackButton: true,
                  backgroundColor: AppColors.backgroundColorLight,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavigation(
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
          ),
        ),
      ),
    );
  }
}
