import 'package:proequine/core/CoreModels/base_result_model.dart';

import '../../associations/data/horse_associated_requests_response_model.dart';

class AllHorseDocumentsResponseModel extends BaseResultModel {
  int? count;
  List<HorseDocuments>? rows;

  AllHorseDocumentsResponseModel({this.count, this.rows});

  AllHorseDocumentsResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <HorseDocuments>[];
      json['rows'].forEach((v) {
        rows!.add(HorseDocuments.fromJson(v));
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

class HorseDocuments {
  int? id;
  int? horseId;
  Horse? horse;
  String? docNumber;
  String? docCategory;
  String? docType;
  String? docRegistrationData;
  String? docExpiryDate;
  String? docAttachment;
  String? docNotes;
  String? docTitle;

  HorseDocuments(
      {this.id,
      this.horseId,
      this.horse,
      this.docNumber,
      this.docCategory,
      this.docType,
      this.docRegistrationData,
      this.docExpiryDate,
      this.docAttachment,
      this.docNotes,
      this.docTitle});

  HorseDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    horseId = json['horseId'];
    horse = json['horse'] != null ? Horse.fromJson(json['horse']) : null;
    docNumber = json['docNumber'];
    docCategory = json['docCategory'];
    docType = json['docType'];
    docRegistrationData = json['docRegistrationData'];
    docExpiryDate = json['docExpiryDate'];
    docAttachment = json['docAttachment'];
    docNotes = json['docNotes'];
    docTitle = json['docTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['horseId'] = horseId;
    if (horse != null) {
      data['horse'] = horse!.toJson();
    }
    data['docNumber'] = docNumber;
    data['docCategory'] = docCategory;
    data['docType'] = docType;
    data['docRegistrationData'] = docRegistrationData;
    data['docExpiryDate'] = docExpiryDate;
    data['docAttachment'] = docAttachment;
    data['docNotes'] = docNotes;
    data['docTitle'] = docTitle;
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
