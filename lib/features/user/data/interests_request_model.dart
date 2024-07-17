class InterestsRequestModel {
  int? mainDisciplineId;
  List<String>? roles;

  InterestsRequestModel({this.mainDisciplineId, this.roles});

  InterestsRequestModel.fromJson(Map<String, dynamic> json) {
    mainDisciplineId = json['mainDisciplineId'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mainDisciplineId'] = this.mainDisciplineId;
    data['roles'] = this.roles;
    return data;
  }
}