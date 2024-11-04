import 'package:proequine_dev/core/CoreModels/base_result_model.dart';

import '../../home/data/get_all_places_response_model.dart';
import '../../transports/data/create_transport_response_model.dart';
import 'create_shipping_request_model.dart';

class CreateShippingResponseModel extends BaseResultModel {
  int? id;
  int? userId;
  User? user;
  String? type;
  int? placeId;
  Place? place;
  ChooseLocation? chooseLocation;
  String? pickUpContactName;
  String? pickUpPhoneNumber;
  int? numberOfHorses;
  List<Horses>? horses;
  String? tackAndEquipment;
  String? dropContactName;
  String? pickUpCountry;
  String? dropCountry;
  String? dropPhoneNumber;
  String? status;
  String? notes;

  CreateShippingResponseModel(
      {this.id,
        this.userId,
        this.user,
        this.type,
        this.placeId,
        this.place,
        this.chooseLocation,
        this.pickUpContactName,
        this.pickUpPhoneNumber,
        this.numberOfHorses,
        this.horses,
        this.tackAndEquipment,
        this.dropContactName,
        this.dropPhoneNumber,
        this.pickUpCountry,
        this.dropCountry,
        this.status,
        this.notes});

  CreateShippingResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    type = json['type'];
    placeId = json['placeId'];
    place = json['place'] != null ? Place.fromJson(json['place']) : null;
    chooseLocation = json['chooseLocation'] != null
        ? ChooseLocation.fromJson(json['chooseLocation'])
        : null;
    pickUpContactName = json['pickUpContactName'];
    pickUpPhoneNumber = json['pickUpPhoneNumber'];
    numberOfHorses = json['numberOfHorses'];
    if (json['horses'] != null) {
      horses = <Horses>[];
      json['horses'].forEach((v) {
        horses!.add(Horses.fromJson(v));
      });
    }
    tackAndEquipment = json['tackAndEquipment'];
    dropContactName = json['dropContactName'];
    dropPhoneNumber = json['dropPhoneNumber'];
    pickUpCountry = json['pickUpCountry'];
    dropCountry = json['dropCountry'];
    status = json['status'];
    notes = json['notes'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['type'] = type;
    data['placeId'] = placeId;
    if (place != null) {
      data['place'] = place!.toJson();
    }
    if (chooseLocation != null) {
      data['chooseLocation'] = chooseLocation!.toJson();
    }
    data['pickUpContactName'] = pickUpContactName;
    data['pickUpPhoneNumber'] = pickUpPhoneNumber;
    data['numberOfHorses'] = numberOfHorses;
    if (horses != null) {
      data['horses'] = horses!.map((v) => v.toJson()).toList();
    }
    data['tackAndEquipment'] = tackAndEquipment;
    data['dropContactName'] = dropContactName;
    data['dropPhoneNumber'] = dropPhoneNumber;
    data['dropCountry'] = dropCountry;
    data['pickUpCountry'] = pickUpCountry;
    data['status'] = status;
    data['notes'] = notes;
    return data;
  }
}