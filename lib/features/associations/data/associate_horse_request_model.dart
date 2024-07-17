class AssociateHorseRequestModel {
  int? horseId;
  int? peId;
  String? userName;
  String? type;

  AssociateHorseRequestModel({ this.horseId, this.userName, this.type,this.peId});

  AssociateHorseRequestModel.fromJson(Map<String, dynamic> json) {
    horseId = json['horseId'];
    peId = json['PEID'];
    userName = json['userName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['horseId'] = horseId;
    data['PEID'] = peId;
    data['userName'] = userName;
    data['type'] = type;
    return data;
  }
}
