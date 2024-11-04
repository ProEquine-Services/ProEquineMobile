import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine_dev/features/stables/domain/repo/stable_repository.dart';
import 'package:proequine_dev/features/user/data/register_response_model.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../../../core/utils/sharedpreferences/SharedPreferencesHelper.dart';
import '../data/chose_stable_request_model.dart';
import '../data/get_stables_response_model.dart';

part 'stable_state.dart';

class StableCubit extends Cubit<StableState> {
  StableCubit() : super(StableInitial());

  int? limit = 8;
  List<dynamic> stables = [];
  int count = 0;
  int total = 0;
  int offset = 0;
  late RefreshController refreshController;


  Future<void> getAllStables({
    int limit = 8,

    bool loadMore = false,
    bool isRefreshing = false,
    String? fullName
  }) async {
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
      emit(GetAllStablesLoading());
    }
    var response = await StableRepository.getAllStables(offset:offset, limit:limit,fullName: fullName);
    if (response is AllStablesResponseModel) {
      Print("Offset is $offset");
      count = response.count!;
      List<Stable> stablesAsList = <Stable>[];
      stablesAsList = response.rows!;

      if (loadMore) {
        Print("Load More Now");
        if (stables.length < count) {
          stables.addAll(stablesAsList);
          Print("Case 1");
        } else {
          Print("Case 2");
          return;
        }
      } else {
        stables = stablesAsList;
      }
      emit(GetAllStablesSuccessfully(
          stables: List<Stable>.from(stables),
          offset: offset,
          count: count));
    } else if (response is BaseError) {
      if (offset > 0) offset = 0;
      emit(GetAllStablesError(message: response.message));
    } else if (response is Message) {
      emit(GetAllStablesError(message: response.content));
    }
  }

  Future<void> choseStable(ChoseMainStableRequestModel choseMainStableRequestModel) async {
    emit(ChoseStableLoading());
    var response = await StableRepository.choseStable(choseMainStableRequestModel);
    if (response is RegisterResponseModel) {
      AppSharedPreferences.phoneVerified = response.verifiedPhoneNumber;
      AppSharedPreferences.inputName = response.firstName!;
      AppSharedPreferences.emailVerified = response.verifiedEmail;
      AppSharedPreferences.choseStable = response.steps!.isAddMainStable!;
      AppSharedPreferences.typeSelected = response.steps!.isAddRole!;
      AppSharedPreferences.inputPhoneNumber = response.phoneNumber!;
      AppSharedPreferences.inputEmailAddress = response.email!;
      AppSharedPreferences.hasUserAccountName = response.steps!.isAddUserName!;
      emit(ChoseStableSuccessful(
          message: "Your main stable is selected successfully. "));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(ChoseStableError(message: response.message));
    } else if (response is Message) {
      emit(ChoseStableError(message: response.content));
    }
  }
}
