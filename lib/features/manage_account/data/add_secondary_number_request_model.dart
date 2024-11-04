class AddSecondaryNumberRequestModel {
  String? personPhoneNumber;
  String? phoneNumberType;
  int? personId;

  AddSecondaryNumberRequestModel({this.personPhoneNumber, this.personId,this.phoneNumberType});

  AddSecondaryNumberRequestModel.fromJson(Map<String, dynamic> json) {
    personPhoneNumber = json['personPhoneNumber'];
    phoneNumberType = json['phoneNumberType'];
    personId = json['personId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['personPhoneNumber'] = personPhoneNumber;
    data['phoneNumberType'] = phoneNumberType;
    data['personId'] = personId;
    return data;
  }
}