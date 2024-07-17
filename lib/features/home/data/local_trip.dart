import 'package:hive/hive.dart';

part 'local_trip.g.dart';

@HiveType(typeId: 0)
class Trip extends HiveObject {
  @HiveField(0)
  String tripId;

  @HiveField(1)
  String shippingEstimatedDate;

  @HiveField(2)
  String importingCountry;

  @HiveField(3)
  String exportingCountry;

  @HiveField(4)
  String type;

  @HiveField(5)
  String pickupLocation;

  @HiveField(6)
  String pickupContactName;

  @HiveField(7)
  String pickupCountryCode;

  @HiveField(8)
  String pickupPhoneNumber;

  @HiveField(9)
  int numberOfHorses;

  @HiveField(10)
  String dropLocation;

  @HiveField(11)
  String dropContactName;

  @HiveField(12)
  String dropCountryCode;

  @HiveField(13)
  String dropPhoneNumber;

  @HiveField(14)
  String equipmentTask;

  @HiveField(15)
  List<Horse> horses;

  Trip({
    required this.tripId,
    required this.shippingEstimatedDate,
    required this.importingCountry,
    required this.exportingCountry,
    required this.type,
    required this.pickupLocation,
    required this.pickupContactName,
    required this.pickupCountryCode,
    required this.pickupPhoneNumber,
    required this.numberOfHorses,
    required this.dropLocation,
    required this.dropContactName,
    required this.dropCountryCode,
    required this.dropPhoneNumber,
    required this.equipmentTask,
    required this.horses,
  });
}

@HiveType(typeId: 1)
class Horse extends HiveObject {
  @HiveField(0)
  String horseId;

  @HiveField(1)
  String horseName;

  @HiveField(2)
  String color;

  @HiveField(3)
  int yearOfBirth;

  @HiveField(4)
  String gender;

  @HiveField(5)
  String bloodline;

  @HiveField(6)
  String breed;

  @HiveField(7)
  String discipline;

  @HiveField(8)
  String ownership;

  @HiveField(9)
  String staying;

  Horse({
    required this.horseId,
    required this.horseName,
    required this.color,
    required this.yearOfBirth,
    required this.gender,
    required this.bloodline,
    required this.breed,
    required this.discipline,
    required this.ownership,
    required this.staying,
  });
}
