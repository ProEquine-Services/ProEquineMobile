
import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/CoreModels/pagination_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';

class EventsRepository{
  static Future<BaseResultModel?> getALlEvents(Pagination pagination) async {
    return await RemoteDataSource.request<Pagination>(
        converter: (json) => Pagination.fromJson(json),
        method: HttpMethod.GET,
        queryParameters: {
          "PageSize": pagination.pageSize,
          "PageNumber": pagination.pageNumber,
        },
        withAuthentication: true,
        url: ApiURLs.allEvents);
  }
}
