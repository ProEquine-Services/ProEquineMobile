class RemoveHorseRequestModel {
  int? horseId;

  RemoveHorseRequestModel({this.horseId});

  RemoveHorseRequestModel.fromJson(Map<String, dynamic> json) {
    horseId = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = horseId;
    return data;
  }
}