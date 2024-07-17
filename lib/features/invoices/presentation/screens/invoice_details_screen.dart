import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:proequine/core/constants/constants.dart';
import 'package:proequine/core/constants/thems/app_styles.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/core/utils/rebi_message.dart';
import 'package:proequine/core/widgets/divider.dart';
import 'package:proequine/core/widgets/rebi_button.dart';
import 'package:proequine/features/invoices/domain/invoices_cubit.dart';
import 'package:proequine/features/invoices/presentation/screens/success_payment_invoice_screen.dart';
import 'package:proequine/features/invoices/presentation/widgets/available_wallet_widget.dart';
import 'package:proequine/features/invoices/presentation/widgets/invoice_header_widget.dart';
import 'package:proequine/features/invoices/presentation/widgets/unavailable_wallet_widget.dart';
import 'package:proequine/features/wallet/presentation/screens/main_wallet_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/images/app_images.dart';
import '../../../../core/utils/Printer.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../core/widgets/drop_down_menu_widget.dart';
import '../../../../core/widgets/global_bottom_sheet.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../wallet/presentation/screens/failed_payment_screen.dart';
import '../../data/user_invoices_response_model.dart';
import '../widgets/invoice_items_list_widget.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  final Invoice invoice;

  const InvoiceDetailsScreen({super.key, required this.invoice});

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  String? selectedPaymentMethod;

  double calculateFees(double amount) {
    return (amount * 0.029) + 1;
  }

  double calculateTotalWithFee(double amount) {
    double fee = calculateFees(amount);
    return amount + fee;
  }

  double calculateTaxes(List<Tax> items) {
    return items.fold(0, (sum, item) => sum + item.taxAmount!.toDouble());
  }

  List<DropdownMenuItem<String>> paymentMethods = [
    const DropdownMenuItem(
      value: "Wallet",
      child: Text("Wallet"),
    ),
    const DropdownMenuItem(
      value: "Direct Payment",
      child: Text("Direct Payment"),
    ),
  ];

  String formatDate(DateTime date) {
    // Define the date format
    final dateFormat = DateFormat("MMMM d, yyyy");
    // Format the date
    final formattedDate = dateFormat.format(date);
    return formattedDate;
  }

  InvoicesCubit cubit = InvoicesCubit();

  @override
  Widget build(BuildContext context) {
    var myCubit = context.watch<InvoicesCubit>();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15.h),
        child: CustomHeader(
          title: "Invoice Details".tra,
          isThereBackButton: true,
          isThereChangeWithNavigate: false,
          isThereThirdOption: true,
          thirdOptionIcon: InkWell(
            onTap: () {
              showGlobalBottomSheet(
                  context: context,
                  title: "Help",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kPadding,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(
                              color: AppColors.borderColor,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: kPadding, vertical: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Online payment fees",
                                      style: TextStyle(
                                          color: Color(0xFF6B7280),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'notosan'),
                                    ),
                                    Text(
                                      "2.9 %",
                                      style: TextStyle(
                                          color: AppColors.blackLight,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'notosan'),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CustomDivider(),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Wallet payment fees",
                                      style: TextStyle(
                                          color: Color(0xFF6B7280),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'notosan'),
                                    ),
                                    Text(
                                      "0.00 AED",
                                      style: TextStyle(
                                          color: AppColors.blackLight,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'notosan'),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CustomDivider(),
                                ),
                                Text(
                                  "• All prices are tax inclusive",
                                  style: TextStyle(
                                      color: Color(0xFF6B7280),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'notosan'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "• The final detailed invoice will be sent to the registered email address",
                                  style: TextStyle(
                                      color: Color(0xFF6B7280),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'notosan'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            },
            child: SvgPicture.asset(
              AppIcons.questionMark,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InvoiceHeaderWidget(
                date: formatDate(widget.invoice.invoiceDetails!.date!),
                invNumber:
                    widget.invoice.invoiceDetails!.invoiceNumber.toString()),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Items',
              style: TextStyle(
                color: Color(0xFF9C9797),
                fontSize: 12,
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InvoiceItemsListWidget(
              items: widget.invoice.invoiceDetails!.lineItems!,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(
                  color: AppColors.borderColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sub Total :',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${widget.invoice.invoiceDetails!.subTotal.toString()} AED',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Taxes: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${calculateTaxes(widget.invoice.invoiceDetails!.taxes!)} AED',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Visibility(
                      visible: selectedPaymentMethod == 'Direct Payment',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Fees: ',
                            style: TextStyle(
                              color: Color(0xFF9D9898),
                              fontSize: 12,
                              fontFamily: 'Noto Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${calculateFees(widget.invoice.invoiceDetails!.total!.toDouble()).floor().toStringAsFixed(2)} AED',
                            style: const TextStyle(
                              color: Color(0xFF9D9898),
                              fontSize: 12,
                              fontFamily: 'Noto Sans',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: selectedPaymentMethod == 'Direct Payment',
                      child: const SizedBox(
                        height: 15,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Amount : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          selectedPaymentMethod == 'Direct Payment'
                              ? '${calculateTotalWithFee(widget.invoice.invoiceDetails!.total!.toDouble()).floor().toStringAsFixed(2)} AED'
                              : '${widget.invoice.invoiceDetails!.total!.toDouble()} AED',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Remaining Amount : ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          selectedPaymentMethod == 'Direct Payment'
                              ? '${calculateTotalWithFee(widget.invoice.invoiceDetails!.total!.toDouble()).floor().toStringAsFixed(2)} AED'
                              : '${widget.invoice.invoiceDetails!.total!.toDouble()} AED',
                          style: const TextStyle(
                            color: AppColors.yellow,
                            fontSize: 12,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Payment Method',
              style: TextStyle(
                color: Color(0xFF9C9797),
                fontSize: 14,
                fontFamily: 'Noto Sans',
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            DropDownWidget(
              items: paymentMethods,
              selected: selectedPaymentMethod,
              onChanged: (method) {
                setState(() {
                  selectedPaymentMethod = method;
                  Print('selected gender $selectedPaymentMethod');
                });
              },
              validator: (value) {
                // return Validator.requiredValidator(selectedNumber);
              },
              hint: 'Select Payment Method',
            ),
            const SizedBox(
              height: 15,
            ),
            selectedPaymentMethod == 'Wallet'
                ? widget.invoice.walletAvailableAmount! >=
                        widget.invoice.invoiceDetails!.total!.toDouble()
                    ? AvailableWalletWidget(
                        amount: widget.invoice.walletAvailableAmount!)
                    : GestureDetector(
                        onTap: () {
                          myCubit.getAllInvoices(limit: 1000);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainWalletScreen(
                                        invoiceTopUp: true,
                                      )));
                        },
                        child: UnAvailableWalletWidget(
                            amount: widget.invoice.walletAvailableAmount!))
                : const SizedBox(),
            const Spacer(),
            selectedPaymentMethod == 'Direct Payment'
                ? BlocConsumer<InvoicesCubit, InvoicesState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is StripeDirectPaymentError) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FailedPaymentScreen(
                                    paymentTime: DateTime.now().toString(),
                                    paymentAmount: calculateTotalWithFee(widget
                                            .invoice.invoiceDetails!.total!
                                            .toDouble())
                                        .toString())));
                      } else if (state is StripeDirectPaymentSuccessfully) {}
                    },
                    builder: (context, state) {
                      if (state is StripeDirectPaymentLoading) {
                        return const LoadingCircularWidget();
                      }
                      return RebiButton(
                        onPressed: () {
                          onPressCharge(
                              double.parse(calculateTotalWithFee(widget
                                          .invoice.invoiceDetails!.total!
                                          .toDouble())
                                      .toString())
                                  .toInt(),
                              context);
                        },
                        child: Text(
                          "Pay".tra,
                          style: const TextStyle(
                            fontFamily: "din",
                          ),
                        ),
                      );
                    },
                  )
                : BlocConsumer<InvoicesCubit, InvoicesState>(
                    bloc: cubit,
                    listener: (context, state) {
                      if (state is PayByWalletError) {
                        RebiMessage.error(
                            msg: state.message!, context: context);
                      } else if (state is PayByWalletSuccessfully) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SuccessWalletPaymentInvoiceScreen(
                                    invoiceNumber: widget
                                        .invoice.invoiceDetails!.invoiceNumber!,
                                    paymentTime: formatDate(
                                        widget.invoice.invoiceDetails!.date!),
                                    paymentAmount: selectedPaymentMethod ==
                                            'Direct Payment'
                                        ? '${calculateTotalWithFee(widget.invoice.invoiceDetails!.total!.toDouble()).toStringAsFixed(2)} AED'
                                        : '${widget.invoice.invoiceDetails!.total!.toDouble()}')));
                      }
                    },
                    builder: (context, state) {
                      if (state is PayByWalletLoading) {
                        return const LoadingCircularWidget();
                      }
                      return RebiButton(
                        onPressed: () {
                          if (selectedPaymentMethod != null) {
                            onPressPayByWallet(widget.invoice.id!);
                          } else {
                            RebiMessage.error(
                                msg: "Select payment method",
                                context: context);
                          }
                        },
                        child: Text(
                          "Pay",
                          style: AppStyles.buttonTitle,
                        ),
                      );
                    },
                  ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  onPressCharge(
    int amount,
    BuildContext context,
  ) async {
    await cubit.makeDirectPayment(
        amount: amount,
        invoiceNumber: widget.invoice.invoiceDetails!.invoiceNumber!,
        context: context,
        tax: '${10}',
        totalAmount:
            '${calculateTotalWithFee(widget.invoice.invoiceDetails!.total!.toDouble())}',
        invoiceId: widget.invoice.id.toString());
  }

  onPressPayByWallet(int id) {
    cubit.payByWallet(id);
  }
}
