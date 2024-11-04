import 'create_shipping_request_model.dart';

class JoinSelectiveServiceRequestModel {
  int? id;
  int? userId;
  int? numberOfHorses;
  List<ShippingHorses>? horses;
  String? pickUpContactName;
  String? pickUpPhoneNumber;
  String? tackAndEquipment;
  String? dropContactName;
  String? dropPhoneNumber;
  ChooseLocation? chooseLocation;
  int? placeId;
  String? pickupDate;
  String? pickupTime;
  String? notes;

  JoinSelectiveServiceRequestModel(
      {this.id,
        this.userId,
        this.numberOfHorses,
        this.horses,
        this.pickUpContactName,
        this.pickUpPhoneNumber,
        this.tackAndEquipment,
        this.dropContactName,
        this.dropPhoneNumber,
        this.chooseLocation,
        this.placeId,
        this.pickupDate,
        this.pickupTime,
        this.notes});

  JoinSelectiveServiceRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    numberOfHorses = json['numberOfHorses'];
    if (json['horses'] != null) {
      horses = <ShippingHorses>[];
      json['horses'].forEach((v) {
        horses!.add(new ShippingHorses.fromJson(v));
      });
    }
    pickUpContactName = json['pickUpContactName'];
    pickUpPhoneNumber = json['pickUpPhoneNumber'];
    tackAndEquipment = json['tackAndEquipment'];
    dropContactName = json['dropContactName'];
    dropPhoneNumber = json['dropPhoneNumber'];
    chooseLocation = json['chooseLocation'] != null
        ? new ChooseLocation.fromJson(json['chooseLocation'])
        : null;
    placeId = json['placeId'];
    pickupDate = json['pickupDate'];
    pickupTime = json['pickupTime'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['numberOfHorses'] = this.numberOfHorses;
    if (this.horses != null) {
      data['horses'] = this.horses!.map((v) => v.toJson()).toList();
    }
    data['pickUpContactName'] = this.pickUpContactName;
    data['pickUpPhoneNumber'] = this.pickUpPhoneNumber;
    data['tackAndEquipment'] = this.tackAndEquipment;
    data['dropContactName'] = this.dropContactName;
    data['dropPhoneNumber'] = this.dropPhoneNumber;
    if (this.chooseLocation != null) {
      data['chooseLocation'] = this.chooseLocation!.toJson();
    }
    data['placeId'] = this.placeId;
    data['pickupDate'] = this.pickupDate;
    data['pickupTime'] = this.pickupTime;
    data['notes'] = this.notes;
    return data;
  }
}