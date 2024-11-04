import 'base_model.dart';

class BaseResultModel extends BaseModel {
  BaseResultModel();

  factory BaseResultModel.fromJson(json) => BaseResultModel();

  Map<String, dynamic> toJson() => {'From BaseResultModel': 'You must extends this'};
}
