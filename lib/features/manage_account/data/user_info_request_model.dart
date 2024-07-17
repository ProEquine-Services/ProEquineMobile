class UserInfoRequestModel {
  String? dateOfBirth;
  String? nationality;
  String? displayName;

  UserInfoRequestModel({this.dateOfBirth, this.nationality, this.displayName});

  UserInfoRequestModel.fromJson(Map<String, dynamic> json) {
    dateOfBirth = json['dateOfBirth'];
    nationality = json['nationality'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dateOfBirth'] = dateOfBirth;
    data['nationality'] = nationality;
    data['displayName'] = displayName;
    return data;
  }
}