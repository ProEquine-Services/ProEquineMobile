import 'package:proequine/core/CoreModels/base_result_model.dart';
import 'create_transport_response_model.dart';

class GetUserTransportsResponseModel extends BaseResultModel{
  int? count;
  List<TransportModel>? rows;

  GetUserTransportsResponseModel({this.count, this.rows});

  GetUserTransportsResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <TransportModel>[];
      json['rows'].forEach((v) {
        rows!.add(TransportModel.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}