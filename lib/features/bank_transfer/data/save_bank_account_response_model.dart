import 'package:proequine/core/CoreModels/base_result_model.dart';

import '../../equine_info/data/add_secondary_interests_response_model.dart';

class SaveBankAccountResponseModel extends BaseResultModel{
  int? id;
  num? totalAmount;
  num? blockedAmount;
  num? availableAmount;
  num? userId;
  User? user;
  String? bankName;
  String? accountNumber;
  String? iBAN;
  String? swiftCode;
  String? accountHolderName;

  SaveBankAccountResponseModel(
      {this.id,
        this.totalAmount,
        this.blockedAmount,
        this.availableAmount,
        this.userId,
        this.user,
        this.bankName,
        this.accountNumber,
        this.iBAN,
        this.swiftCode,
        this.accountHolderName});

  SaveBankAccountResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['totalAmount'];
    blockedAmount = json['blockedAmount'];
    availableAmount = json['availableAmount'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    iBAN = json['IBAN'];
    swiftCode = json['swiftCode'];
    accountHolderName = json['accountHolderName'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['totalAmount'] = totalAmount;
    data['blockedAmount'] = blockedAmount;
    data['availableAmount'] = availableAmount;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['bankName'] = bankName;
    data['accountNumber'] = accountNumber;
    data['IBAN'] = iBAN;
    data['swiftCode'] = swiftCode;
    data['accountHolderName'] = accountHolderName;
    return data;
  }
}