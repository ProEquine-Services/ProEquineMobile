

import '../../../core/CoreModels/base_result_model.dart';

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['totalAmount'] = totalAmount;
    data['blockedAmount'] = blockedAmount;
    data['availableAmount'] = availableAmount;
    data['userId'] = userId;
    data['bankName'] = bankName;
    data['accountNumber'] = accountNumber;
    data['IBAN'] = iBAN;
    data['swiftCode'] = swiftCode;
    data['accountHolderName'] = accountHolderName;
    return data;
  }
}