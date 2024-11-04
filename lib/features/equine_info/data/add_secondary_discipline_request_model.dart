class AddSecondaryDisciplineRequestModel {
  int? disciplineId;

  AddSecondaryDisciplineRequestModel(
      {this.disciplineId});

  AddSecondaryDisciplineRequestModel.fromJson(Map<String, dynamic> json) {
    disciplineId = json['disciplineId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disciplineId'] = disciplineId;
    return data;
  }
}