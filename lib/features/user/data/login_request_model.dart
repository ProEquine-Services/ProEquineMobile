class LoginRequestModel {
  String? userName;
  String? password;

  LoginRequestModel({this.userName, this.password});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['userName'] = userName;
    data['password'] = password;
    return data;
  }
}