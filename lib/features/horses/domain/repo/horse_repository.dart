import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/CoreModels/empty_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../../manage_account/data/upload_file_response_model.dart';
import '../../data/accepted_invites_response_model.dart';
import '../../data/add_horse_document_request_model.dart';
import '../../data/add_horse_request_model.dart';
import '../../data/edit_document_request_model.dart';
import '../../data/get_horses_documents_response_model.dart';
import '../../data/get_user_horses_response_model.dart';
import '../../data/horse_response_model.dart';
import '../../data/horse_verify_response_model.dart';
import '../../data/update_condition_request_model.dart';
import '../../data/update_horse_request_model.dart';
import '../../data/user_and_associated_horses_response_model.dart';
import '../../data/verify_horse_request_model.dart';

class HorseRepository {
  static Future<BaseResultModel?> addHorse(
      AddHorseRequestModel addHorseRequestModel) async {
    return await RemoteDataSource.request<HorseResponseModel>(
        converter: (json) => HorseResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: addHorseRequestModel.toJson(),
        // policy: CachePolicy.refreshForceCache,
        // refreshDuration: const Duration(microseconds: 1),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addHorse);
  }

  static Future<BaseResultModel?> getHorses(
      {required int limit, required int offset}) async {
    return await RemoteDataSource.request<HorsesResponseModel>(
        converter: (json) => HorsesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        // policy: CachePolicy.forceCache,
        // refreshDuration: const Duration(seconds: 5),
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getHorses);
  }
  static Future<BaseResultModel?> getUserHorses(
      {required int limit, required int offset, String? fullName}) async {
    return await RemoteDataSource.request<HorsesResponseModel>(
        converter: (json) => HorsesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        policy: CachePolicy.request,
        refreshDuration: const Duration(seconds: 5),
        queryParameters: {
          'limit': limit,
          'offset': offset,
          'name':fullName,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getUserHorses);
  }
  static Future<BaseResultModel?> getAcceptedHorses(
      {required int limit, required int offset}) async {
    return await RemoteDataSource.request<AcceptedInvitesResponseModel>(
        converter: (json) => AcceptedInvitesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        // policy: CachePolicy.forceCache,
        // refreshDuration: const Duration(seconds: 5),
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getAcceptedHorses);
  }

  static Future<BaseResultModel?> getDocuments(
      {required int limit, required int offset, required int horseId}) async {
    return await RemoteDataSource.request<AllHorseDocumentsResponseModel>(
        converter: (json) => AllHorseDocumentsResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
        thereDeviceId: false,
        url: '${ApiURLs.allDocuments}/$horseId');
  }

  static Future<BaseResultModel?> getUserAndAssociatedHorses(
      {required int limit, required int offset, String? name}) async {
    return await RemoteDataSource.request<UserAndAssociatedHorsesResponseModel>(
        converter: (json) => UserAndAssociatedHorsesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {
          'limit': limit,
          'offset': offset,
          'name': name,
        },
        thereDeviceId: false,
        url: ApiURLs.horsesWithAssociated);
  }

  static Future<BaseResultModel?> updateHorse(
      UpdateHorseRequestModel updateHorseRequestModel) async {
    return await RemoteDataSource.request<HorseResponseModel>(
        converter: (json) => HorseResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: updateHorseRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addHorse);
  }

  static Future<BaseResultModel?> verifyHorse(
      {required HorseVerificationRequestModel
          horseVerificationRequestModel}) async {
    return await RemoteDataSource.request<HorseVerificationResponseModel>(
        converter: (json) => HorseVerificationResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: horseVerificationRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.verifyHorse);
  }

  static Future<BaseResultModel?> updateHorseCondition(
      UpdateHorseConditionRequestModel updateHorseConditionRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.PUT,
        data: updateHorseConditionRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updateHorseCondition);
  }

  static Future<BaseResultModel?> uploadFile(String? file) async {
    return await RemoteDataSource.request<UploadFileResponseModel>(
        converter: (json) => UploadFileResponseModel.fromJson(json),
        method: HttpMethod.POST,
        files: {
          "file": file!,
        },
        withAuthentication: true,
        isLongTime: true,
        thereDeviceId: false,
        url: ApiURLs.uploadFile);
  }

  static Future<BaseResultModel?> removeHorse(int horseId) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        withAuthentication: true,
        thereDeviceId: false,
        url: '${ApiURLs.removeHorse}/$horseId');
  }

  static Future<BaseResultModel?> addHorseDocument(
      CreateHorseDocumentsRequestModel createHorseDocumentsRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: createHorseDocumentsRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addHorseDocument);
  }

  static Future<BaseResultModel?> editHorseDocument(
      EditHorseDocumentsRequestModel editHorseDocumentRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: editHorseDocumentRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.editHorseDocument);
  }

  static Future<BaseResultModel?> removeHorseDocument(int docId) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.DELETE,
        withAuthentication: true,
        thereDeviceId: false,
        url: '${ApiURLs.removeHorseDocument}/$docId');
  }
}
