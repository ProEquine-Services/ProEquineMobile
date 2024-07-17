class TripServiceDataModel {
  String pickupLocation;
  String? pickupLocationUrl;
  String? dropOffLocationUrl;
  String tripType;
  String trip;
  DateTime pickupDate;
  String showingDate;
  String pickupTime;
  String pickupContactName;
  String pickupContactNumber;
  String? dropLocation;
  String dropContactNumber;
  String dropContactName;
  String? hospitalName;
  String horsesNumber;
  DateTime? expectedDate;
  String? expectedTime;

  TripServiceDataModel({
    required this.pickupLocation,
    required this.tripType,
    required this.trip,
    required this.pickupContactName,
    required this.showingDate,
    required this.pickupContactNumber,
    required this.pickupDate,
    required this.pickupTime,
    required this.dropContactName,
    required this.dropContactNumber,
    this.dropLocation,
    this.pickupLocationUrl,
    this.dropOffLocationUrl,
    this.hospitalName,
    required this.horsesNumber,
    this.expectedDate,
    this.expectedTime,
  });
}
