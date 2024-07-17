class UpdateMainDisciplineRequestModel {
  String? disciplineTitle;
  String? nationalId;
  String? feiid;

  UpdateMainDisciplineRequestModel(
      {this.disciplineTitle, this.nationalId, this.feiid});

  UpdateMainDisciplineRequestModel.fromJson(Map<String, dynamic> json) {
    disciplineTitle = json['disciplineTitle'];
    nationalId = json['nationalId'];
    feiid = json['feiid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['disciplineTitle'] = disciplineTitle;
    data['nationalId'] = nationalId;
    data['feiid'] = feiid;
    return data;
  }
}