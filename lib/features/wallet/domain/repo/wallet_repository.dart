
import 'package:proequine/features/user/data/login_request_model.dart';
import 'package:proequine/features/user/data/register_response_model.dart';
import 'package:proequine/features/wallet/data/my_account_response_model.dart';
import 'package:proequine/features/wallet/data/payment_details_response_model.dart';
import 'package:proequine/features/wallet/data/transactions_response_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';

class WalletRepository {
  static Future<BaseResultModel?> getWallet() async {
    return await RemoteDataSource.request<MyAccountResponseModel>(
        converter: (json) => MyAccountResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.getWallet);
  }

  static Future<BaseResultModel?> getPaymentDetails(String paymentId) async {
    return await RemoteDataSource.request<PaymentDetailsResponseModel>(
        converter: (json) => PaymentDetailsResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        thereDeviceId: false,
        url: '${ApiURLs.getPaymentDetails}/$paymentId');
  }
  static Future<BaseResultModel?> getAllTransactions(
      {required int offset, required int limit,String? status}) async {
    return await RemoteDataSource.request<TransactionsResponseModel>(
        converter: (json) => TransactionsResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {
          "offset":offset,
          "limit":limit,
          "status":status,
        },
        thereDeviceId: false,
        url: ApiURLs.getTransactions);
  }
}
