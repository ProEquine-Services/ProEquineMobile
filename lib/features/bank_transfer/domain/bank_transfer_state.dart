part of 'bank_transfer_cubit.dart';

@immutable
abstract class BankTransferState {}

class BankTransferInitial extends BankTransferState {}

class GetAllBankTransfersSuccessful extends BankTransferState {
  final List<BankTransfer> responseModel;
  final int offset;
  final int count;

  GetAllBankTransfersSuccessful(
      {required this.offset, required this.count, required this.responseModel});
}

class GetAllBankTransfersLoading extends BankTransferState {}

class GetAllBankTransfersError extends BankTransferState {
  final String? message;

  GetAllBankTransfersError({this.message});
}

class SaveBankAccountSuccessful extends BankTransferState {
  final String? message;

  SaveBankAccountSuccessful({required this.message});
}

class SaveBankAccountLoading extends BankTransferState {}

class SaveBankAccountError extends BankTransferState {
  final String? message;

  SaveBankAccountError({this.message});
}

class CreateBankPaySuccessfully extends BankTransferState {
  final CreateBankTransferResponseModel responseModel;

  CreateBankPaySuccessfully(this.responseModel);
}

class CreateBankPayLoading extends BankTransferState {}

class CreateBankPayError extends BankTransferState {
  final String? message;

  CreateBankPayError({this.message});
}

class PushTransferSuccessfully extends BankTransferState {
  final String message;

  PushTransferSuccessfully(this.message);
}

class PushTransferLoading extends BankTransferState {}

class PushTransferError extends BankTransferState {
  final String? message;

  PushTransferError({this.message});
}

class UploadTransferProofSuccessfully extends BankTransferState {
  final UploadFileResponseModel? fileUrl;

  UploadTransferProofSuccessfully({required this.fileUrl});
}

class UploadTransferProofLoading extends BankTransferState {}

class UploadTransferProofError extends BankTransferState {
  final String? message;

  UploadTransferProofError({this.message});
}


class GetBankAccountSuccessfully extends BankTransferState {
  final GetBankAccountResponseModel? model;

  GetBankAccountSuccessfully({required this.model});
}

class GetBankAccountLoading extends BankTransferState {}

class GetBankAccountError extends BankTransferState {
  final String? message;

  GetBankAccountError({this.message});
}
