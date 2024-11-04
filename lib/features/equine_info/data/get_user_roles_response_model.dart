import '../../../core/CoreModels/base_result_model.dart';

class GetUserRolesResponseModel extends BaseResultModel {
  List<String>? roles;

  GetUserRolesResponseModel({this.roles});

  GetUserRolesResponseModel.fromJson(Map<String, dynamic> json) {
    roles = json['roles'].cast<String>();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['roles'] = roles;
    return data;
  }
}
