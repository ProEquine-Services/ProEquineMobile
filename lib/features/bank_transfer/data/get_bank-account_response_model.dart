import 'package:proequine/core/CoreModels/base_result_model.dart';

import '../../equine_info/data/add_secondary_interests_response_model.dart';

class GetBankAccountResponseModel extends BaseResultModel{
  int? id;
  num? totalAmount;
  num? blockedAmount;
  num? availableAmount;
  int? userId;
  String? bankName;
  String? accountNumber;
  String? iBAN;
  String? swiftCode;
  String? accountHolderName;

  GetBankAccountResponseModel(
      {this.id,
        this.totalAmount,
        this.blockedAmount,
        this.availableAmount,
        this.userId,
        this.bankName,
        this.accountNumber,
        this.iBAN,
        this.swiftCode,
        this.accountHolderName});

  GetBankAccountResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['totalAmount'];
    blockedAmount = json['blockedAmount'];
    availableAmount = json['availableAmount'];
    userId = json['userId'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    iBAN = json['IBAN'];
    swiftCode = json['swiftCode'];
    accountHolderName = json['accountHolderName'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['totalAmount'] = this.totalAmount;
    data['blockedAmount'] = this.blockedAmount;
    data['availableAmount'] = this.availableAmount;
    data['userId'] = this.userId;
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['IBAN'] = this.iBAN;
    data['swiftCode'] = this.swiftCode;
    data['accountHolderName'] = this.accountHolderName;
    return data;
  }
}