import 'create_shipping_request_model.dart';

class EditShippingRequestModel {
  int? id;
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

  EditShippingRequestModel(
      {this.id,
      this.type,
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

  EditShippingRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = id;
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
    data['dropCountry'] = dropCountry;
    data['pickUpCountry'] = pickUpCountry;
    data['pickUpDate'] = pickUpDate;
    return data;
  }
}
