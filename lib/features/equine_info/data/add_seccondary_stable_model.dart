class AddSecondaryStableModel {
  String? name;
  int? id;
  String? emirate;
  String? pinLocation;
  bool? showOnApp;
  bool? isVerified;

  AddSecondaryStableModel(
      {this.id,this.name, this.emirate, this.pinLocation, this.showOnApp,this.isVerified});

  AddSecondaryStableModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    emirate = json['emirate'];
    pinLocation = json['pinLocation'];
    showOnApp = json['showOnApp'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['emirate'] = emirate;
    data['pinLocation'] = pinLocation;
    data['showOnApp'] = showOnApp;
    data['isVerified'] = isVerified;
    return data;
  }
}