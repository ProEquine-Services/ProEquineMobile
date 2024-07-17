class AddRoleRequestModel {
  String? role;
  String? reason;

  AddRoleRequestModel({this.role,this.reason});

  AddRoleRequestModel.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    data['reason'] = reason;
    return data;
  }
}