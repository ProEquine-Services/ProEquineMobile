part of 'exist_customer_cubit.dart';

@immutable
abstract class ExistCustomerState {}

class ExistCustomerInitial extends ExistCustomerState {}

class UpdateCustomerDetailsSuccessfully extends ExistCustomerState{
  final String? message;
  UpdateCustomerDetailsSuccessfully({required this.message});
}
class UpdateCustomerDetailsLoading extends ExistCustomerState{}
class UpdateCustomerDetailsError extends ExistCustomerState{
  final String? message;
  UpdateCustomerDetailsError({this.message});
}

class SendCredentialsSuccessfully extends ExistCustomerState{
  final String? message;
  SendCredentialsSuccessfully({required this.message});
}
class SendCredentialsLoading extends ExistCustomerState{}
class SendCredentialsError extends ExistCustomerState{
  final String? message;
  SendCredentialsError({this.message});
}
