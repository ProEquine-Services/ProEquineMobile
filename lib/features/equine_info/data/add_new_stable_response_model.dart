import 'package:proequine/core/CoreModels/base_result_model.dart';

class AddNewStablesResponseModel extends BaseResultModel{
  int? id;
  String? name;
  String? emirate;
  String? pinLocation;
  String? status;
  bool? showOnApp;
  int? createdBy;

  AddNewStablesResponseModel(
      {this.id,
        this.name,
        this.emirate,
        this.pinLocation,
        this.status,
        this.showOnApp,
        this.createdBy});

  AddNewStablesResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emirate = json['emirate'];
    pinLocation = json['pinLocation'];
    status = json['status'];
    showOnApp = json['showOnApp'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['emirate'] = this.emirate;
    data['pinLocation'] = this.pinLocation;
    data['status'] = this.status;
    data['showOnApp'] = this.showOnApp;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
