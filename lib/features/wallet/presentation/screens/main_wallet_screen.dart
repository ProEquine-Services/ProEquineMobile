import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/utils/Printer.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine/features/bank_transfer/data/all_bank_transfers_response_model.dart';
import 'package:proequine/features/bank_transfer/presentation/screens/add_bank_account_screen.dart';
import 'package:proequine/features/bank_transfer/presentation/screens/bank_transfers_screen.dart';
import 'package:proequine/features/wallet/presentation/screens/card_deposit_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../domain/wallet_cubit.dart';
import '../widgets/all_transaction_widget.dart';
import '../widgets/payout_topup_widget.dart';
import '../widgets/wallet_card_widget.dart';

class MainWalletScreen extends StatefulWidget {
  final bool invoiceTopUp;

  const MainWalletScreen({Key? key, this.invoiceTopUp = false})
      : super(key: key);

  @override
  State<MainWalletScreen> createState() => _MainWalletScreenState();
}

class _MainWalletScreenState extends State<MainWalletScreen> {
  Account account = Account();
  bool? isRegistered;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.h),
        child: CustomHeader(
          title: "Wallet".tra,
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
        ),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: WalletCardWidget(
                      bankAccountDetails: account,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CardAndBankWidget(
                              enable: context
                                      .read<WalletCubit>()
                                      .isRegisteredWithZoho ??
                                  false,
                              onTap: () {
                                Print(context
                                    .read<WalletCubit>()
                                    .isRegisteredWithZoho);
                                if (context
                                    .read<WalletCubit>()
                                    .isRegisteredWithZoho!) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CardDepositScreen(
                                                  invoiceTopUp:
                                                      widget.invoiceTopUp,
                                                  type: 'Card')));
                                } else {
                                  RebiMessage.warning(
                                      msg: "You have to be customer first",
                                      context: context);
                                }
                              },
                              title: "Card".tra,
                              icon: AppIcons.cardIcon,
                              color: AppColors.whiteLight),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: CardAndBankWidget(
                              onTap: () {
                                if (AppSharedPreferences.getBankAccount ==
                                    true) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const BankTransfersScreen()));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddBankAccountScreen()));
                                }
                              },
                              title: "Bank".tra,
                              icon: AppIcons.bankIcon,
                              color: AppColors.whiteLight),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Recent transactions".tra,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Color(0xFFC48636),
                          fontSize: 16,
                          fontFamily: 'Noto Sans',
                          fontWeight: FontWeight.w700,
                          height: 0.11,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: AllTransactionsWidget()),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
