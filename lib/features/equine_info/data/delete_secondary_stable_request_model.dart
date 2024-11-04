class DeleteSecondaryStableRequestModel {
  int? personStableId;

  DeleteSecondaryStableRequestModel({this.personStableId});

  DeleteSecondaryStableRequestModel.fromJson(Map<String, dynamic> json) {
    personStableId = json['personStableId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personStableId'] = personStableId;
    return data;
  }
}