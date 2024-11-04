class AddNewStablesRequestModel {
  String? name;
  String? emirate;
  String? pinLocation;
  bool? showOnApp;
  bool? isVerified;

  AddNewStablesRequestModel(
      {this.name, this.emirate, this.pinLocation, this.showOnApp,this.isVerified});

  AddNewStablesRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    emirate = json['emirate'];
    pinLocation = json['pinLocation'];
    showOnApp = json['showOnApp'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['emirate'] = emirate;
    data['pinLocation'] = pinLocation;
    data['showOnApp'] = showOnApp;
    data['isVerified'] = isVerified;
    return data;
  }
}