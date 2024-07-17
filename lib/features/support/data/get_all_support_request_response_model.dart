import 'package:proequine/core/CoreModels/base_result_model.dart';

class GetAllSupportRequestResponseModel extends BaseResultModel{
  int? count;
  List<SupportRequestModel>? rows;

  GetAllSupportRequestResponseModel({this.count, this.rows});

  GetAllSupportRequestResponseModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['rows'] != null) {
      rows = <SupportRequestModel>[];
      json['rows'].forEach((v) {
        rows!.add(SupportRequestModel.fromJson(v));
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

class SupportRequestModel {
  int? id;
  String? reference;
  int? userId;
  User? user;
  String? fullName;
  String? email;
  String? phone;
  String? subject;
  String? division;
  String? supportInquiry;
  String? supportStatus;
  String? supportResponse;
  String? userAssigned;
  String? supportInternalNote;
  String? createdOn;
  bool? sourceIsWebsite;
  bool? sourceIsApp;

  SupportRequestModel(
      {this.id,
        this.reference,
        this.userId,
        this.user,
        this.fullName,
        this.email,
        this.phone,
        this.subject,
        this.division,
        this.supportInquiry,
        this.supportStatus,
        this.supportResponse,
        this.userAssigned,
        this.createdOn,
        this.supportInternalNote,
        this.sourceIsWebsite,
        this.sourceIsApp});

  SupportRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    userId = json['userId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    subject = json['subject'];
    division = json['division'];
    supportInquiry = json['supportInquiry'];
    supportStatus = json['supportStatus'];
    supportResponse = json['supportResponse'];
    userAssigned = json['userAssigned'];
    createdOn = json['createdOn'];
    supportInternalNote = json['supportInternalNote'];
    sourceIsWebsite = json['sourceIsWebsite'];
    sourceIsApp = json['sourceIsApp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['userId'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['subject'] = this.subject;
    data['division'] = this.division;
    data['supportInquiry'] = this.supportInquiry;
    data['supportStatus'] = this.supportStatus;
    data['supportResponse'] = this.supportResponse;
    data['userAssigned'] = this.userAssigned;
    data['createdOn'] = this.createdOn;
    data['supportInternalNote'] = this.supportInternalNote;
    data['sourceIsWebsite'] = this.sourceIsWebsite;
    data['sourceIsApp'] = this.sourceIsApp;
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
    final Map<String, dynamic> data = <String, dynamic>{};
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