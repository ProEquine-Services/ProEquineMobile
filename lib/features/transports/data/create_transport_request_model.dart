class CreateTransportRequestModel {
  List<int>? horseIds;
  String? type;
  int? pickUpLocation;
  int? dropLocation;
  String? pickUpDate;
  String? pickUpTime;
  String? dropPhoneNumber;
  String? pickUpPhoneNumber;
  String? pickUpContactName;
  String? dropContactName;
  int? numberOfHorses;
  String? returnDate;
  String? returnTime;
  String? notes;

  CreateTransportRequestModel(
      {
        this.horseIds,
        this.type,
        this.pickUpLocation,
        this.dropLocation,
        this.pickUpDate,
        this.pickUpTime,
        this.dropPhoneNumber,
        this.pickUpPhoneNumber,
        this.pickUpContactName,
        this.dropContactName,
        this.numberOfHorses,
        this.returnDate,
        this.returnTime,
        this.notes});

  CreateTransportRequestModel.fromJson(Map<String, dynamic> json) {
    horseIds = json['horseIds'].cast<int>();
    type = json['type'];
    pickUpLocation = json['pickUpLocation'];
    dropLocation = json['dropLocation'];
    pickUpDate = json['pickUpDate'];
    pickUpTime = json['pickUpTime'];
    dropPhoneNumber = json['dropPhoneNumber'];
    pickUpPhoneNumber = json['pickUpPhoneNumber'];
    pickUpContactName = json['pickUpContactName'];
    dropContactName = json['dropContactName'];
    numberOfHorses = json['numberOfHorses'];
    returnDate = json['returnDate'];
    returnTime = json['returnTime'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['horseIds'] = horseIds;
    data['type'] = type;
    data['pickUpLocation'] = pickUpLocation;
    data['dropLocation'] = dropLocation;
    data['pickUpDate'] = pickUpDate;
    data['pickUpTime'] = pickUpTime;
    data['dropPhoneNumber'] = dropPhoneNumber;
    data['pickUpPhoneNumber'] = pickUpPhoneNumber;
    data['pickUpContactName'] = pickUpContactName;
    data['dropContactName'] = dropContactName;
    data['numberOfHorses'] = numberOfHorses;
    data['returnDate'] = returnDate;
    data['returnTime'] = returnTime;
    data['notes'] = notes;
    return data;
  }
}