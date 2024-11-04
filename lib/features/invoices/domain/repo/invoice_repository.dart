
import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/CoreModels/empty_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';
import '../../data/user_invoices_response_model.dart';

class InvoiceRepository{
  static Future<BaseResultModel?> payInvoiceByWallet(
      int id) async {
    return await RemoteDataSource.request<EmptyModel>(
        converter: (json) => EmptyModel.fromJson(json),
        method: HttpMethod.POST,
        data: {
          "id":id
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.payInvoiceByWallet);
  }


  static Future<BaseResultModel?> getAllInvoices({required int limit,required int offset}) async {
    return await RemoteDataSource.request<UserInvoicesResponseModel>(
        converter: (json) => UserInvoicesResponseModel.fromJson(json),
        method: HttpMethod.GET,
        queryParameters: {
          'limit': limit,
          'offset': offset,
        },
        withAuthentication: true,
        thereDeviceId: false,
        url: ApiURLs.userInvoices);
  }
}