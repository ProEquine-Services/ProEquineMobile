class UpdateSecondaryDisciplineRequestModel {
  int? disciplineId;
  int? personDisciplineId;
  String? nationalId;
  String? feiid;

  UpdateSecondaryDisciplineRequestModel(
      {this.disciplineId,
        this.personDisciplineId,
        this.nationalId,
        this.feiid});

  UpdateSecondaryDisciplineRequestModel.fromJson(Map<String, dynamic> json) {
    disciplineId = json['disciplineId'];
    personDisciplineId = json['personDisciplineId'];
    nationalId = json['nationalId'];
    feiid = json['feiid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disciplineId'] = disciplineId;
    data['personDisciplineId'] = personDisciplineId;
    data['nationalId'] = nationalId;
    data['feiid'] = feiid;
    return data;
  }
}