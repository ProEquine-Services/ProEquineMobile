class UpdateHorseConditionRequestModel {
  int? horseId;
  String? horseCondition;
  int? disciplineId;
  int? stableId;

  UpdateHorseConditionRequestModel(
      {this.horseId, this.horseCondition, this.disciplineId, this.stableId});

  UpdateHorseConditionRequestModel.fromJson(Map<String, dynamic> json) {
    horseId = json['horseId'];
    horseCondition = json['horseCondition'];
    disciplineId = json['disciplineId'];
    stableId = json['stableId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['horseId'] = horseId;
    data['horseCondition'] = horseCondition;
    data['disciplineId'] = disciplineId;
    data['stableId'] = stableId;
    return data;
  }
}