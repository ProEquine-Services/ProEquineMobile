import 'package:proequine_dev/core/CoreModels/base_result_model.dart';

class RefreshTokenResponse extends BaseResultModel {
  String? accessToken;
  RefreshToken? refreshToken;

  RefreshTokenResponse(
      {
        this.accessToken,
        this.refreshToken});

  RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'] != null
        ? RefreshToken.fromJson(json['refreshToken'])
        : null;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    if (refreshToken != null) {
      data['refreshToken'] = refreshToken!.toJson();
    }
    return data;
  }
}

class RefreshToken {
  int? id;
  String? userId;
  String? token;
  String? expires;
  bool? isExpired;
  bool? isActive;

  RefreshToken(
      {this.id,
        this.userId,
        this.token,
        this.expires,
        this.isExpired,
        this.isActive});

  RefreshToken.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    token = json['token'];
    expires = json['expires'];
    isExpired = json['isExpired'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['token'] = token;
    data['expires'] = expires;
    data['isExpired'] = isExpired;
    data['isActive'] = isActive;
    return data;
  }
}