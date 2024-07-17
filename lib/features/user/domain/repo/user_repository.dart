import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/features/user/data/check_mail_request_model.dart';
import 'package:proequine/features/user/data/check_verification_request_model.dart';
import 'package:proequine/features/user/data/interests_request_model.dart';
import 'package:proequine/features/user/data/login_request_model.dart';
import 'package:proequine/features/user/data/register_request_model.dart';
import 'package:proequine/features/user/data/register_response_model.dart';
import 'package:proequine/features/user/data/reset_password_request_model.dart';
import 'package:proequine/features/user/data/send_verify_request_forgot_password.dart';
import 'package:proequine/features/user/data/update_email_request_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';

class UserRepository {
  static Future<BaseResultModel?> login(
      LoginRequestModel loginRequestModel) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: loginRequestModel.toJson(),
        withAuthentication: false,
        thereDeviceId: true,
        url: ApiURLs.loginUSER);
  }

  static Future<BaseResultModel?> register(
      RegisterRequestModel registerRequestModel) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: registerRequestModel.toJson(),
        withAuthentication: false,
        thereDeviceId: true,
        url: ApiURLs.registerUSER);
  }

  static Future<BaseResultModel?> sendVerification() async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.sendVerificationCode);
  }

  static Future<BaseResultModel?> sendVerificationCodeForgotPassword(
      SendForgotPasswordVerifyRequestModel
          sendForgotPasswordVerifyRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: sendForgotPasswordVerifyRequestModel.toJson(),
        withAuthentication: false,
        thereDeviceId: false,
        url: ApiURLs.forgotPassword);
  }

  static Future<BaseResultModel?> checkUsername(String username) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: {
          'userName': username,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updateUserName);
  }

  static Future<BaseResultModel?> checkVerification(
      CheckVerificationCodeRequestModel checkVerificationRequestModel) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: checkVerificationRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.checkVerificationCode);
  }

  // static Future<BaseResultModel?> forgotPassword(
  //     SendMailVerificationRequestModel sendVerificationRequestModel) async {
  //   return await RemoteDataSource.request<EmptyModel>(
  //       converter: (json) => EmptyModel.fromJson(json),
  //       method: HttpMethod.POST,
  //       queryParameters: sendVerificationRequestModel.toJson(),
  //       withAuthentication: false,
  //       thereDeviceId: false,
  //       url: ApiURLs.sendVerificationEmail);
  // }

  static Future<BaseResultModel?> resetPassword(
      ResetPasswordRequestModel resetPasswordRequestModel) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: resetPasswordRequestModel.toJson(),
        withAuthentication: false,
        thereDeviceId: false,
        url: ApiURLs.resetPassword);
  }

  static Future<BaseResultModel?> interests(
      InterestsRequestModel interestsRequestModel) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: interestsRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.interests);
  }

  static Future<BaseResultModel?> sendMailVerification() async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.sendVerificationEmail);
  }

  static Future<BaseResultModel?> sendCodeForUpdateEmail(String email) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: {
          "email": email,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.sendUpdateVerificationEmail);
  }

  static Future<BaseResultModel?> checkMailVerification(
      CheckMailVerificationRequestModel
          checkMailVerificationRequestModel) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: checkMailVerificationRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.checkVerificationEmail);
  }

  static Future<BaseResultModel?> updateMail(
      UpdateMailRequestModel updateMailRequestModel) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        policy: CachePolicy.refreshForceCache,
        data: updateMailRequestModel.toJson(),
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.updateMail);
  }

  static Future<BaseResultModel?> checkUpdateMail(
      String otpCode) async {
    return await RemoteDataSource.request<RegisterResponseModel>(
        converter: (json) => RegisterResponseModel.fromJson(json),
        method: HttpMethod.POST,
        data: {
          'otpCode':otpCode,
        },
        withAuthentication: true,
        // policy: CachePolicy.refreshForceCache,
        thereDeviceId: false,
        url: ApiURLs.checkUpdateMail);
  }
}
