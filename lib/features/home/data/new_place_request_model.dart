class AddNewPlaceRequestModel {
  String? name;
  String? category;
  String? code;
  String? desc;
  num? lng;
  num? lat;
  bool? isDummy;

  AddNewPlaceRequestModel(
      {
        this.name,
        this.category,
        this.code,
        this.desc,
        this.lng,
        this.lat,
        this.isDummy});

  AddNewPlaceRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    category = json['category'];
    code = json['code'];
    desc = json['desc'];
    lng = json['lng'];
    lat = json['lat'];
    isDummy = json['isDummy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['category'] = category;
    data['code'] = code;
    data['desc'] = desc;
    data['lng'] = lng;
    data['lat'] = lat;
    data['isDummy'] = isDummy;
    return data;
  }
}