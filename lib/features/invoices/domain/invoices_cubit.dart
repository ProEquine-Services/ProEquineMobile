

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/invoices/domain/repo/invoice_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:uuid/uuid.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/CoreModels/empty_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/secure_storage/secure_storage_helper.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../../wallet/data/store_payment_id.dart';
import '../../wallet/presentation/screens/failed_payment_screen.dart';
import '../../wallet/presentation/widgets/loading_payment_screen.dart';
import '../data/user_invoices_response_model.dart';

part 'invoices_state.dart';

class InvoicesCubit extends Cubit<InvoicesState> {
  InvoicesCubit() : super(InvoicesInitial());

  int? limit = 8;
  List<dynamic> invoices = [];
  int count = 0;
  int total = 0;
  int offset = 0;
  late RefreshController refreshController;


  String? paymentId;

  Map<String, dynamic>? paymentIntent;
  final String publishKey =
      'pk_live_51PDqw6AwfKE5HT64ZEKpzjkHBcK1si4FwChVgaQwDG7oh0K1SdCHJnrND8m0rgSQLtKEH40i9nt3j0z4xYf9qxXj00j7g9gYLQ';
  final String secretKey =
      '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';

  // final String publishKey ='pk_test_51JSKeuJawRWtFfJ7Pl7OzShHujsSvaaB0KjNVa5eS4jR0F0NTmJHuXfW8lyyqKOb0OYpI3GWFsV2xGUmfgJjL6hh00C89XiTTu';
  //
  // final String secretKey =
  //     'sk_test_51JSKeuJawRWtFfJ7B2Wy3MioWGTfySeFsjCgGF11ZtRlih4EHm9sdzwoNJcbEpKtxsnsrxNJf3snm3vsXRAtOLyu006OtrTl50';


  displayPaymentSheet(BuildContext context, String totalAmount,
      String paymentTime, String orderId, String invoiceNumber) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoadingPaymentScreen(
                  invoiceNumber: invoiceNumber ,
                    orderId: orderId,
                    comingFromStripe: true,
                    paymentTime: paymentTime,
                    paymentAmount: totalAmount)));
      }).onError((error, stackTrace) {});
    } on StripeException catch (e) {
      Print(e.toString());

      if (context.mounted) {
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FailedPaymentScreen(
                    paymentTime: paymentTime, paymentAmount: totalAmount)));
      }
    } catch (e) {
      Print(e);
    }
  }

  Future<void> makeDirectPayment(
      {required int amount,
      required BuildContext context,
      required String tax,
      required String totalAmount,
      required String invoiceId,
      required String invoiceNumber,
     }) async {
    String? userId = await SecureStorage().getUserId();
    String? customerName = AppSharedPreferences.getName;
    var orderId = const Uuid().v1(options: {
      'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
      'clockSeq': 0x1234,
      'mSecs': DateTime.now().millisecondsSinceEpoch,
      'nSecs': 5678
    });

    try {
      paymentIntent = await createPaymentIntent(amount.toString(), 'AED', {
        "order_id": orderId,
        "customer_name": customerName,
        "priority": "high",
        "user_id": userId,
        "invoice_id": invoiceId,
      });

      await Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            merchantDisplayName: 'ProEquine',
            billingDetails: BillingDetails(
              name: AppSharedPreferences.getName,
              phone: AppSharedPreferences.userPhoneNumber,
              // email: 'bahaa.soubh@gmail.com',
            ),
            allowsDelayedPaymentMethods: false,
            customerEphemeralKeySecret: paymentIntent!['ephemeralkey'],
            customerId: paymentIntent!['customer'],
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            style: ThemeMode.light,
          ))
          .then((value) {});
      if (context.mounted) {
        String formattedDateTime =
        DateFormat('dd-MM-yyyy, HH:mm:ss')
            .format(DateTime.now());
        displayPaymentSheet(context, totalAmount, formattedDateTime, orderId, invoiceNumber);
      }

      Print('client_secret ${paymentIntent!['client_secret']}');
    } catch (e, _) {
      Print(e);
    }
  }

  Future createPaymentIntent(String amount, String currency, metaData) async {
    emit(StripeDirectPaymentLoading());
    Print("In Price");
    final dio = Dio();

    try {
      Print("In Try");

      var response = await dio.post("https://api.stripe.com/v1/payment_intents",
          options: Options(headers: {
            'Authorization': 'Bearer $secretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          }),
          queryParameters: {
            'amount': calculateAmount(amount),
            'currency': currency,
            'metadata': metaData,
          });

      if (response.statusCode == 200) {
        Print("Response is ${response.data}");
        Print("Response is ${response.statusCode}");
        Print("Response is ${response.statusMessage}");
        Print("id is ${response.data['id']}");
        paymentId = response.data['id'];
        savePaymentId(paymentId!);
        Print(" payment id from stripe is $paymentId");
        // Print("Transaction Id ${response.data['data'][0]['balanceTransaction']}");

        Print("Ram::::::::::::Success");
      } else {
        Print(response.data);
      }
      return response.data;
    } catch (e) {
      Print("In Try");
      emit(StripeDirectPaymentError(message: e.toString()));

      Print(e);
      Print("Ram::::::::::::False");
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }


  Future<void> getAllInvoices(
      {int limit = 8,
        bool loadMore = false,
        bool isRefreshing = false,
        String? fullName}) async {
    if (isRefreshing) {
      limit = 8;
      offset = 0;
    }
    if (loadMore) {
      offset = limit + offset;
      Print('offset1 $offset');
      if (count <= offset) {
        Print("Done");
        return;
      }
    } else {
      offset = 0;
      emit(GetAllInvoicesLoading());
    }
    var response =
    await InvoiceRepository.getAllInvoices(offset: offset, limit: limit);
    if (response is UserInvoicesResponseModel) {
      Print("Offset is $offset");
      count = response.count!;
      List<Invoice> supportRequestsAsList = <Invoice>[];
      supportRequestsAsList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (invoices.length < count) {
          invoices.addAll(supportRequestsAsList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        invoices = supportRequestsAsList;
      }
      emit(GetAllInvoicesSuccessful(
          responseModel: List<Invoice>.from(invoices),
          offset: offset,
          count: count));
    } else if (response is BaseError) {
      if (offset > 0) offset = 0;
      emit(GetAllInvoicesError(message: response.message));
    } else if (response is Message) {
      emit(GetAllInvoicesError(message: response.content));
    }
  }

  Future<void> payByWallet(int id) async {
    emit(PayByWalletLoading());
    var response = await InvoiceRepository.payInvoiceByWallet(id);
    if (response is EmptyModel) {
      emit(PayByWalletSuccessfully(
          message: "Paid ".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(PayByWalletError(message: response.message));
    } else if (response is Message) {
      emit(PayByWalletError(message: response.content));
    }
  }
}
