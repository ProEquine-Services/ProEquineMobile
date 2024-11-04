
import '../../../core/CoreModels/base_result_model.dart';
import '../../equine_info/data/add_secondary_interests_response_model.dart';

class GetAllBankTransfersResponseModel extends BaseResultModel {
  int? count;
  List<BankTransfer>? rows;

  GetAllBankTransfersResponseModel({this.count, this.rows});

  GetAllBankTransfersResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <BankTransfer>[];
      json['rows'].forEach((v) {
        rows!.add(BankTransfer.fromJson(v));
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

class BankTransfer {
  int? id;
  String? referenceNumber;
  String? transferType;
  String? transferProof;
  String? status;
  num? amount;
  int? userId;
  User? user;
  String? createdAt;


  BankTransfer(
      {this.id,
      this.referenceNumber,
      this.transferType,
      this.transferProof,
      this.status,
      this.amount,
      this.userId,
      this.user,
      this.createdAt,});

  BankTransfer.fromJson(Map<String, dynamic> json) {
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
class Account {
  int? id;
  num? totalAmount;
  num? blockedAmount;
  num? availableAmount;
  int? userId;
  String? user;
  String? bankName;
  String? accountNumber;
  String? iBAN;
  String? swiftCode;
  String? accountHolderName;
  bool? isRegisterdInZoho;

  Account(
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
        this.isRegisterdInZoho,

        this.accountHolderName});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['totalAmount'];
    blockedAmount = json['blockedAmount'];
    availableAmount = json['availableAmount'];
    userId = json['userId'];
    user = json['user'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    iBAN = json['IBAN'];
    swiftCode = json['swiftCode'];
    accountHolderName = json['accountHolderName'];
    isRegisterdInZoho = json['isRegisterdInZoho'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['totalAmount'] = totalAmount;
    data['blockedAmount'] = blockedAmount;
    data['availableAmount'] = availableAmount;
    data['userId'] = userId;
    data['user'] = user;
    data['bankName'] = bankName;
    data['accountNumber'] = accountNumber;
    data['IBAN'] = iBAN;
    data['swiftCode'] = swiftCode;
    data['accountHolderName'] = accountHolderName;
    data['isRegisterdInZoho'] = isRegisterdInZoho;
    return data;
  }
}
