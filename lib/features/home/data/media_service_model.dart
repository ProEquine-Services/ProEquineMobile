class MediaServiceModel {
  String horsesNumber;
  String eventName;
  String serviceType;
  String? notes;


  MediaServiceModel({

    required this.horsesNumber,
    required this.eventName,
    required this.serviceType,
    this.notes,
  });
}
