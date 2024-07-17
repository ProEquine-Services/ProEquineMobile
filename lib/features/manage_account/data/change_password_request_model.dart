class ChangePasswordRequestModel {
  String? currentPassword;
  String? newPassword;
  String? confirmNewPassword;

  ChangePasswordRequestModel(
      {this.currentPassword, this.newPassword, this.confirmNewPassword});

  ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    currentPassword = json['currentPassword'];
    newPassword = json['newPassword'];
    confirmNewPassword = json['confirmNewPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPassword'] = currentPassword;
    data['newPassword'] = newPassword;
    data['confirmNewPassword'] = confirmNewPassword;
    return data;
  }
}