part of 'horse_cubit.dart';

@immutable
abstract class HorseState {}

class HorseInitial extends HorseState {}

class AddHorseSuccessfully extends HorseState{
  final String message;
  AddHorseSuccessfully({required this.message});
}
class AddHorseLoading extends HorseState{}
class AddHorseError extends HorseState{
  final String? message;
  AddHorseError({this.message});
}
class UpdateHorseSuccessfully extends HorseState{
  final String message;
  UpdateHorseSuccessfully({required this.message});
}
class UpdateHorseLoading extends HorseState{}
class UpdateHorseError extends HorseState{
  final String? message;
  UpdateHorseError({this.message});
}
class UploadFileSuccessful extends HorseState {
  final UploadFileResponseModel? fileUrl;

  UploadFileSuccessful({required this.fileUrl});
}

class UploadFileLoading extends HorseState {}

class UploadFileError extends HorseState {
  final String? message;

  UploadFileError({this.message});
}
class UploadNationalPassportFileSuccessful extends HorseState {
  final UploadFileResponseModel? fileUrl;

  UploadNationalPassportFileSuccessful({required this.fileUrl});
}

class UploadNationalPassportFileLoading extends HorseState {}

class UploadNationalPassportFileError extends HorseState {
  final String? message;

  UploadNationalPassportFileError({this.message});
}
class RemoveHorseSuccessfully extends HorseState{
  final String message;
  RemoveHorseSuccessfully({required this.message});
}
class RemoveHorseLoading extends HorseState{}
class RemoveHorseError extends HorseState{
  final String? message;
  RemoveHorseError({this.message});
}

class UpdateHorseConditionSuccessfully extends HorseState{
  final String message;
  UpdateHorseConditionSuccessfully({required this.message});
}
class UpdateHorseConditionLoading extends HorseState{}
class UpdateHorseConditionError extends HorseState{
  final String? message;
  UpdateHorseConditionError({this.message});
}

class AddHorseDocumentSuccessfully extends HorseState{
  final String message;
  AddHorseDocumentSuccessfully({required this.message});
}
class AddHorseDocumentLoading extends HorseState{}
class AddHorseDocumentError extends HorseState{
  final String? message;
  AddHorseDocumentError({this.message});
}
class RemoveHorseDocumentSuccessfully extends HorseState{
  final String message;
  RemoveHorseDocumentSuccessfully({required this.message});
}
class RemoveHorseDocumentLoading extends HorseState{}
class RemoveHorseDocumentError extends HorseState{
  final String? message;
  RemoveHorseDocumentError({this.message});
}
class EditHorseDocumentSuccessfully extends HorseState{
  final String message;
  EditHorseDocumentSuccessfully({required this.message});
}
class EditHorseDocumentLoading extends HorseState{}
class EditHorseDocumentError extends HorseState{
  final String? message;
  EditHorseDocumentError({this.message});
}

class VerifyHorseSuccessfully extends HorseState{
  final String message;
  VerifyHorseSuccessfully({required this.message});
}
class VerifyHorseLoading extends HorseState{}
class VerifyHorseError extends HorseState{
  final String? message;
  VerifyHorseError({this.message});
}

class GetHorsesSuccessfully extends HorseState{
  final List<Horse> horses;
  final int offset;
  final int count;
  GetHorsesSuccessfully({required this.horses,required this.offset,required this.count});
}
class GetHorsesLoading extends HorseState{}
class GetHorsesError extends HorseState{
  final String? message;
  GetHorsesError({this.message});
}
class GetUserHorsesSuccessfully extends HorseState{
  final List<Horse> horses;
  final int offset;
  final int count;
  GetUserHorsesSuccessfully({required this.horses,required this.offset,required this.count});
}
class GetUserHorsesLoading extends HorseState{}
class GetUserHorsesError extends HorseState{
  final String? message;
  GetUserHorsesError({this.message});
}

class GetUserAndAssociatedHorsesSuccessfully extends HorseState{
  final List<UserAndAssociatedHorses> horses;
  final int offset;
  final int count;
  GetUserAndAssociatedHorsesSuccessfully({required this.horses,required this.offset,required this.count});
}
class GetUserAndAssociatedHorsesLoading extends HorseState{}
class GetUserAndAssociatedHorsesError extends HorseState{
  final String? message;
  GetUserAndAssociatedHorsesError({this.message});
}


class GetAcceptedHorsesSuccessfully extends HorseState{
  final List<InviteResponseModel> horses;
  final int offset;
  final int count;
  GetAcceptedHorsesSuccessfully({required this.horses,required this.offset,required this.count});
}
class GetAcceptedHorsesLoading extends HorseState{}
class GetAcceptedHorsesError extends HorseState{
  final String? message;
  GetAcceptedHorsesError({this.message});
}

class GetHorsesDocumentsSuccessfully extends HorseState{
  final List<HorseDocuments> documents;
  final int offset;
  final int count;
  GetHorsesDocumentsSuccessfully({required this.documents,required this.offset,required this.count});
}
class GetHorsesDocumentsLoading extends HorseState{}
class GetHorsesDocumentsError extends HorseState{
  final String? message;
  GetHorsesDocumentsError({this.message});
}



