
import '../../../core/CoreModels/base_result_model.dart';

class UploadFileResponseModel extends BaseResultModel{
  String? url;

  UploadFileResponseModel({this.url});

  UploadFileResponseModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}