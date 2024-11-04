class RegisterRequestModel {
  String? email;
  String? firstName;
  String? lastName;
  String? middleName;
  String? password;
  String? confirmPassword;
  String? phoneNumber;
  String? gender;
  String? nationality;
  String? dateOfBirth;

  RegisterRequestModel(
      {this.email,
      this.firstName,
      this.lastName,
      this.middleName,
      this.password,
      this.confirmPassword,
      this.phoneNumber,
      this.gender,
      this.nationality,
      this.dateOfBirth});

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    phoneNumber = json['phoneNumber'];
    gender = json['gender'];
    nationality = json['nationality'];
    dateOfBirth = json['dateOfBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['middleName'] = middleName;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    data['phoneNumber'] = phoneNumber;
    data['gender'] = gender;
    data['nationality'] = nationality;
    data['dateOfBirth'] = dateOfBirth;
    return data;
  }
}
