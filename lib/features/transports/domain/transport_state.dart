part of 'transport_cubit.dart';

@immutable
abstract class TransportState {}

class TransportInitial extends TransportState {}

class GetAllTransportsSuccessfully extends TransportState {
  final List<TransportModel> transports;
  final int offset;
  final int count;

  GetAllTransportsSuccessfully(
      {required this.transports, required this.offset, required this.count});
}

class GetAllTransportsLoading extends TransportState {}

class GetAllTransportsError extends TransportState {
  final String? message;

  GetAllTransportsError({this.message});
}

class CreateLocalTransportSuccessfully extends TransportState {
  final TransportModel responseModel;

  CreateLocalTransportSuccessfully({
    required this.responseModel,
  });
}

class CreateLocalTransportLoading extends TransportState {}

class CreateLocalTransportError extends TransportState {
  final String? message;

  CreateLocalTransportError({this.message});
}

class UpdateLocalTransportSuccessfully extends TransportState {
  final TransportModel responseModel;

  UpdateLocalTransportSuccessfully({
    required this.responseModel,
  });
}

class UpdateLocalTransportLoading extends TransportState {}

class UpdateLocalTransportError extends TransportState {
  final String? message;

  UpdateLocalTransportError({this.message});
}

class PushTransportSuccessfully extends TransportState {
  final String message;

  PushTransportSuccessfully({
    required this.message,
  });
}

class PushTransportLoading extends TransportState {}

class PushTransportError extends TransportState {
  final String? message;

  PushTransportError({this.message});
}
class RemoveTripSuccessfully extends TransportState {
  final String message;

  RemoveTripSuccessfully({
    required this.message,
  });
}

class RemoveTripLoading extends TransportState {}

class RemoveTripError extends TransportState {
  final String? message;

  RemoveTripError({this.message});
}