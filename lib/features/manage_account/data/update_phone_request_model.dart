class UpdatePhoneRequestModel {
  String? previousPhoneNumber;
  String? newPhoneNumber;
  String? code;

  UpdatePhoneRequestModel(
      {this.previousPhoneNumber, this.newPhoneNumber, this.code});

  UpdatePhoneRequestModel.fromJson(Map<String, dynamic> json) {
    previousPhoneNumber = json['previousPhoneNumber'];
    newPhoneNumber = json['newPhoneNumber'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['previousPhoneNumber'] = previousPhoneNumber;
    data['newPhoneNumber'] = newPhoneNumber;
    data['code'] = code;
    return data;
  }
}