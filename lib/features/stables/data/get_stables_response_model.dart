import 'package:proequine/core/CoreModels/base_result_model.dart';

class AllStablesResponseModel extends BaseResultModel {
  int? count;
  List<Stable>? rows;

  AllStablesResponseModel({this.count, this.rows});

  AllStablesResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Stable>[];
      json['rows'].forEach((v) {
        rows!.add(Stable.fromJson(v));
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

class Stable {
  int? id;
  String? name;
  String? code;
  String? type;
  String? country;
  String? state;
  String? address;
  String? pinLocation;
  String? status;
  bool? showOnApp;

  Stable(
      {this.id,
        this.name,
        this.code,
        this.type,
        this.country,
        this.state,
        this.address,
        this.pinLocation,
        this.status,
        this.showOnApp});

  Stable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    type = json['type'];
    country = json['country'];
    state = json['state'];
    address = json['address'];
    pinLocation = json['pinLocation'];
    status = json['status'];
    showOnApp = json['showOnApp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['type'] = type;
    data['country'] = country;
    data['state'] = state;
    data['address'] = address;
    data['pinLocation'] = pinLocation;
    data['status'] = status;
    data['showOnApp'] = showOnApp;
    return data;
  }
}
