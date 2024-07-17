import 'package:proequine/core/CoreModels/base_result_model.dart';

class EnvResponseModel extends BaseResultModel {
  int? id;
  String? buildNumber;
  String? environmentURL;

  EnvResponseModel({this.id, this.buildNumber, this.environmentURL});

  EnvResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    buildNumber = json['buildNumber'];
    environmentURL = json['environmentURL'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['buildNumber'] = buildNumber;
    data['environmentURL'] = environmentURL;
    return data;
  }
}