
import '../../../core/CoreModels/base_result_model.dart';
import '../../home/data/get_all_places_response_model.dart';
import 'create_shipping_request_model.dart';

class SelectiveServiceResponseModel extends BaseResultModel{
  int? count;
  List<SelectiveServiceModel>? rows;

  SelectiveServiceResponseModel({this.count, this.rows});

  SelectiveServiceResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <SelectiveServiceModel>[];
      json['rows'].forEach((v) {
        rows!.add(SelectiveServiceModel.fromJson(v));
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

class SelectiveServiceModel {
  int? id;
  String? title;
  String? type;
  String? selectiveCode;
  String? startDate;
  String? endDate;
  int? placeId;
  Place? place;
  String? pickUpContactName;
  String? pickUpPhoneNumber;
  int? numberOfHorses;
  String? tackAndEquipment;
  ChooseLocation? chooseLocation;
  String? dropContactName;
  String? pickUpCountry;
  String? dropCountry;
  String? dropPhoneNumber;
  bool? showOnApp;
  bool? showOnWebsite;
  String? fromCountry;
  String? toCountry;
  bool? availableForBooking;

  SelectiveServiceModel(
      {this.id,
        this.title,
        this.type,
        this.startDate,
        this.endDate,
        this.selectiveCode,
        this.placeId,
        this.place,
        this.pickUpContactName,
        this.pickUpPhoneNumber,
        this.numberOfHorses,
        this.pickUpCountry,
        this.dropCountry,
        this.tackAndEquipment,
        this.chooseLocation,
        this.dropContactName,
        this.dropPhoneNumber,
        this.showOnApp,
        this.showOnWebsite,
        this.fromCountry,
        this.toCountry,
        this.availableForBooking});

  SelectiveServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    selectiveCode = json['selectiveCode'];
    type = json['type'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    pickUpCountry = json['pickUpCountry'];
    dropCountry = json['dropCountry'];
    placeId = json['placeId'];
    place = json['Place'] != null ? Place.fromJson(json['Place']) : null;
    pickUpContactName = json['pickUpContactName'];
    pickUpPhoneNumber = json['pickUpPhoneNumber'];
    numberOfHorses = json['numberOfHorses'];
    tackAndEquipment = json['tackAndEquipment'];
    chooseLocation = json['chooseLocation'] != null
        ? ChooseLocation.fromJson(json['chooseLocation'])
        : null;
    dropContactName = json['dropContactName'];
    dropPhoneNumber = json['dropPhoneNumber'];
    showOnApp = json['showOnApp'];
    showOnWebsite = json['showOnWebsite'];
    fromCountry = json['fromCountry'];
    toCountry = json['toCountry'];
    availableForBooking = json['availableForBooking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['selectiveCode'] = selectiveCode;
    data['type'] =type;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['placeId'] = placeId;
    if (place != null) {
      data['Place'] = place!.toJson();
    }
    data['pickUpContactName'] = pickUpContactName;
    data['pickUpPhoneNumber'] = pickUpPhoneNumber;
    data['numberOfHorses'] = numberOfHorses;
    data['tackAndEquipment'] = tackAndEquipment;
    if (chooseLocation != null) {
      data['chooseLocation'] = chooseLocation!.toJson();
    }
    data['dropContactName'] = dropContactName;
    data['pickUpCountry'] = pickUpCountry;
    data['dropCountry'] = dropCountry;
    data['dropPhoneNumber'] = dropPhoneNumber;
    data['showOnApp'] = showOnApp;
    data['showOnWebsite'] = showOnWebsite;
    data['fromCountry'] = fromCountry;
    data['toCountry'] = toCountry;
    data['availableForBooking'] = availableForBooking;
    return data;
  }
}
