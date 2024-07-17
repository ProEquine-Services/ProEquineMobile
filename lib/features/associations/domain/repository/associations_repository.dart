import 'package:proequine/features/horses/data/add_horse_document_request_model.dart';
import 'package:proequine/features/horses/data/edit_document_request_model.dart';
import 'package:proequine/features/horses/data/update_condition_request_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/CoreModels/empty_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../../manage_account/data/upload_file_response_model.dart';
import '../../data/associate_horse_request_model.dart';
import '../../data/horse_associated_requests_response_model.dart';

class AssociationRepository {



  static Future<BaseResultModel?> getInvitesAssociations(String? status) async {
    return await RemoteDataSource.request<GetHorseRequestResponseModel>(
        converter: (json) => GetHorseRequestResponseModel.fromJson(json),
        method: HttpMethod.GET,
        queryParameters: {
          "status":status,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.invitesAssociations);
  }
  static Future<BaseResultModel?> getRequestsAssociations(int horseId) async {
    return await RemoteDataSource.request<GetHorseRequestResponseModel>(
        converter: (json) => GetHorseRequestResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        thereDeviceId: false,
        url:'${ ApiURLs.requestAssociations}/$horseId');
  }

  static Future<BaseResultModel?> createHorseAssociation(
      AssociateHorseRequestModel associateHorseRequestModel) async {
    return await RemoteDataSource.request<GetHorseRequestResponseModel>(
        converter: (json) => GetHorseRequestResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: associateHorseRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.horseAssociation);
  }
  static Future<BaseResultModel?> cancelHorseAssociation(
      int associationId) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        withAuthentication: true,
        thereDeviceId: false,
        url: '${ApiURLs.horseAssociation}/$associationId');
  }

  static Future<BaseResultModel?> approveHorseAssociation(
      int associationId) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        thereDeviceId: false,
        url: '${ApiURLs.horseAssociationApprove}/$associationId');
  }
  static Future<BaseResultModel?> rejectHorseAssociation(
      int associationId) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        thereDeviceId: false,
        url: '${ApiURLs.horseAssociationReject}/$associationId');
  }
}
