// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_trip.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TripAdapter extends TypeAdapter<Trip> {
  @override
  final int typeId = 0;

  @override
  Trip read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Trip(
      tripId: fields[0] as String,
      shippingEstimatedDate: fields[1] as String,
      importingCountry: fields[2] as String,
      exportingCountry: fields[3] as String,
      type: fields[4] as String,
      pickupLocation: fields[5] as String,
      pickupContactName: fields[6] as String,
      pickupCountryCode: fields[7] as String,
      pickupPhoneNumber: fields[8] as String,
      numberOfHorses: fields[9] as int,
      dropLocation: fields[10] as String,
      dropContactName: fields[11] as String,
      dropCountryCode: fields[12] as String,
      dropPhoneNumber: fields[13] as String,
      equipmentTask: fields[14] as String,
      horses: (fields[15] as List).cast<Horse>(),
    );
  }

  @override
  void write(BinaryWriter writer, Trip obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.tripId)
      ..writeByte(1)
      ..write(obj.shippingEstimatedDate)
      ..writeByte(2)
      ..write(obj.importingCountry)
      ..writeByte(3)
      ..write(obj.exportingCountry)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.pickupLocation)
      ..writeByte(6)
      ..write(obj.pickupContactName)
      ..writeByte(7)
      ..write(obj.pickupCountryCode)
      ..writeByte(8)
      ..write(obj.pickupPhoneNumber)
      ..writeByte(9)
      ..write(obj.numberOfHorses)
      ..writeByte(10)
      ..write(obj.dropLocation)
      ..writeByte(11)
      ..write(obj.dropContactName)
      ..writeByte(12)
      ..write(obj.dropCountryCode)
      ..writeByte(13)
      ..write(obj.dropPhoneNumber)
      ..writeByte(14)
      ..write(obj.equipmentTask)
      ..writeByte(15)
      ..write(obj.horses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TripAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HorseAdapter extends TypeAdapter<Horse> {
  @override
  final int typeId = 1;

  @override
  Horse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Horse(
      horseId: fields[0] as String,
      horseName: fields[1] as String,
      color: fields[2] as String,
      yearOfBirth: fields[3] as int,
      gender: fields[4] as String,
      bloodline: fields[5] as String,
      breed: fields[6] as String,
      discipline: fields[7] as String,
      ownership: fields[8] as String,
      staying: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Horse obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.horseId)
      ..writeByte(1)
      ..write(obj.horseName)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.yearOfBirth)
      ..writeByte(4)
      ..write(obj.gender)
      ..writeByte(5)
      ..write(obj.bloodline)
      ..writeByte(6)
      ..write(obj.breed)
      ..writeByte(7)
      ..write(obj.discipline)
      ..writeByte(8)
      ..write(obj.ownership)
      ..writeByte(9)
      ..write(obj.staying);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HorseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
