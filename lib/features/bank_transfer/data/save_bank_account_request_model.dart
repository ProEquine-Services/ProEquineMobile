class SaveBankAccountRequestModel {
  int? userId;
  String? bankName;
  String? accountNumber;
  String? iBAN;
  String? swiftCode;
  String? accountHolderName;

  SaveBankAccountRequestModel(
      {this.userId,
        this.bankName,
        this.accountNumber,
        this.iBAN,
        this.swiftCode,
        this.accountHolderName});

  SaveBankAccountRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    iBAN = json['IBAN'];
    swiftCode = json['swiftCode'];
    accountHolderName = json['accountHolderName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['IBAN'] = this.iBAN;
    data['swiftCode'] = this.swiftCode;
    data['accountHolderName'] = this.accountHolderName;
    return data;
  }
}