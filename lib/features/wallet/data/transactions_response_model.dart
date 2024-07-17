import 'package:proequine/core/CoreModels/base_result_model.dart';

import '../../equine_info/data/add_secondary_interests_response_model.dart';

class TransactionsResponseModel extends BaseResultModel{
  int? count;
  List<Transaction>? rows;

  TransactionsResponseModel({this.count, this.rows});

  TransactionsResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Transaction>[];
      json['rows'].forEach((v) {
        rows!.add(Transaction.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  int? id;
  num? amount;
  String? description;
  int? type;
  int? userId;
  User? user;
  String? refId;
  String? status;
  String? createdAt;

  Transaction(
      {this.id,
        this.amount,
        this.description,
        this.type,
        this.userId,
        this.user,
        this.refId,
        this.status,
        this.createdAt});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    description = json['description'];
    type = json['type'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    refId = json['refId'];
    status = json['status'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['description'] = description;
    data['type'] = type;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['refId'] = refId;
    data['status'] = status;
    data['createdAt'] = createdAt;
    return data;
  }
}
