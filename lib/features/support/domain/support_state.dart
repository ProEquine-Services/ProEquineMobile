part of 'support_cubit.dart';

@immutable
abstract class SupportState {}

class SupportInitial extends SupportState {}

class ContactSupportSuccessful extends SupportState{
  final CreateSupportResponseModel? model;
  ContactSupportSuccessful({required this.model});
}
class ContactSupportLoading extends SupportState{}
class ContactSupportError extends SupportState{
  final String? message;
  ContactSupportError({this.message});
}

class GetAllSupportSuccessful extends SupportState{
  final List<SupportRequestModel> responseModel;
  final int offset;
  final int count;
  GetAllSupportSuccessful({required this.offset, required this.count, required this.responseModel});
}
class GetAllSupportLoading extends SupportState{}
class GetAllSupportError extends SupportState{
  final String? message;
  GetAllSupportError({this.message});
}