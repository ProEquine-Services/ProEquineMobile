import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/core/errors/base_error.dart';
import 'package:proequine/features/equine_info/data/add_new_stable_request_model.dart';
import 'package:proequine/features/equine_info/data/add_new_stable_response_model.dart';
import 'package:proequine/features/equine_info/data/add_seccondary_stable_model.dart';
import 'package:proequine/features/equine_info/data/add_secondary_discipline_request_model.dart';
import 'package:proequine/features/equine_info/data/get_user_disciplines_response_model.dart';
import 'package:proequine/features/equine_info/data/get_user_roles_response_model.dart';
import 'package:proequine/features/equine_info/data/get_user_stables_response_model.dart';
import 'package:proequine/features/equine_info/data/update_main_discipline_request_model.dart';
import 'package:proequine/features/equine_info/data/update_main_stable_request_model.dart';
import 'package:proequine/features/equine_info/data/update_secondary_discipline_request_model.dart';
import 'package:proequine/features/equine_info/domain/equine_info_repository/equine_info_repository.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../data/add_secondary_interests_response_model.dart';
import '../data/delete_discipline_request_model.dart';

part 'equine_info_state.dart';

class EquineInfoCubit extends Cubit<EquineInfoState> {
  EquineInfoCubit() : super(EquineInfoInitial());

  Future<void> getUserDiscipline(int userId) async {
    emit(GetUserDisciplineLoading());
    var response = await EquineInfoRepository.getUserDiscipline(userId);

    if (response is GetUserInterestsResponseModel) {
      emit(GetUserDisciplineSuccessful(model: response));
    } else if (response is BaseError) {
      emit(GetUserDisciplineError(message: response.message));
    } else if (response is Message) {
      emit(GetUserDisciplineError(message: response.content));
    }
  }

  Future<void> getUserStables(int userId) async {
    emit(GetUserStablesLoading());
    var response = await EquineInfoRepository.getUserStables(userId);

    if (response is GetUserStablesResponseModel) {
      emit(GetUserStablesSuccessful(model: response));
    } else if (response is BaseError) {
      emit(GetUserStablesError(message: response.message));
    } else if (response is Message) {
      emit(GetUserStablesError(message: response.content));
    }
  }
  Future<void> addSecondaryDiscipline(
      AddSecondaryDisciplineRequestModel
          addSecondaryDisciplineRequestModel) async {
    emit(AddSecondaryDisciplineLoading());
    var response = await EquineInfoRepository.addSecondaryDiscipline(
        addSecondaryDisciplineRequestModel);

    if (response is AddSecondaryInterestResponseModel) {
      emit(AddSecondaryDisciplineSuccessful(
          message: "Discipline Added Successfully"));
    } else if (response is BaseError) {
      emit(AddSecondaryDisciplineError(message: response.message));
    } else if (response is Message) {
      emit(AddSecondaryDisciplineError(message: response.content));
    }
  }
  // this one for stables already exist in public stables
  Future<void> addSecondaryStable(
      AddSecondaryStableModel addSecondaryStableModel) async {
    emit(AddSecondaryStableLoading());
    var response = await EquineInfoRepository.addSecondaryStable(
        addSecondaryStableModel);

    if (response is EmptyModel) {
      emit(AddSecondaryStableSuccessful(
          message: "Stable Added Successfully"));
    } else if (response is BaseError) {
      emit(AddSecondaryStableError(message: response.message));
    } else if (response is Message) {
      emit(AddSecondaryStableError(message: response.content));
    }
  }

  // this one for the stables which doesn't exist in the public
  Future<void> addNewStable(
      AddNewStablesRequestModel addNewStablesRequestModel) async {
    emit(AddNewStableLoading());
    var response = await EquineInfoRepository.addNewStable(
        addNewStablesRequestModel);

    if (response is AddNewStablesResponseModel) {
      emit(AddNewStableSuccessful(
          message: "Stable Added Successfully"));
    } else if (response is BaseError) {
      emit(AddNewStableError(message: response.message));
    } else if (response is Message) {
      emit(AddNewStableError(message: response.content));
    }
  }
  Future<void> updateSecondaryDiscipline(
      UpdateSecondaryDisciplineRequestModel
          updateSecondaryDisciplineRequestModel) async {
    emit(UpdateSecondaryDisciplineLoading());
    var response = await EquineInfoRepository.updateSecondaryDiscipline(
        updateSecondaryDisciplineRequestModel);

    if (response is EmptyModel) {
      emit(UpdateSecondaryDisciplineSuccessful(
          message: "Discipline Updated Successfully"));
    } else if (response is BaseError) {
      emit(UpdateSecondaryDisciplineError(message: response.message));
    } else if (response is Message) {
      emit(UpdateSecondaryDisciplineError(message: response.content));
    }
  }

  Future<void> deleteSecondaryDiscipline(
      int interestId ) async {
    emit(DeleteSecondaryDisciplineLoading());
    var response = await EquineInfoRepository.deleteDiscipline(
        interestId);

    if (response is EmptyModel) {
      emit(DeleteSecondaryDisciplineSuccessful(
          message: "Discipline Deleted Successfully"));
    } else if (response is BaseError) {
      emit(DeleteSecondaryDisciplineError(message: response.message));
    } else if (response is Message) {
      emit(DeleteSecondaryDisciplineError(message: response.content));
    }
  }
  Future<void> deleteSecondaryStable(int id) async {
    emit(DeleteSecondaryStableLoading());
    var response = await EquineInfoRepository.deleteSecondaryStable(id);

    if (response is EmptyModel) {
      emit(DeleteSecondaryStableSuccessful(
          message: "Stable deleted successfully."));
    } else if (response is BaseError) {
      emit(DeleteSecondaryStableError(message: response.message));
    } else if (response is Message) {
      emit(DeleteSecondaryStableError(message: response.content));
    }
  }
}
