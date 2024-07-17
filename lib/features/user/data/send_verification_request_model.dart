class SendVerificationRequestModel {
  String? phoneNumber;

  SendVerificationRequestModel({
    this.phoneNumber,
  });

  SendVerificationRequestModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['PhoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PhoneNumber'] = phoneNumber;

    return data;
  }
}
