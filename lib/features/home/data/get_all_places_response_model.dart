
import '../../../core/CoreModels/base_result_model.dart';

class AllPlacesResponseModel extends BaseResultModel {
  int? count;
  List<Place>? rows;

  AllPlacesResponseModel({this.count, this.rows});

  AllPlacesResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Place>[];
      json['rows'].forEach((v) {
        rows!.add(Place.fromJson(v));
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

class Place {
  int? id;
  String? name;
  String? lng;
  String? lat;
  String? code;

  Place({this.id, this.name, this.lng, this.lat,this.code});

  Place.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lng = json['lng'];
    lat = json['lat'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lng'] = lng;
    data['lat'] = lat;
    data['code'] = code;
    return data;
  }
}