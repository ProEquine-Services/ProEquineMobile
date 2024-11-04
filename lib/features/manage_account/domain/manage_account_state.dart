part of 'manage_account_cubit.dart';

@immutable
abstract class ManageAccountState {}

class ManageAccountInitial extends ManageAccountState {}

class ChangePasswordSuccessful extends ManageAccountState{
  final String? message;
  ChangePasswordSuccessful({required this.message});
}
class ChangePasswordLoading extends ManageAccountState{}
class ChangePasswordError extends ManageAccountState{
  final String? message;
  ChangePasswordError({this.message});
}

class SendPhoneSuccessful extends ManageAccountState{
  final String? message;
  SendPhoneSuccessful({required this.message});
}
class SendPhoneLoading extends ManageAccountState{}
class SendPhoneError extends ManageAccountState{
  final String? message;
  SendPhoneError({this.message});
}
class UpdatePhoneSuccessful extends ManageAccountState{
  final String? message;
  UpdatePhoneSuccessful({required this.message});
}
class UpdatePhoneLoading extends ManageAccountState{}
class UpdatePhoneError extends ManageAccountState{
  final String? message;
  UpdatePhoneError({this.message});
}
class UpdatePhoneSecondarySuccessful extends ManageAccountState{
  final String? message;
  UpdatePhoneSecondarySuccessful({required this.message});
}
class UpdateSecondaryPhoneLoading extends ManageAccountState{}
class UpdatePhoneSecondaryError extends ManageAccountState{
  final String? message;
  UpdatePhoneSecondaryError({this.message});
}

class AddAddressSuccessfully extends ManageAccountState{
  final String? message;
  AddAddressSuccessfully({required this.message});
}
class AddAddressLoading extends ManageAccountState{}
class AddAddressError extends ManageAccountState{
  final String? message;
  AddAddressError({this.message});
}
class AddSecondaryPhoneSuccessful extends ManageAccountState{
  final AddSecondaryNumberResponseModel? responseModel;
  AddSecondaryPhoneSuccessful({required this.responseModel});
}
class AddSecondaryPhoneLoading extends ManageAccountState{}
class AddSecondaryPhoneError extends ManageAccountState{
  final String? message;
  AddSecondaryPhoneError({this.message});
}


class GetUserSuccessful extends ManageAccountState{
  final UserDataResponseModel? responseModel;
  GetUserSuccessful({required this.responseModel});
}
class GetUserLoading extends ManageAccountState{}
class GetUserError extends ManageAccountState{
  final String? message;
  GetUserError({this.message});
}
class UploadFileSuccessful extends ManageAccountState {
  final UploadFileResponseModel? fileUrl;

  UploadFileSuccessful({required this.fileUrl});
}

class UploadFileLoading extends ManageAccountState {}

class UploadFileError extends ManageAccountState {
  final String? message;

  UploadFileError({this.message});
}

class UpdateImageSuccessful extends ManageAccountState {
  final UserDataResponseModel? response;

  UpdateImageSuccessful({required this.response});
}

class UpdateImageLoading extends ManageAccountState {}

class UpdateImageError extends ManageAccountState {
  final String? message;

  UpdateImageError({this.message});
}
class UpdateUserInfoSuccessful extends ManageAccountState {
  final String? message;
  UpdateUserInfoSuccessful({required this.message});
}

class UpdateUserInfoLoading extends ManageAccountState {}

class UpdateUserInfoError extends ManageAccountState {
  final String? message;
  UpdateUserInfoError({this.message});
}
class AddBioSuccessful extends ManageAccountState {
  final String? message;
  AddBioSuccessful({required this.message});
}

class AddBioLoading extends ManageAccountState {}

class AddBioError extends ManageAccountState {
  final String? message;
  AddBioError({this.message});
}


class GetConfigurationSuccessfully extends ManageAccountState {
  final ConfigurationResponseModel? responseModel;
  GetConfigurationSuccessfully({required this.responseModel});
}

class GetConfigurationLoading extends ManageAccountState {}

class GetConfigurationError extends ManageAccountState {
  final String? message;
  GetConfigurationError({this.message});
}
