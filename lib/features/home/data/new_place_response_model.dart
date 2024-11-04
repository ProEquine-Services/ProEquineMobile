
import '../../../core/CoreModels/base_result_model.dart';

class AddNewPlaceResponseModel  extends BaseResultModel{
  int? id;
  String? name;
  String? desc;
  String? lng;
  String? lat;
  String? category;
  int? createdBy;

  AddNewPlaceResponseModel(
      {this.id, this.name, this.lng, this.lat, this.category, this.createdBy,this.desc});

  AddNewPlaceResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    lng = json['lng'];
    lat = json['lat'];
    category = json['category'];
    createdBy = json['createdBy'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    data['lng'] = lng;
    data['lat'] = lat;
    data['category'] = category;
    data['createdBy'] = createdBy;
    return data;
  }
}