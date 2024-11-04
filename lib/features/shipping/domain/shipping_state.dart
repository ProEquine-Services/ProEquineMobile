part of 'shipping_cubit.dart';

@immutable
abstract class ShippingState {}

class ShippingInitial extends ShippingState {}

class GetAllShippingRequestsSuccessfully extends ShippingState {
  final List<ShippingModel> transports;
  final int offset;
  final int count;

  GetAllShippingRequestsSuccessfully(
      {required this.transports, required this.offset, required this.count});
}

class GetAllShippingRequestsLoading extends ShippingState {}

class GetAllShippingRequestsError extends ShippingState {
  final String? message;

  GetAllShippingRequestsError({this.message});
}

class GetAllSelectiveServicesSuccessfully extends ShippingState {
  final List<SelectiveServiceModel> model;
  final int offset;
  final int count;

  GetAllSelectiveServicesSuccessfully(
      {required this.model, required this.offset, required this.count});
}

class GetAllSelectiveServicesLoading extends ShippingState {}

class GetAllSelectiveServicesError extends ShippingState {
  final String? message;

  GetAllSelectiveServicesError({this.message});
}

class CreateShippingSuccessfully extends ShippingState {
  final CreateShippingResponseModel responseModel;

  CreateShippingSuccessfully({
    required this.responseModel,
  });
}

class CreateShippingLoading extends ShippingState {}

class CreateShippingError extends ShippingState {
  final String? message;

  CreateShippingError({this.message});
}

class EditShippingSuccessfully extends ShippingState {
  final CreateShippingResponseModel responseModel;

  EditShippingSuccessfully({
    required this.responseModel,
  });
}

class EditShippingLoading extends ShippingState {}

class EditShippingError extends ShippingState {
  final String? message;

  EditShippingError({this.message});
}

class RemoveShippingSuccessfully extends ShippingState {
  final String message;

  RemoveShippingSuccessfully({
    required this.message,
  });
}

class RemoveShippingLoading extends ShippingState {}

class RemoveShippingError extends ShippingState {
  final String? message;

  RemoveShippingError({this.message});
}

class GetShippingSuccessfully extends ShippingState {
  final ShippingResponseModel responseModel;

  GetShippingSuccessfully({
    required this.responseModel,
  });
}

class GetShippingLoading extends ShippingState {}

class GetShippingError extends ShippingState {
  final String? message;

  GetShippingError({this.message});
}

class PushShippingSuccessfully extends ShippingState {
  final ShippingResponseModel responseModel;

  PushShippingSuccessfully({
    required this.responseModel,
  });
}

class PushShippingLoading extends ShippingState {}

class PushShippingError extends ShippingState {
  final String? message;

  PushShippingError({this.message});
}

class JoinSelectiveServiceSuccessfully extends ShippingState {
  final String? message;

  JoinSelectiveServiceSuccessfully({
    this.message,
  });
}

class JoinSelectiveServiceLoading extends ShippingState {}

class JoinSelectiveServiceError extends ShippingState {
  final String? message;

  JoinSelectiveServiceError({this.message});
}
