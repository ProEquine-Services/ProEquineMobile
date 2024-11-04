import 'package:equatable/equatable.dart';

import '../../../core/CoreModels/base_result_model.dart';

class HorsesResponseModel extends BaseResultModel {
  int? count;
  List<Horse>? rows;

  HorsesResponseModel({this.count, this.rows});

  HorsesResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <Horse>[];
      json['rows'].forEach((v) {
        rows!.add(Horse.fromJson(v));
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

class Horse extends Equatable {
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
  String? docsRequestDate;
  String? uELNCode;
  String? fEId;

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
      this.isDommy,
      this.docsRequestDate,
      this.uELNCode,
      this.fEId});

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
    docsRequestDate = json['docsRequestDate'];
    uELNCode = json['UELNCode'];
    fEId = json['FEId'];
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
    data['docsRequestDate'] = docsRequestDate;
    data['UELNCode'] = uELNCode;
    data['FEId'] = fEId;

    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, image, status];
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
      this.secondNumber});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    roles = json['roles'].cast<String>();
    firstName = json['firstName'];
    lastName = json['lastName'];
    middleName = json['middleName'];
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
    return data;
  }
}

class Steps {
  bool? isAddMainDiscipline;
  bool? isAddMainStable;
  bool? isAddUserName;
  bool? isAddRole;
  bool? isVerifiedPhoneNumber;
  bool? isVerifiedEmail;

  Steps(
      {this.isAddMainDiscipline,
      this.isAddMainStable,
      this.isAddUserName,
      this.isAddRole,
      this.isVerifiedPhoneNumber,
      this.isVerifiedEmail});

  Steps.fromJson(Map<String, dynamic> json) {
    isAddMainDiscipline = json['isAddMainDiscipline'];
    isAddMainStable = json['isAddMainStable'];
    isAddUserName = json['isAddUserName'];
    isAddRole = json['isAddRole'];
    isVerifiedPhoneNumber = json['isVerifiedPhoneNumber'];
    isVerifiedEmail = json['isVerifiedEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isAddMainDiscipline'] = isAddMainDiscipline;
    data['isAddMainStable'] = isAddMainStable;
    data['isAddUserName'] = isAddUserName;
    data['isAddRole'] = isAddRole;
    data['isVerifiedPhoneNumber'] = isVerifiedPhoneNumber;
    data['isVerifiedEmail'] = isVerifiedEmail;
    return data;
  }
}

class MainStable {
  int? id;
  String? name;
  String? emirate;
  String? pinLocation;
  String? status;
  bool? showOnApp;
  int? createdBy;

  MainStable(
      {this.id,
      this.name,
      this.emirate,
      this.pinLocation,
      this.status,
      this.showOnApp,
      this.createdBy});

  MainStable.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    emirate = json['emirate'];
    pinLocation = json['pinLocation'];
    status = json['status'];
    showOnApp = json['showOnApp'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['emirate'] = emirate;
    data['pinLocation'] = pinLocation;
    data['status'] = status;
    data['showOnApp'] = showOnApp;
    data['createdBy'] = createdBy;
    return data;
  }
}

class MainDiscipline {
  int? id;
  String? title;
  String? code;

  MainDiscipline({this.id, this.title, this.code});

  MainDiscipline.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['code'] = code;
    return data;
  }
}
