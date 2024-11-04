import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/core/utils/extensions.dart';
import 'package:proequine_dev/features/support/data/create_support_response_model.dart';
import 'package:proequine_dev/features/support/data/get_all_support_request_response_model.dart';
import 'package:proequine_dev/features/support/domain/repo/support_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../data/support_request_model.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  SupportCubit() : super(SupportInitial());
  int? limit = 8;
  List<dynamic> requests = [];
  int count = 0;
  int total = 0;
  int offset = 0;
  late RefreshController refreshController;

  Future<void> contactSupport(
      CreateSupportRequestModel supportRequestModel) async {
    emit(ContactSupportLoading());
    var response = await SupportRepository.contactSupport(supportRequestModel);
    if (response is CreateSupportResponseModel) {
      emit(ContactSupportSuccessful(
          model: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(ContactSupportError(message: response.message));
    } else if (response is Message) {
      emit(ContactSupportError(message: response.content));
    }
  }

  Future<void> getAllRequests(
      {int limit = 8,
      bool loadMore = false,
      bool isRefreshing = false,
      String? fullName}) async {
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
      emit(GetAllSupportLoading());
    }
    var response =
        await SupportRepository.getAllRequests(offset: offset, limit: limit);
    if (response is GetAllSupportRequestResponseModel) {
      Print("Offset is $offset");
      count = response.count!;
      List<SupportRequestModel> supportRequestsAsList = <SupportRequestModel>[];
      supportRequestsAsList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (requests.length < count) {
          requests.addAll(supportRequestsAsList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        requests = supportRequestsAsList;
      }
      emit(GetAllSupportSuccessful(
          responseModel: List<SupportRequestModel>.from(requests),
          offset: offset,
          count: count));
    } else if (response is BaseError) {
      if (offset > 0) offset = 0;
      emit(GetAllSupportError(message: response.message));
    } else if (response is Message) {
      emit(GetAllSupportError(message: response.content));
    }
  }
}
