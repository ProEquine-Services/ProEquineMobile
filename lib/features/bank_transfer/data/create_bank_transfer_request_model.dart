class CreateBankTransferRequestModel {
  int? amount;
  String? transferType;
  int? userId;
  String? transferProof;

  CreateBankTransferRequestModel(
      {this.amount, this.transferType, this.userId, this.transferProof});

  CreateBankTransferRequestModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    transferType = json['transferType'];
    userId = json['userId'];
    transferProof = json['transferProof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['transferType'] = transferType;
    data['userId'] = userId;
    data['transferProof'] = transferProof;
    return data;
  }
}