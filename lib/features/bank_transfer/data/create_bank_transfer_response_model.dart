import 'package:proequine/core/CoreModels/base_result_model.dart';

import '../../equine_info/data/add_secondary_interests_response_model.dart';

class CreateBankTransferResponseModel extends BaseResultModel{
  int? id;
  String? referenceNumber;
  String? transferType;
  String? transferProof;
  String? status;
  int? amount;
  int? userId;
  User? user;
  String? createdAt;

  CreateBankTransferResponseModel(
      {this.id,
        this.referenceNumber,
        this.transferType,
        this.transferProof,
        this.status,
        this.amount,
        this.userId,
        this.user,
        this.createdAt});

  CreateBankTransferResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    referenceNumber = json['referenceNumber'];
    transferType = json['transferType'];
    transferProof = json['transferProof'];
    status = json['status'];
    amount = json['amount'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createdAt = json['createdAt'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['referenceNumber'] = referenceNumber;
    data['transferType'] = transferType;
    data['transferProof'] = transferProof;
    data['status'] = status;
    data['amount'] = amount;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['createdAt'] = createdAt;
    return data;
  }
}