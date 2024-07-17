import 'package:proequine/core/CoreModels/base_result_model.dart';

class GetHorseRequestResponseModel extends BaseResultModel {
  int? count;
  List<RequestedHorseModel>? rows;

  GetHorseRequestResponseModel({this.count, this.rows});

  GetHorseRequestResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <RequestedHorseModel>[];
      json['rows'].forEach((v) {
        rows!.add(RequestedHorseModel.fromJson(v));
      });
    }
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestedHorseModel {
  int? id;
  int? fromUser;
  int? horseId;
  FUser? fUser;
  int? toUser;
  FUser? tUser;
  Horse? horse;
  String? status;
  String? type;

  RequestedHorseModel(
      {this.id,
        this.fromUser,
        this.horseId,
        this.fUser,
        this.toUser,
        this.tUser,
        this.horse,
        this.status,
        this.type});

  RequestedHorseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromUser = json['fromUser'];
    horseId = json['horseId'];
    fUser = json['fUser'] != null ? new FUser.fromJson(json['fUser']) : null;
    toUser = json['toUser'];
    tUser = json['tUser'] != null ? new FUser.fromJson(json['tUser']) : null;
    horse = json['horse'] != null ? new Horse.fromJson(json['horse']) : null;
    status = json['status'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fromUser'] = this.fromUser;
    data['horseId'] = this.horseId;
    if (this.fUser != null) {
      data['fUser'] = this.fUser!.toJson();
    }
    data['toUser'] = this.toUser;
    if (this.tUser != null) {
      data['tUser'] = this.tUser!.toJson();
    }
    if (this.horse != null) {
      data['horse'] = this.horse!.toJson();
    }
    data['status'] = this.status;
    data['type'] = this.type;
    return data;
  }
}

class FUser {
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

  FUser(
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

  FUser.fromJson(Map<String, dynamic> json) {
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
    steps = json['steps'] != null ? new Steps.fromJson(json['steps']) : null;
    userName = json['userName'];
    verifiedEmail = json['verifiedEmail'];
    verifiedPhoneNumber = json['verifiedPhoneNumber'];
    isBlocked = json['isBlocked'];
    image = json['image'];
    mainStableId = json['mainStableId'];
    mainStable = json['mainStable'] != null
        ? new MainStable.fromJson(json['mainStable'])
        : null;
    mainDisciplineId = json['mainDisciplineId'];
    mainDiscipline = json['mainDiscipline'] != null
        ? new MainDiscipline.fromJson(json['mainDiscipline'])
        : null;
    displayName = json['displayName'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    secondNumber = json['secondNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['roles'] = this.roles;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['middleName'] = this.middleName;
    data['gender'] = this.gender;
    data['nationality'] = this.nationality;
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    if (this.steps != null) {
      data['steps'] = this.steps!.toJson();
    }
    data['userName'] = this.userName;
    data['verifiedEmail'] = this.verifiedEmail;
    data['verifiedPhoneNumber'] = this.verifiedPhoneNumber;
    data['isBlocked'] = this.isBlocked;
    data['image'] = this.image;
    data['mainStableId'] = this.mainStableId;
    if (this.mainStable != null) {
      data['mainStable'] = this.mainStable!.toJson();
    }
    data['mainDisciplineId'] = this.mainDisciplineId;
    if (this.mainDiscipline != null) {
      data['mainDiscipline'] = this.mainDiscipline!.toJson();
    }
    data['displayName'] = this.displayName;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['secondNumber'] = this.secondNumber;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAddMainDiscipline'] = this.isAddMainDiscipline;
    data['isAddMainStable'] = this.isAddMainStable;
    data['isAddUserName'] = this.isAddUserName;
    data['isAddRole'] = this.isAddRole;
    data['isVerifiedPhoneNumber'] = this.isVerifiedPhoneNumber;
    data['isVerifiedEmail'] = this.isVerifiedEmail;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['emirate'] = this.emirate;
    data['pinLocation'] = this.pinLocation;
    data['status'] = this.status;
    data['showOnApp'] = this.showOnApp;
    data['createdBy'] = this.createdBy;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['code'] = this.code;
    return data;
  }
}

class Horse {
  int? id;
  int? userId;
  FUser? user;
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

  Horse(
      {this.id,
        this.userId,
        this.user,
        this.disciplineId,
        this.discipline,
        this.stableId,
        this.stable,
        this.name,
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
        this.horseFEIPassport});

  Horse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    user = json['user'] != null ? new FUser.fromJson(json['user']) : null;
    disciplineId = json['disciplineId'];
    discipline = json['discipline'] != null
        ? new MainDiscipline.fromJson(json['discipline'])
        : null;
    stableId = json['stableId'];
    stable =
    json['stable'] != null ? new MainStable.fromJson(json['stable']) : null;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['disciplineId'] = this.disciplineId;
    if (this.discipline != null) {
      data['discipline'] = this.discipline!.toJson();
    }
    data['stableId'] = this.stableId;
    if (this.stable != null) {
      data['stable'] = this.stable!.toJson();
    }
    data['name'] = this.name;
    data['age'] = this.age;
    data['image'] = this.image;
    data['status'] = this.status;
    data['dateOfBirth'] = this.dateOfBirth;
    data['placeOfBirth'] = this.placeOfBirth;
    data['color'] = this.color;
    data['gender'] = this.gender;
    data['bloodLine'] = this.bloodLine;
    data['breed'] = this.breed;
    data['horseProofOwnership'] = this.horseProofOwnership;
    data['horseNationalPassport'] = this.horseNationalPassport;
    data['horseFEIPassport'] = this.horseFEIPassport;
    return data;
  }
}