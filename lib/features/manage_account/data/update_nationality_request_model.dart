class UpdateNationalityRequestModel {
  String? nationality;

  UpdateNationalityRequestModel({this.nationality});

  UpdateNationalityRequestModel.fromJson(Map<String, dynamic> json) {
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nationality'] = nationality;
    return data;
  }
}