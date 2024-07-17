class EditPhoneRequestModel {
  String? phoneNumber;

  EditPhoneRequestModel({this.phoneNumber});

  EditPhoneRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}