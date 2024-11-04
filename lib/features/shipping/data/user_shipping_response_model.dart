import 'package:proequine_dev/core/CoreModels/base_result_model.dart';

import '../../home/data/get_all_places_response_model.dart';
import '../../transports/data/create_transport_response_model.dart';
import 'create_shipping_request_model.dart';

class GetUserShippingResponseModel extends BaseResultModel{
  int? count;
  List<ShippingModel>? rows;

  GetUserShippingResponseModel({this.count, this.rows});

  GetUserShippingResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <ShippingModel>[];
      json['rows'].forEach((v) {
        rows!.add(ShippingModel.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingModel {
  int? id;
  int? userId;
  String? shippingCode;
  User? user;
  String? type;
  int? placeId;
  Place? place;
  ChooseLocation? chooseLocation;
  String? pickUpContactName;
  String? pickUpPhoneNumber;
  int? numberOfHorses;
  List<ShippingHorses>? horses;
  String? tackAndEquipment;
  String? dropContactName;
  String? dropPhoneNumber;
  String? status;
  String? notes;
  String? pickUpDate;
  String? pickUpCountry;
  String? dropCountry;
  bool? isBelongToSelective;

  ShippingModel(
      {this.id,
        this.userId,
        this.user,
        this.type,
        this.shippingCode,
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
        this.status,
        this.pickUpDate,
        this.pickUpCountry,
        this.dropCountry,
        this.isBelongToSelective,
        this.notes});

  ShippingModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    shippingCode = json['shippingCode'];
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
      horses = <ShippingHorses>[];
      json['horses'].forEach((v) {
        horses!.add(ShippingHorses.fromJson(v));
      });
    }
    tackAndEquipment = json['tackAndEquipment'];
    dropContactName = json['dropContactName'];
    dropPhoneNumber = json['dropPhoneNumber'];
    status = json['status'];
    notes = json['notes'];
    pickUpDate = json['pickUpDate'];
    pickUpCountry = json['pickUpCountry'];
    dropCountry = json['dropCountry'];
    isBelongToSelective = json["isBelongToSelective"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['shippingCode'] = shippingCode;
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
    data['status'] = status;
    data['notes'] = notes;
    data['pickUpDate'] = pickUpDate;
    data['dropCountry'] = dropCountry;
    data['pickUpCountry'] = pickUpCountry;
    data['isBelongToSelective'] = isBelongToSelective;
    return data;
  }
}
