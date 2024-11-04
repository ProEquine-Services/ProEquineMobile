import 'dart:async';
import 'package:flutter/material.dart';
import 'package:proequine_dev/features/invoices/presentation/screens/success_stripe_payment_invoice.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../screens/success_payment_screen.dart';

class LoadingPaymentScreen extends StatefulWidget {
  final String orderId;
  final String paymentTime;
  final String paymentAmount;
  final String? invoiceNumber;
  final bool invoiceTopUp;
  final bool comingFromStripe;

  const LoadingPaymentScreen(
      {Key? key,
      required this.orderId,
      required this.paymentTime,
      this.invoiceNumber,
      this.invoiceTopUp = false,
      this.comingFromStripe = false,
      required this.paymentAmount})
      : super(key: key);

  @override
  State<LoadingPaymentScreen> createState() => _LoadingPaymentScreenState();
}

class _LoadingPaymentScreenState extends State<LoadingPaymentScreen> {
  late Timer timer;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      if (widget.comingFromStripe) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => SuccessStripePaymentInvoice(
                  invoiceNumber: widget.invoiceNumber!,
                  paymentTime: widget.paymentTime,
                  paymentAmount: widget.paymentAmount)),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => SuccessPaymentScreen(
                  refNumber: widget.orderId,
                  invoiceTopUp: widget.invoiceTopUp,
                  paymentTime: widget.paymentTime,
                  paymentAmount: widget.paymentAmount)),
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [LoadingCircularWidget()],
      ),
    );
  }
}
