import 'package:proequine/core/CoreModels/base_result_model.dart';

import '../../associations/data/horse_associated_requests_response_model.dart';
import '../../bank_transfer/data/all_bank_transfers_response_model.dart';

class TransportModel extends BaseResultModel{
  int? id;
  int? userId;
  String? transportCode;
  User? user;
  String? type;
  int? pickUpLocation;
  PickPlace? pickPlace;
  int? dropLocation;
  PickPlace? dropPlace;
  String? pickUpDate;
  String? pickUpTime;
  String? dropPhoneNumber;
  String? pickUpPhoneNumber;
  String? pickUpContactName;
  String? dropContactName;
  int? numberOfHorses;
  List<Horses>? horses;
  String? returnDate;
  String? returnTime;
  String? notes;
  String? status;
  int? selectiveParent;
  bool? isBelongToSelective;

  TransportModel(
      {this.id,
        this.userId,
        this.transportCode,
        this.user,
        this.type,
        this.pickUpLocation,
        this.pickPlace,
        this.dropLocation,
        this.dropPlace,
        this.pickUpDate,
        this.pickUpTime,
        this.dropPhoneNumber,
        this.dropContactName,
        this.pickUpPhoneNumber,
        this.pickUpContactName,
        this.numberOfHorses,
        this.horses,
        this.returnDate,
        this.returnTime,
        this.notes,
        this.selectiveParent,
        this.isBelongToSelective,
        this.status});

  TransportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    transportCode = json['transportCode'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    type = json['type'];
    pickUpLocation = json['pickUpLocation'];
    pickPlace = json['pickPlace'] != null
        ? PickPlace.fromJson(json['pickPlace'])
        : null;
    dropLocation = json['dropLocation'];
    dropPlace = json['dropPlace'] != null
        ? PickPlace.fromJson(json['dropPlace'])
        : null;
    pickUpDate = json['pickUpDate'];
    pickUpTime = json['pickUpTime'];
    dropPhoneNumber = json['dropPhoneNumber'];
    pickUpPhoneNumber = json['pickUpPhoneNumber'];
    pickUpContactName = json['pickUpContactName'];
    dropContactName = json['dropContactName'];
    numberOfHorses = json['numberOfHorses'];
    if (json['horses'] != null) {
      horses = <Horses>[];
      json['horses'].forEach((v) {
        horses!.add(Horses.fromJson(v));
      });
    }
    returnDate = json['returnDate'];
    returnTime = json['returnTime'];
    notes = json['notes'];
    status = json['status'];
    selectiveParent = json['selectiveParent'];
    isBelongToSelective = json['isBelongToSelective'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['transportCode'] = transportCode;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['type'] =type;
    data['pickUpLocation'] = pickUpLocation;
    if (pickPlace != null) {
      data['pickPlace'] = pickPlace!.toJson();
    }
    data['dropLocation'] = dropLocation;
    if (dropPlace != null) {
      data['dropPlace'] = dropPlace!.toJson();
    }
    data['pickUpDate'] = pickUpDate;
    data['pickUpTime'] = pickUpTime;
    data['dropPhoneNumber'] = dropPhoneNumber;
    data['pickUpPhoneNumber'] = pickUpPhoneNumber;
    data['pickUpContactName'] = pickUpContactName;
    data['dropContactName'] = dropContactName;
    data['numberOfHorses'] = numberOfHorses;
    if (horses != null) {
      data['horses'] = horses!.map((v) => v.toJson()).toList();
    }
    data['returnDate'] = returnDate;
    data['returnTime'] = returnTime;
    data['notes'] = notes;
    data['status'] = status;
    data['selectiveParent'] = selectiveParent;
    data['isBelongToSelective'] = isBelongToSelective;
    return data;
  }
}

class User {
  int? id;
  String? email;
  String? phoneNumber;
  List<String>? roles;
  String? firstName;
  String? lastName;
  String? middleName;
  String? gender;
  String? salutation;
  String? nationality;
  String? accessToken;
  String? refreshToken;
  Steps? steps;
  String? userName;
  bool? verifiedEmail;
  bool? verifiedPhoneNumber;
  bool? isBlocked;
  String? image;
  int? mainStableId;
  MainStable? mainStable;
  int? mainDisciplineId;
  MainDiscipline? mainDiscipline;
  String? displayName;
  String? address;
  String? country;
  String? state;
  String? city;
  String? secondNumber;
  Account? account;

  User(
      {this.id,
        this.email,
        this.phoneNumber,
        this.roles,
        this.firstName,
        this.lastName,
        this.middleName,
        this.gender,
        this.nationality,
        this.accessToken,
        this.refreshToken,
        this.steps,
        this.userName,
        this.salutation,
        this.verifiedEmail,
        this.verifiedPhoneNumber,
        this.isBlocked,
        this.image,
        this.mainStableId,
        this.mainStable,
        this.mainDisciplineId,
        this.mainDiscipline,
        this.displayName,
        this.address,
        this.country,
        this.state,
        this.city,
        this.secondNumber,
        this.account});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    roles = json['roles'].cast<String>();
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
    salutation = json['salutation'];
    gender = json['gender'];
    nationality = json['nationality'];
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    steps = json['steps'] != null ? Steps.fromJson(json['steps']) : null;
    userName = json['userName'];
    verifiedEmail = json['verifiedEmail'];
    verifiedPhoneNumber = json['verifiedPhoneNumber'];
    isBlocked = json['isBlocked'];
    image = json['image'];
    mainStableId = json['mainStableId'];
    mainStable = json['mainStable'] != null
        ? MainStable.fromJson(json['mainStable'])
        : null;
    mainDisciplineId = json['mainDisciplineId'];
    mainDiscipline = json['mainDiscipline'] != null
        ? MainDiscipline.fromJson(json['mainDiscipline'])
        : null;
    displayName = json['displayName'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    secondNumber = json['secondNumber'];
    account =
    json['account'] != null ? Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['roles'] = roles;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['middleName'] = middleName;
    data['gender'] = gender;
    data['salutation'] = salutation;
    data['nationality'] = nationality;
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    if (steps != null) {
      data['steps'] = steps!.toJson();
    }
    data['userName'] = userName;
    data['verifiedEmail'] = verifiedEmail;
    data['verifiedPhoneNumber'] = verifiedPhoneNumber;
    data['isBlocked'] = isBlocked;
    data['image'] = image;
    data['mainStableId'] = mainStableId;
    if (mainStable != null) {
      data['mainStable'] = mainStable!.toJson();
    }
    data['mainDisciplineId'] = mainDisciplineId;
    if (mainDiscipline != null) {
      data['mainDiscipline'] = mainDiscipline!.toJson();
    }
    data['displayName'] = displayName;
    data['address'] = address;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['secondNumber'] = secondNumber;
    if (account != null) {
      data['account'] = account!.toJson();
    }
    return data;
  }
}

class PickPlace {
  int? id;
  String? name;
  String? code;
  String? lng;
  String? lat;
  String? category;
  int? createdBy;
  String? status;

  PickPlace(
      {this.id, this.name, this.lng, this.lat, this.category, this.createdBy,this.status,this.code});

  PickPlace.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    lng = json['lng'];
    lat = json['lat'];
    category = json['category'];
    createdBy = json['createdBy'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['lng'] = lng;
    data['lat'] = lat;
    data['category'] = category;
    data['createdBy'] = createdBy;
    data['status'] = status;
    return data;
  }
}

class Horses {
  int? id;
  int? horseId;
  Horse? horse;

  Horses({this.id, this.horseId, this.horse});

  Horses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    horseId = json['horseId'];
    horse = json['horse'] != null ? Horse.fromJson(json['horse']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['horseId'] = horseId;
    if (horse != null) {
      data['horse'] = horse!.toJson();
    }
    return data;
  }
}

class Horse {
  int? id;
  int? userId;
  User? user;
  int? disciplineId;
  MainDiscipline? discipline;
  int? stableId;
  MainStable? stable;
  String? name;
  int? age;
  String? image;
  String? status;
  String? dateOfBirth;
  String? placeOfBirth;
  String? color;
  String? gender;
  String? bloodLine;
  String? breed;
  String? horseProofOwnership;
  String? horseNationalPassport;
  String? horseFEIPassport;
  String? horseSire;
  String? horseDam;
  String? horseDamSire;
  String? horseMicrochipCode;
  String? horseNote;
  bool? isPony;
  bool? isVerified;
  bool? isSportHorse;
  bool? isDommy;

  Horse(
      {this.id,
        this.userId,
        this.user,
        this.disciplineId,
        this.discipline,
        this.stableId,
        this.stable,
        this.name,
        this.age,
        this.image,
        this.status,
        this.dateOfBirth,
        this.placeOfBirth,
        this.color,
        this.gender,
        this.bloodLine,
        this.breed,
        this.horseProofOwnership,
        this.horseNationalPassport,
        this.horseFEIPassport,
        this.horseSire,
        this.horseDam,
        this.horseDamSire,
        this.horseMicrochipCode,
        this.horseNote,
        this.isPony,
        this.isVerified,
        this.isSportHorse,
        this.isDommy});

  Horse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    disciplineId = json['disciplineId'];
    discipline = json['discipline'] != null
        ? MainDiscipline.fromJson(json['discipline'])
        : null;
    stableId = json['stableId'];
    stable =
    json['stable'] != null ? MainStable.fromJson(json['stable']) : null;
    name = json['name'];
    age = json['age'];
    image = json['image'];
    status = json['status'];
    dateOfBirth = json['dateOfBirth'];
    placeOfBirth = json['placeOfBirth'];
    color = json['color'];
    gender = json['gender'];
    bloodLine = json['bloodLine'];
    breed = json['breed'];
    horseProofOwnership = json['horseProofOwnership'];
    horseNationalPassport = json['horseNationalPassport'];
    horseFEIPassport = json['horseFEIPassport'];
    horseSire = json['horseSire'];
    horseDam = json['horseDam'];
    horseDamSire = json['horseDamSire'];
    horseMicrochipCode = json['horseMicrochipCode'];
    horseNote = json['horseNote'];
    isPony = json['isPony'];
    isVerified = json['isVerified'];
    isSportHorse = json['isSportHorse'];
    isDommy = json['isDommy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['disciplineId'] = disciplineId;
    if (discipline != null) {
      data['discipline'] = discipline!.toJson();
    }
    data['stableId'] = stableId;
    if (stable != null) {
      data['stable'] = stable!.toJson();
    }
    data['name'] = name;
    data['age'] = age;
    data['image'] = image;
    data['status'] = status;
    data['dateOfBirth'] = dateOfBirth;
    data['placeOfBirth'] = placeOfBirth;
    data['color'] = color;
    data['gender'] = gender;
    data['bloodLine'] = bloodLine;
    data['breed'] = breed;
    data['horseProofOwnership'] = horseProofOwnership;
    data['horseNationalPassport'] = horseNationalPassport;
    data['horseFEIPassport'] = horseFEIPassport;
    data['horseSire'] = horseSire;
    data['horseDam'] = horseDam;
    data['horseDamSire'] = horseDamSire;
    data['horseMicrochipCode'] = horseMicrochipCode;
    data['horseNote'] = horseNote;
    data['isPony'] = isPony;
    data['isVerified'] = isVerified;
    data['isSportHorse'] = isSportHorse;
    data['isDommy'] = isDommy;
    return data;
  }
}