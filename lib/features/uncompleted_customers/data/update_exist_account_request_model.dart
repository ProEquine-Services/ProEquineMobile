class UpdateExistAccountRequestModel {
  String? dateOfBirth;
  String? userName;
  String? password;
  String? confirmPassword;

  UpdateExistAccountRequestModel(
      {this.dateOfBirth, this.userName, this.password, this.confirmPassword});

  UpdateExistAccountRequestModel.fromJson(Map<String, dynamic> json) {
    dateOfBirth = json['dateOfBirth'];
    userName = json['userName'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateOfBirth'] = dateOfBirth;
    data['userName'] = userName;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    return data;
  }
}