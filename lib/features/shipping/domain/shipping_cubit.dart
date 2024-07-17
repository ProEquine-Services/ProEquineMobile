import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/features/shipping/data/create_shipping_request_model.dart';
import 'package:proequine/features/shipping/data/create_shipping_response_model.dart';
import 'package:proequine/features/shipping/data/edit_shipping_request_model.dart';
import 'package:proequine/features/shipping/data/join_selective_service_request_model.dart';
import 'package:proequine/features/shipping/data/selective_service_response_model.dart';
import 'package:proequine/features/shipping/data/shipping_response_model.dart';
import 'package:proequine/features/shipping/data/user_shipping_response_model.dart';
import 'package:proequine/features/shipping/domain/repo/shipping_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';

part 'shipping_state.dart';

class ShippingCubit extends Cubit<ShippingState> {
  ShippingCubit() : super(ShippingInitial());
  int? limit = 8;
  int total = 0;
  List<dynamic> shipping = [];
  List<dynamic> selectiveServices = [];
  int count = 0;
  int selectiveCount = 0;
  int selectiveOffset = 0;
  int offset = 0;
  late RefreshController refreshController;

  Future<void> getAllShippingRequests(
      {int limit = 8,
      bool loadMore = false,
      String status = 'Requested',
      bool isRefreshing = false}) async {
    if (isRefreshing) {
      limit = 8;
      offset = 0;
    }
    if (loadMore) {
      offset = limit + offset;
      Print('offset1 $offset');
      if (count <= offset) {
        Print("Done");
        return;
      }
    } else {
      offset = 0;
      emit(GetAllShippingRequestsLoading());
    }
    var response = await ShippingRepository.getAllShippingRequests(
        offset: offset, limit: limit, status: status);
    if (response is GetUserShippingResponseModel) {
      Print("Offset is $offset");
      count = response.count!;
      List<ShippingModel> shippingAsList = <ShippingModel>[];
      shippingAsList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (shipping.length < count) {
          shipping.addAll(shippingAsList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        shipping = shippingAsList;
      }
      emit(GetAllShippingRequestsSuccessfully(
          transports: List<ShippingModel>.from(shipping),
          offset: offset,
          count: count));
    } else if (response is BaseError) {
      if (offset > 0) offset = 0;
      emit(GetAllShippingRequestsError(message: response.message));
    } else if (response is Message) {
      emit(GetAllShippingRequestsError(message: response.content));
    }
  }

  Future<void> getAllSelectiveServices(
      {int limit = 8,
      bool loadMore = false,
      bool showOnHomePage = false,
      String? type,
      bool isRefreshing = false}) async {
    if (isRefreshing) {
      limit = 8;
      selectiveOffset = 0;
    }
    if (loadMore) {
      selectiveOffset = limit + selectiveOffset;
      Print('offset1 $selectiveOffset');
      if (selectiveCount <= selectiveOffset) {
        Print("Done");
        return;
      }
    } else {
      selectiveOffset = 0;
      emit(GetAllSelectiveServicesLoading());
    }
    var response = await ShippingRepository.getSelectiveService(
        offset: selectiveOffset, limit: limit, type: type,showOnHomePage: showOnHomePage);
    if (response is SelectiveServiceResponseModel) {
      Print("Offset is $selectiveOffset");
      selectiveCount = response.count!;
      List<SelectiveServiceModel> selectiveAsList = <SelectiveServiceModel>[];
      selectiveAsList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (selectiveServices.length < selectiveCount) {
          selectiveServices.addAll(selectiveAsList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        selectiveServices = selectiveAsList;
      }
      emit(GetAllSelectiveServicesSuccessfully(
          model: List<SelectiveServiceModel>.from(selectiveServices),
          offset: selectiveOffset,
          count: selectiveCount));
    } else if (response is BaseError) {
      if (selectiveOffset > 0) selectiveOffset = 0;
      emit(GetAllSelectiveServicesError(message: response.message));
    } else if (response is Message) {
      emit(GetAllSelectiveServicesError(message: response.content));
    }
  }

  Future<void> createShipping(
      CreateShippingRequestModel createShippingRequestModel) async {
    emit(CreateShippingLoading());
    var response = await ShippingRepository.createShippingRequest(
        createShippingRequestModel);
    if (response is CreateShippingResponseModel) {
      emit(CreateShippingSuccessfully(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(CreateShippingError(message: response.message));
    } else if (response is Message) {
      emit(CreateShippingError(message: response.content));
    }
  }

  Future<void> joinSelectiveService(
      JoinSelectiveServiceRequestModel joinSelectiveServiceRequestModel) async {
    emit(JoinSelectiveServiceLoading());
    var response = await ShippingRepository.joinSelectiveService(
        joinSelectiveServiceRequestModel);
    if (response is EmptyModel) {
      emit(JoinSelectiveServiceSuccessfully(
          message:
              'Request submitted successfully.'));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(JoinSelectiveServiceError(message: response.message));
    } else if (response is Message) {
      emit(JoinSelectiveServiceError(message: response.content));
    }
  }

  Future<void> editShipping(
      EditShippingRequestModel editShippingRequestModel) async {
    emit(EditShippingLoading());
    var response =
        await ShippingRepository.editShippingRequest(editShippingRequestModel);
    if (response is CreateShippingResponseModel) {
      emit(EditShippingSuccessfully(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(EditShippingError(message: response.message));
    } else if (response is Message) {
      emit(EditShippingError(message: response.content));
    }
  }

  Future<void> pushShipping(int id) async {
    emit(PushShippingLoading());
    var response = await ShippingRepository.pushShippingRequest(id);
    if (response is ShippingResponseModel) {
      emit(PushShippingSuccessfully(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(PushShippingError(message: response.message));
    } else if (response is Message) {
      emit(PushShippingError(message: response.content));
    }
  }

  Future<void> removeShipping(int id) async {
    emit(RemoveShippingLoading());
    var response = await ShippingRepository.removeShipping(id);
    if (response is EmptyModel) {
      emit(RemoveShippingSuccessfully(
          message: 'Your Shipment is canceled successfully'));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(RemoveShippingError(message: response.message));
    } else if (response is Message) {
      emit(RemoveShippingError(message: response.content));
    }
  }

  Future<void> getShippingDetails(int id) async {
    emit(GetShippingLoading());
    var response = await ShippingRepository.getShippingDetails(id);
    if (response is ShippingResponseModel) {
      emit(GetShippingSuccessfully(responseModel: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(GetShippingError(message: response.message));
    } else if (response is Message) {
      emit(GetShippingError(message: response.content));
    }
  }
}
