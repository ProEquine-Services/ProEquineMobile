import 'package:proequine_dev/features/notifications/data/notifications_response_model.dart';

import '../../../../core/CoreModels/base_result_model.dart';
import '../../../../core/data_source/remote_data_source.dart';
import '../../../../core/http/api_urls.dart';
import '../../../../core/http/http_method.dart';

class NotificationRepository {
  static Future<BaseResultModel?> getUserNotifications(
      {required int offset, required int limit}) async {
    return await RemoteDataSource.request<NotificationsResponseModel>(
        converter: (json) => NotificationsResponseModel.fromJson(json),
        method: HttpMethod.GET,
        withAuthentication: true,
        queryParameters: {
          "offset": offset,
          "limit": limit,},
        thereDeviceId: false,
        url: ApiURLs.userNotifications);
  }
}