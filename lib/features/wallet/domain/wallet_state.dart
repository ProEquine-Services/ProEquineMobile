part of 'wallet_cubit.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}

class GetWalletSuccessfully extends WalletState{
  final MyAccountResponseModel model;
  GetWalletSuccessfully({required this.model});
}
class GetWalletLoading extends WalletState{}
class GetWalletError extends WalletState{
  final String? message;
  GetWalletError({this.message});
}

class GetTransactionsSuccessfully extends WalletState{
  final List<Transaction> transactions;
  final int offset;
  final int count;
  GetTransactionsSuccessfully({required this.transactions,required this.offset,required this.count});
}
class GetTransactionsLoading extends WalletState{}
class GetTransactionsError extends WalletState{
  final String? message;
  GetTransactionsError({this.message});
}
class StripePaymentSuccessfully extends WalletState {
  final String? message;

  StripePaymentSuccessfully({required this.message});
}

class StripePaymentLoading extends WalletState {}

class StripePaymentInitial extends WalletState {}


class StripePaymentError extends WalletState {
  final String? message;

  StripePaymentError({required this.message});
}

class PaymentDetailsSuccessfully extends WalletState {
  final PaymentDetailsResponseModel? model;

  PaymentDetailsSuccessfully({required this.model});
}

class PaymentDetailsLoading extends WalletState {}

class PaymentDetailsError extends WalletState {
  final String? message;

  PaymentDetailsError({required this.message});
}
