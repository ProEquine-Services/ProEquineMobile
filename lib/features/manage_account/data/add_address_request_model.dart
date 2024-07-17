class AddAddressRequestModel {
  String? country;
  String? state;
  String? city;
  String? address;

  AddAddressRequestModel({this.country, this.state, this.city, this.address});

  AddAddressRequestModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    city = json['city'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['address'] = address;
    return data;
  }
}