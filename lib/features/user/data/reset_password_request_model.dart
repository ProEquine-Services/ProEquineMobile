class ResetPasswordRequestModel {
  String? email;
  String? otpCode;
  String? newPassword;
  String? confirmNewPassword;

  ResetPasswordRequestModel(
      {this.email, this.otpCode, this.newPassword, this.confirmNewPassword});

  ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otpCode = json['otpCode'];
    newPassword = json['newPassword'];
    confirmNewPassword = json['confirmNewPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['otpCode'] = otpCode;
    data['newPassword'] = newPassword;
    data['confirmNewPassword'] = confirmNewPassword;
    return data;
  }
}
