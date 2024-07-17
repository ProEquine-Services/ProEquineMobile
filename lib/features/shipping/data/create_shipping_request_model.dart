class CreateShippingRequestModel {
  String? type;
  int? placeId;
  ChooseLocation? chooseLocation;
  String? pickUpContactName;
  String? pickUpPhoneNumber;
  int? numberOfHorses;
  List<ShippingHorses>? shippingHorses;
  String? tackAndEquipment;
  String? dropContactName;
  String? dropPhoneNumber;
  String? notes;
  String? pickUpDate;
  String? dropCountry;
  String? pickUpCountry;

  CreateShippingRequestModel(
      {this.type,
      this.placeId,
      this.chooseLocation,
      this.pickUpContactName,
      this.pickUpPhoneNumber,
      this.numberOfHorses,
      this.shippingHorses,
      this.tackAndEquipment,
      this.dropContactName,
      this.dropPhoneNumber,
      this.pickUpDate,
      this.dropCountry,
      this.pickUpCountry,
      this.notes});

  CreateShippingRequestModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    placeId = json['placeId'];
    chooseLocation = json['chooseLocation'] != null
        ? ChooseLocation.fromJson(json['chooseLocation'])
        : null;
    pickUpContactName = json['pickUpContactName'];
    pickUpPhoneNumber = json['pickUpPhoneNumber'];
    numberOfHorses = json['numberOfHorses'];
    if (json['horses'] != null) {
      shippingHorses = <ShippingHorses>[];
      json['horses'].forEach((v) {
        shippingHorses!.add(ShippingHorses.fromJson(v));
      });
    }
    tackAndEquipment = json['tackAndEquipment'];
    dropContactName = json['dropContactName'];
    dropPhoneNumber = json['dropPhoneNumber'];
    notes = json['notes'];
    pickUpDate = json['pickUpDate'];
    dropCountry = json['dropCountry'];
    pickUpCountry = json['pickUpCountry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['placeId'] = placeId;
    if (chooseLocation != null) {
      data['chooseLocation'] = chooseLocation!.toJson();
    }
    data['pickUpContactName'] = pickUpContactName;
    data['pickUpPhoneNumber'] = pickUpPhoneNumber;
    data['numberOfHorses'] = numberOfHorses;
    if (shippingHorses != null) {
      data['horses'] = shippingHorses!.map((v) => v.toJson()).toList();
    }
    data['tackAndEquipment'] = tackAndEquipment;
    data['dropContactName'] = dropContactName;
    data['dropPhoneNumber'] = dropPhoneNumber;
    data['notes'] = notes;
    data['pickUpCountry'] = pickUpCountry;
    data['dropCountry'] = dropCountry;
    data['pickUpDate'] = pickUpDate;
    return data;
  }
}

class ChooseLocation {
  String? lng;
  String? lat;
  String? name;

  ChooseLocation({this.lng, this.lat, this.name});

  ChooseLocation.fromJson(Map<String, dynamic> json) {
    lng = json['lng'];
    lat = json['lat'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lng'] = lng;
    data['lat'] = lat;
    data['name'] = name;
    return data;
  }
}

class ShippingHorses {
  int? horseId;
  String? ownerShip;
  String? staying;

  ShippingHorses({this.horseId, this.ownerShip, this.staying});

  ShippingHorses.fromJson(Map<String, dynamic> json) {
    horseId = json['horseId'];
    ownerShip = json['ownerShip'];
    staying = json['staying'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['horseId'] = horseId;
    data['ownerShip'] = ownerShip;
    data['staying'] = staying;
    return data;
  }
}
