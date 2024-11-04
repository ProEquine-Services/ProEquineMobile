class DeleteAccountRequestModel {
  String? reason;

  DeleteAccountRequestModel({this.reason});

  DeleteAccountRequestModel.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reason'] = reason;
    return data;
  }
}