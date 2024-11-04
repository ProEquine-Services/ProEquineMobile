class PushTransferRequestModel {
  int? id;
  String? transferProof;

  PushTransferRequestModel({this.id, this.transferProof});

  PushTransferRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transferProof = json['transferProof'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transferProof'] = transferProof;
    return data;
  }
}