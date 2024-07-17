import 'dart:convert';

import 'package:proequine/core/CoreModels/base_result_model.dart';

import '../../equine_info/data/add_secondary_interests_response_model.dart';

class UserPlacesResponseModel extends BaseResultModel {
  int? count;
  List<UserPlace>? rows;

  UserPlacesResponseModel({
    this.count,
    this.rows,
  });

  factory UserPlacesResponseModel.fromRawJson(String str) =>
      UserPlacesResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserPlacesResponseModel.fromJson(Map<String, dynamic> json) =>
      UserPlacesResponseModel(
        count: json["count"],
        rows: json["rows"] == null
            ? []
            : List<UserPlace>.from(
                json["rows"]!.map((x) => UserPlace.fromJson(x))),
      );

  @override
  Map<String, dynamic> toJson() => {
        "count": count,
        "rows": rows == null
            ? []
            : List<dynamic>.from(rows!.map((x) => x.toJson())),
      };
}

class UserPlace {
  int? id;
  String? name;
  String? desc;
  String? code;
  String? lng;
  String? lat;
  String? category;
  int? createdBy;
  User? user;
  String? status;

  UserPlace({
    this.id,
    this.name,
    this.desc,
    this.code,
    this.lng,
    this.lat,
    this.category,
    this.createdBy,
    this.user,
    this.status,
  });

  factory UserPlace.fromRawJson(String str) =>
      UserPlace.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserPlace.fromJson(Map<String, dynamic> json) => UserPlace(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
        code: json["code"],
        lng: json["lng"],
        lat: json["lat"],
        category: json["category"],
        createdBy: json["createdBy"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "code": code,
        "lng": lng,
        "lat": lat,
        "category": category,
        "createdBy": createdBy,
        "user": user?.toJson(),
        "status": status,
      };
}
