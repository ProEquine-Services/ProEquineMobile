class ChoseMainStableRequestModel {
  int? id;
  String? name;
  bool? isUpdated;
  String? emirate;
  String? pinLocation;

  ChoseMainStableRequestModel(
      {this.id, this.name, this.emirate, this.pinLocation,this.isUpdated});

  ChoseMainStableRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isUpdated = json['isUpdated'];
    emirate = json['emirate'];
    pinLocation = json['pinLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['emirate'] = emirate;
    data['isUpdated'] = isUpdated;
    data['pinLocation'] = pinLocation;
    return data;
  }
}
