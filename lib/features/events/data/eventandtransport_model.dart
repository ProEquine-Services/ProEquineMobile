class EventDetailsModel {
  late String fullName;
  late String email;
  late String number;
  late String origin;
  late String destination;
  late String noofhorse;
  late String serviceType;
  late DateTime date;
  late DateTime time;
  late bool? returnevent;

  EventDetailsModel({
    required this.fullName,
    required this.email,
    required this.number,
    required this.origin,
    required this.destination,
    required this.noofhorse,
    required this.serviceType,
    required this.date,
    required this.time,
    required this.returnevent,
  });

  factory EventDetailsModel.fromJson(Map<String, dynamic> json) =>
      EventDetailsModel(
        fullName: json["fullName"],
        email: json["email"],
        number: json["number"],
        origin: json["origin"],
        destination: json["destination"],
        noofhorse: json["noofhorse"],
        serviceType: json["serviceType"],
        date: DateTime.parse(json["date"]),
        time: DateTime.parse(json["time"]),
        returnevent: json["returnevent"],
      );
}
