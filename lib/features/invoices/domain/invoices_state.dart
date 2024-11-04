part of 'invoices_cubit.dart';

@immutable
abstract class InvoicesState {}

class InvoicesInitial extends InvoicesState {}

class GetAllInvoicesSuccessful extends InvoicesState {
  final List<Invoice> responseModel;
  final int offset;
  final int count;

  GetAllInvoicesSuccessful(
      {required this.offset, required this.count, required this.responseModel});
}

class GetAllInvoicesLoading extends InvoicesState {}

class GetAllInvoicesError extends InvoicesState {
  final String? message;

  GetAllInvoicesError({this.message});
}

class StripeDirectPaymentSuccessfully extends InvoicesState {
  final String? message;

  StripeDirectPaymentSuccessfully({required this.message});
}

class StripeDirectPaymentLoading extends InvoicesState {}

class StripeDirectPaymentError extends InvoicesState {
  final String? message;

  StripeDirectPaymentError({required this.message});
}

class PayByWalletSuccessfully extends InvoicesState {
  final String? message;

  PayByWalletSuccessfully({required this.message});
}

class PayByWalletLoading extends InvoicesState {}

class PayByWalletError extends InvoicesState {
  final String? message;

  PayByWalletError({required this.message});
}
