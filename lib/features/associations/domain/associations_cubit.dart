import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/core/utils/extensions.dart';
import 'package:proequine/features/associations/data/associate_horse_request_model.dart';
import 'package:proequine/features/associations/domain/repository/associations_repository.dart';

import '../../../core/CoreModels/base_response_model.dart';
import '../../../core/errors/base_error.dart';
import '../../../core/utils/Printer.dart';
import '../data/horse_associated_requests_response_model.dart';

part 'associations_state.dart';

class AssociationsCubit extends Cubit<AssociationsState> {
  AssociationsCubit() : super(AssociationsInitial());

  Future<void> getInvitesAssociations(String? status) async {
    emit(GetInviteAssociationsLoading());
    var response = await AssociationRepository.getInvitesAssociations(status);
    if (response is GetHorseRequestResponseModel) {
      emit(GetInviteAssociationsSuccessfully(invites: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(GetInviteAssociationsError(message: response.message));
    } else if (response is Message) {
      emit(GetInviteAssociationsError(message: response.content));
    }
  }

  Future<void> getRequestsAssociations(int horseId) async {
    emit(GetRequestsAssociationsLoading());
    var response = await AssociationRepository.getRequestsAssociations(horseId);
    if (response is GetHorseRequestResponseModel) {
      emit(GetRequestsAssociationsSuccessfully(model: response));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(GetRequestsAssociationsError(message: response.message));
    } else if (response is Message) {
      emit(GetRequestsAssociationsError(message: response.content));
    }
  }

  Future<void> createHorseAssociation(
      AssociateHorseRequestModel associateHorseRequestModel) async {
    emit(AssociateHorseLoading());
    var response = await AssociationRepository.createHorseAssociation(
        associateHorseRequestModel);
    if (response is GetHorseRequestResponseModel) {
      emit(AssociateHorseSuccessfully(
          message: "Request submitted successfully.".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(AssociateHorseError(message: response.message));
    } else if (response is Message) {
      emit(AssociateHorseError(message: response.content));
    }
  }
  Future<void> cancelHorseAssociation(
      int id) async {
    emit(CancelAssociateHorseLoading());
    var response = await AssociationRepository.cancelHorseAssociation(
        id);
    if (response is EmptyModel) {
      emit(CancelAssociateHorseSuccessfully(
          message: "Your request is canceled successfully.".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(CancelAssociateHorseError(message: response.message));
    } else if (response is Message) {
      emit(CancelAssociateHorseError(message: response.content));
    }
  }

  Future<void> approveHorseAssociation(int associationId) async {
    emit(ApproveAssociateHorseLoading());
    var response =
        await AssociationRepository.approveHorseAssociation(associationId);
    if (response is EmptyModel) {
      emit(ApproveAssociateHorseSuccessfully(
          message: "Association is approved successfully.".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(ApproveAssociateHorseError(message: response.message));
    } else if (response is Message) {
      emit(ApproveAssociateHorseError(message: response.content));
    }
  }

  Future<void> rejectHorseAssociation(int associationId) async {
    emit(RejectAssociateHorseLoading());
    var response =
        await AssociationRepository.rejectHorseAssociation(associationId);
    if (response is EmptyModel) {
      emit(RejectAssociateHorseSuccessfully(
          message: "Association is rejected successfully.".tra));
    } else if (response is BaseError) {
      Print("messaggeeeeeeeee${response.message}");
      emit(RejectAssociateHorseError(message: response.message));
    } else if (response is Message) {
      emit(RejectAssociateHorseError(message: response.content));
    }
  }
}
