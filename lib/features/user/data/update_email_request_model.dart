class UpdateMailRequestModel {
  String? newEmail;

  UpdateMailRequestModel({this.newEmail});

  UpdateMailRequestModel.fromJson(Map<String, dynamic> json) {
    newEmail = json['emailAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['emailAddress'] = newEmail;
    return data;
  }
}