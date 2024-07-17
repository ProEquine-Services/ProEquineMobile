part of 'associations_cubit.dart';

@immutable
abstract class AssociationsState {}

class AssociationsInitial extends AssociationsState {}

class GetInviteAssociationsSuccessfully extends AssociationsState{
  final GetHorseRequestResponseModel invites;
  GetInviteAssociationsSuccessfully({required this.invites});
}
class GetInviteAssociationsLoading extends AssociationsState{}
class GetInviteAssociationsError extends AssociationsState{
  final String? message;
  GetInviteAssociationsError({this.message});
}

class GetRequestsAssociationsSuccessfully extends AssociationsState{
  final GetHorseRequestResponseModel model;
  GetRequestsAssociationsSuccessfully({required this.model});
}
class GetRequestsAssociationsLoading extends AssociationsState{}
class GetRequestsAssociationsError extends AssociationsState{
  final String? message;
  GetRequestsAssociationsError({this.message});
}

class AssociateHorseSuccessfully extends AssociationsState{
  final String message;
  AssociateHorseSuccessfully({required this.message});
}
class AssociateHorseLoading extends AssociationsState{}
class AssociateHorseError extends AssociationsState{
  final String? message;
  AssociateHorseError({this.message});
}
class CancelAssociateHorseSuccessfully extends AssociationsState{
  final String message;
  CancelAssociateHorseSuccessfully({required this.message});
}
class CancelAssociateHorseLoading extends AssociationsState{}
class CancelAssociateHorseError extends AssociationsState{
  final String? message;
  CancelAssociateHorseError({this.message});
}
class ApproveAssociateHorseSuccessfully extends AssociationsState{
  final String message;
  ApproveAssociateHorseSuccessfully({required this.message});
}
class ApproveAssociateHorseLoading extends AssociationsState{}
class ApproveAssociateHorseError extends AssociationsState{
  final String? message;
  ApproveAssociateHorseError({this.message});
}

class RejectAssociateHorseSuccessfully extends AssociationsState{
  final String message;
  RejectAssociateHorseSuccessfully({required this.message});
}
class RejectAssociateHorseLoading extends AssociationsState{}
class RejectAssociateHorseError extends AssociationsState{
  final String? message;
  RejectAssociateHorseError({this.message});
}
