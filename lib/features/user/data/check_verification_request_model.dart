class CheckVerificationCodeRequestModel {
  String? otpCode;

  CheckVerificationCodeRequestModel({this.otpCode});

  CheckVerificationCodeRequestModel.fromJson(Map<String, dynamic> json) {
    otpCode = json['otpCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otpCode'] = otpCode;
    return data;
  }
}