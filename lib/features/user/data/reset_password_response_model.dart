import 'package:proequine/core/CoreModels/base_result_model.dart';

class ResetPasswordResponseModel extends BaseResultModel {
  bool? isEmailVerified;
  bool? isPhoneNumberVerified;
  bool? isTypeSelected;
  String? phoneNumber;
  String? accessToken;
  RefreshToken? refreshToken;
  String? userId;
  bool? isChooseType;
  bool? isChooseMainStable;
  int? personId;

  ResetPasswordResponseModel(
      {this.isEmailVerified,
        this.isPhoneNumberVerified,
        this.isTypeSelected,
        this.phoneNumber,
        this.accessToken,
        this.refreshToken,
        this.userId,
        this.isChooseType,
        this.isChooseMainStable,
        this.personId});

  ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    isEmailVerified = json['isEmailVerified'];
    isPhoneNumberVerified = json['isPhoneNumberVerified'];
    isTypeSelected = json['isTypeSelected'];
    phoneNumber = json['phoneNumber'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'] != null
        ? RefreshToken.fromJson(json['refreshToken'])
        : null;
    userId = json['userId'];
    isChooseType = json['isChooseType'];
    isChooseMainStable = json['isChooseMainStable'];
    personId = json['personId'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isEmailVerified'] = isEmailVerified;
    data['isPhoneNumberVerified'] = isPhoneNumberVerified;
    data['isTypeSelected'] = isTypeSelected;
    data['phoneNumber'] = phoneNumber;
    data['accessToken'] = accessToken;
    if (refreshToken != null) {
      data['refreshToken'] = refreshToken!.toJson();
    }
    data['userId'] = userId;
    data['isChooseType'] = isChooseType;
    data['isChooseMainStable'] = isChooseMainStable;
    data['personId'] = personId;
    return data;
  }
}

class RefreshToken {
  String? userId;
  String? token;
  String? expires;
  bool? isExpired;
  bool? isActive;

  RefreshToken(
      {this.userId, this.token, this.expires, this.isExpired, this.isActive});

  RefreshToken.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    token = json['token'];
    expires = json['expires'];
    isExpired = json['isExpired'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['token'] = token;
    data['expires'] = expires;
    data['isExpired'] = isExpired;
    data['isActive'] = isActive;
    return data;
  }
}