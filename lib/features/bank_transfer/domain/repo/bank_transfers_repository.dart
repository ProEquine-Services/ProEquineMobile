import 'package:proequine/core/CoreModels/empty_model.dart';
import 'package:proequine/features/bank_transfer/data/all_bank_transfers_response_model.dart';
import 'package:proequine/features/bank_transfer/data/create_bank_transfer_request_model.dart';
import 'package:proequine/features/bank_transfer/data/create_bank_transfer_response_model.dart';
import 'package:proequine/features/bank_transfer/data/get_bank-account_response_model.dart';
import 'package:proequine/features/bank_transfer/data/save_bank_account_request_model.dart';
import 'package:proequine/features/bank_transfer/data/save_bank_account_response_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../../manage_account/data/upload_file_response_model.dart';

class BankTransferRepository {
  static Future<BaseResultModel?> getAllBankTransfers(
      {required int limit, required int offset}) async {
    return await RemoteDataSource.request<GetAllBankTransfersResponseModel>(
        converter: (json) => GetAllBankTransfersResponseModel.fromJson(json),
        method: HttpMethod.GET,
        queryParameters: {
          "limit": limit,
          "offset": offset,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.bankTransfers);
  }

  static Future<BaseResultModel?> createBankTransfer(
      CreateBankTransferRequestModel createBankTransferRequestModel) async {
    return await RemoteDataSource.request<CreateBankTransferResponseModel>(
        converter: (json) => CreateBankTransferResponseModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: createBankTransferRequestModel.toJson(),
        thereDeviceId: false,
        url: ApiURLs.bankTransfers);
  }

  static Future<BaseResultModel?> pushTransfer(
      int id) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: {
          "id":id
        },
        thereDeviceId: false,
        url: ApiURLs.pushTransfer);
  }

  static Future<BaseResultModel?> saveBankAccount(
      SaveBankAccountRequestModel saveBankAccountRequestModel) async {
    return await RemoteDataSource.request<SaveBankAccountResponseModel>(
        converter: (json) => SaveBankAccountResponseModel.fromJson(json),
        method: HttpMethod.POST,
        withAuthentication: true,
        data: saveBankAccountRequestModel.toJson(),
        thereDeviceId: false,
        url: ApiURLs.saveBankAccount);
  }

  static Future<BaseResultModel?> getBankAccount(
       ) async {
    return await RemoteDataSource.request<GetBankAccountResponseModel>(
        converter: (json) => GetBankAccountResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getWallet);
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
}
