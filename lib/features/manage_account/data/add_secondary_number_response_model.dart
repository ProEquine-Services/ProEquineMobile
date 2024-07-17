import 'package:proequine/core/CoreModels/base_result_model.dart';

class AddSecondaryNumberResponseModel extends BaseResultModel{
  String? phoneNumberType;
  String? personPhoneNumber;
  int? personId;

  AddSecondaryNumberResponseModel({this.phoneNumberType, this.personPhoneNumber, this.personId});

  AddSecondaryNumberResponseModel.fromJson(Map<String, dynamic> json) {
    phoneNumberType = json['phoneNumberType'];
    personPhoneNumber = json['personPhoneNumber'];
    personId = json['personId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumberType'] = phoneNumberType;
    data['personPhoneNumber'] = personPhoneNumber;
    data['personId'] = personId;
    return data;
  }
}
