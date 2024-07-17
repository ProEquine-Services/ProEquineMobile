class UpdateMainNumberRequestModel {
  String? otpCode;

  UpdateMainNumberRequestModel({this.otpCode});

  UpdateMainNumberRequestModel.fromJson(Map<String, dynamic> json) {
    otpCode = json['otpCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otpCode'] = otpCode;
    return data;
  }
}
