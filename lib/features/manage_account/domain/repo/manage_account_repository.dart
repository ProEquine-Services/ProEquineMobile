import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/CoreModels/empty_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../../user/data/register_response_model.dart';
import '../../data/add_address_request_model.dart';
import '../../data/add_bio_request_model.dart';
import '../../data/add_secondary_number_request_model.dart';
import '../../data/add_secondary_number_response_model.dart';
import '../../data/change_password_request_model.dart';
import '../../data/configuration_response_model.dart';
import '../../data/confirm_change_phone_number_response_model.dart';
import '../../data/edit_phone_request_model.dart';
import '../../data/update_main_number_request_model.dart';
import '../../data/update_secondary_number_request_model.dart';
import '../../data/upload_file_response_model.dart';
import '../../data/user_data_response_model.dart';
import '../../data/user_info_request_model.dart';

class ManageAccountRepository {
  static Future<BaseResultModel?> changePassword(
      ChangePasswordRequestModel updatePasswordRequestModel) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: updatePasswordRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.changePassword);
  }
  static Future<BaseResultModel?> addBio(
      AddBioRequestModel addBioRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: addBioRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addBio);
  }
  static Future<BaseResultModel?> uploadFile(String? file) async {
    return await RemoteDataSource.request<UploadFileResponseModel>(
        converter: (json) => UploadFileResponseModel.fromJson(json),
        method: HttpMethod.POST,
        files: {
          "file":file!,

        },
        withAuthentication: true,
        isLongTime: true,
        thereDeviceId: false,
        url: ApiURLs.uploadFile);
  }
  static Future<BaseResultModel?> updateUserImage(
      String image) async {
    return await RemoteDataSource.request<UserDataResponseModel>(
        converter: (json) => UserDataResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data:{
          "image": image,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updateImage);
  }
  static Future<BaseResultModel?> sendPhoneNumber(
      EditPhoneRequestModel editPhoneRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: editPhoneRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.sendPhone);
  }
  static Future<BaseResultModel?> updatePhoneNumber(
      UpdateMainNumberRequestModel updatePhoneRequestModel) async {
    return await RemoteDataSource.request<ConfirmChangePhoneNumberResponseModel>(
        converter: (json) => ConfirmChangePhoneNumberResponseModel.fromJson(json),
        method: HttpMethod.POST,
        // policy: CachePolicy.refresh,
        data: updatePhoneRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updatePhone);
  }
  static Future<BaseResultModel?> updateSecondaryPhoneNumber(
      UpdateSecondaryNumberRequestModel updateSecondaryNumberRequestModel) async {
    return await RemoteDataSource.request<UserDataResponseModel>(
        converter: (json) => UserDataResponseModel.fromJson(json),
        method: HttpMethod.POST,
        // policy: CachePolicy.refresh,
        data: updateSecondaryNumberRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updateSecondaryPhone);
  }

  static Future<BaseResultModel?> addAddress(
      AddAddressRequestModel addAddressRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: addAddressRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addAddress);
  }

  static Future<BaseResultModel?> addSecondaryNumber(
      AddSecondaryNumberRequestModel addSecondaryNumberRequestModel) async {
    return await RemoteDataSource.request<AddSecondaryNumberResponseModel>(
        converter: (json) => AddSecondaryNumberResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: addSecondaryNumberRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.addSecondaryNumber);
  }
  static Future<BaseResultModel?> getUserData() async {
    return await RemoteDataSource.request<UserDataResponseModel>(
        converter: (json) => UserDataResponseModel.fromJson(json),
        method: HttpMethod.GET,
        policy: CachePolicy.request,
        refreshDuration: const Duration(milliseconds: 1),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getUserData);
  }


  static Future<BaseResultModel?> getConfiguration() async {
    return await RemoteDataSource.request<ConfigurationResponseModel>(
        converter: (json) => ConfigurationResponseModel.fromJson(json),
        method: HttpMethod.GET,
        policy: CachePolicy.request,
        refreshDuration: const Duration(days: 1),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.configurations);
  }
  static Future<BaseResultModel?> updateUserInfo(UserInfoRequestModel userInfoRequestModel) async {
    return await RemoteDataSource.request<UserDataResponseModel>(
        converter: (json) => UserDataResponseModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: userInfoRequestModel.toJson(),
        thereDeviceId: true,
        url: ApiURLs.updateUserInfo);
  }
}