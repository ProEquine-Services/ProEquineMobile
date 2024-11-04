

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import 'package:proequine_dev/features/transports/data/update_local_transport_request_model.dart';
import 'package:proequine_dev/features/transports/domain/repo/transport_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/CoreModels/empty_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../data/create_transport_request_model.dart';
import '../data/create_transport_response_model.dart';
import '../data/get_all_transports_response_model.dart';

part 'transport_state.dart';

class TransportCubit extends Cubit<TransportState> {
  TransportCubit() : super(TransportInitial());

  int? limit = 8;
  int total = 0;
  List<dynamic> transports = [];
  int transportCount = 0;
  int transportOffset = 0;
  late RefreshController refreshController;




  Future<void> createTransport(
      CreateTransportRequestModel createTransportRequestModel) async {
    emit(CreateLocalTransportLoading());
    var response =
    await TransportRepository.createLocalTransport(createTransportRequestModel);
    if (response is TransportModel) {
      emit(CreateLocalTransportSuccessfully(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(CreateLocalTransportError(message: response.message));
    } else if (response is Message) {
      emit(CreateLocalTransportError(message: response.content));
    }
  }
  Future<void> updateTransport(
      UpdateTransportRequestModel updateTransportRequestModel) async {
    emit(UpdateLocalTransportLoading());
    var response =
    await TransportRepository.updateTransport(updateTransportRequestModel);
    if (response is TransportModel) {
      emit(UpdateLocalTransportSuccessfully(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(UpdateLocalTransportError(message: response.message));
    } else if (response is Message) {
      emit(UpdateLocalTransportError(message: response.content));
    }
  }

  Future<void> pushTransport(int id) async {
    emit(PushTransportLoading());
    var response = await TransportRepository.pushTransport(id);
    if (response is TransportModel) {
      emit(PushTransportSuccessfully(
          message: 'Request submitted successfully.'));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(PushTransportError(message: response.message));
    } else if (response is Message) {
      emit(PushTransportError(message: response.content));
    }
  }

  Future<void> getAllTransports(
      {int limit = 8,
        bool loadMore = false,
        String status = 'Requested',
        bool isRefreshing = false}) async {
    if (isRefreshing) {
      limit = 8;
      transportOffset = 0;
    }
    if (loadMore) {
      transportOffset = limit + transportOffset;
      Print('offset1 $transportOffset');
      if (transportCount <= transportOffset) {
        Print("Done");
        return;
      }
    } else {
      transportOffset = 0;
      emit(GetAllTransportsLoading());
    }
    var response = await TransportRepository.getAllTransports(
        offset: transportOffset, limit: limit, status: status);
    if (response is GetUserTransportsResponseModel) {
      Print("Offset is $transportOffset");
      transportCount = response.count!;
      List<TransportModel> transportsAsList = <TransportModel>[];
      transportsAsList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (transports.length < transportCount) {
          transports.addAll(transportsAsList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        transports = transportsAsList;
      }
      emit(GetAllTransportsSuccessfully(
          transports: List<TransportModel>.from(transports),
          offset: transportOffset,
          count: transportCount));
    } else if (response is BaseError) {
      if (transportOffset > 0) transportOffset = 0;
      emit(GetAllTransportsError(message: response.message));
    } else if (response is Message) {
      emit(GetAllTransportsError(message: response.content));
    }
  }

  Future<void> removeTrip(
      int id) async {
    emit(RemoveTripLoading());
    var response =
    await TransportRepository.removeTrip(id);
    if (response is EmptyModel) {
      emit(RemoveTripSuccessfully(message: 'Your trip is canceled successfully.'));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(RemoveTripError(message: response.message));
    } else if (response is Message) {
      emit(RemoveTripError(message: response.content));
    }
  }

}
