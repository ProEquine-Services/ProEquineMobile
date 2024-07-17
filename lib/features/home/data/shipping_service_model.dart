import 'package:proequine/features/shipping/data/create_shipping_request_model.dart';

class ShippingServiceModel {
  String pickupLocation;
  DateTime shipmentEstimatedDate;
  ChooseLocation? location;
  String pickupContactName;
  String? dropContactName;
  int? placeId;
  String pickupContactNumber;
  String? dropPhoneNumber;
  String selectedCountry;
  String horsesNumber;
  String serviceType;
  String? notes;
  String? equipment;

  ShippingServiceModel({
    required this.pickupLocation,
    required this.pickupContactName,
    required this.pickupContactNumber,
    required this.shipmentEstimatedDate,
    required this.selectedCountry,
     this.dropContactName,
     this.dropPhoneNumber,
    required this.horsesNumber,
    required this.serviceType,
    this.placeId,
    this.location,
    this.notes,
   this.equipment,
  });
}
